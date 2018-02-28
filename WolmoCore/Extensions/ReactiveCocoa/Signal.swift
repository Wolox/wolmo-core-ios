//
//  Signal.swift
//  WolmoCore
//
//  Created by Francisco Depascuali on 6/29/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import ReactiveSwift
import Result

// Can't extend ResultProtocol to EventProtocol.
// Now Result-valued signals can de materialized and dematerialized.
extension Result: EventProtocol {

    public var event: Signal<Value, Error>.Event {
        if let value = value {
            return .value(value)
        } else {
            return .failed(error!)
        }
    }

}

public extension Signal {

    /**
     Ignores errors.
     This is usually useful when the `flatMap` operator is used and the outer
     signal has `NoError` error type and the inner one a different type of error.

     - returns: A signal with the same value type but with `NoError` as the error type
     */
    public func dropError() -> Signal<Value, NoError> {
        return flatMapError { _ in SignalProducer<Value, NoError>.empty }
    }

    /**
         Transforms a `Signal<Value, Error>` to `Signal<Value, NewError>`.
         This is usually useful when the `flatMap` operator is used and the outer
         signal has another error type and the inner one a different type of error.

         - returns: A signal with the same value type but with `NewError` as the error type
         - note: For transforming NoError to another error you can use `promoteError`
         - note: You can do this to avoid `.dropError().promoteError()` chaining
     */
    public func liftError<NewError>() -> Signal<Value, NewError> {
        return flatMapError { _ in SignalProducer<Value, NewError>.empty }
    }

    /**
        Transforms the `Signal<Value, Error>` to `Signal<Result<Value, Error>, NoError>`.
        This is usually useful when the `flatMap` triggers different signals
        which if failed shouldn't finish the whole result signal, stopping new signals
        from being triggered when a new value arrives at self.

        ```
        var loginSignal: Signal<(), NoError>

        loginSignal.flatMap(.Latest) { _ -> Signal<MyUser, MyError> in
            return authService.login()
        }
        ```

        It may be considered similar to the `events` signal of an `Action` (with only next and failed).
    */
    public func toResultSignal() -> Signal<Result<Value, Error>, NoError> {
        return map { Result<Value, Error>.success($0) }
            .flatMapError { error -> SignalProducer<Result<Value, Error>, NoError> in
                let errorValue = Result<Value, Error>.failure(error)
                return SignalProducer<Result<Value, Error>, NoError>(value: errorValue)
        }
    }

    /**
         Filters stream and only passes through the values that respond
         to the specific type, as elements of that specific type.

         - returns: A signal with value type T and the same error type.
     */
    public func filterType<T>() -> Signal<T, Error> {
        return filterMap { $0 as? T }
        //Can't restrict T to conform/inherit-from Value
    }

}

public extension Signal where Value: OptionalProtocol {

    /**
     Skips all not-nil values, sending only the .none values through.
     */
    public func skipNotNil() -> Signal<Value, Error> {
        return filter { $0.optional == nil }
    }

}

public extension Signal where Value: ResultProtocol {

    /**
        Transforms a `Signal<ResultProtocol<Value2, Error2>, Error>` to `Signal<Value2, Error>`,
        ignoring all `Error2` events.

        It may be considered similar to the `values` signal of an `Action`.
    */
    public func filterValues() -> Signal<Value.Value, Error> {
        return filter {
            if $0.value != nil {
                return true
            }
            return false
        }.map { $0.value! }
    }

    /**
         Transforms a `Signal<ResultProtocol<Value2, Error2>, Error>` to `Signal<Error2, Error>`,
         ignoring all `Value2` events.

         It may be considered similar to the `errors` signal of an `Action`.
     */
    public func filterErrors() -> Signal<Value.Error, Error> {
        return filter {
            if $0.error != nil {
                return true
            }
            return false
        }.map { $0.error! }
    }

}
