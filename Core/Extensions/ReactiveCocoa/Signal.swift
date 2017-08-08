//
//  Signal.swift
//  Core
//
//  Created by Francisco Depascuali on 6/29/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import ReactiveSwift
import Result

public extension Signal {
    
    /**
         Transforms a `Signal<Value, Error>` to `Signal<Value, NewError>`.
         This is usually useful when the `flatMap` operator is used and the outer
         signal has `NoError` error type and the inner one a different type of error.
         
         - returns: A signal with the same value type but with `NewError` as the error type
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
        return filter { $0 is T }.map { $0 as! T }  //swiftlint:disable:this force_cast
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
            if let _ = $0.value {
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
            if let _ = $0.error {
                return true
            }
            return false
        }.map { $0.error! }
    }
    
}
