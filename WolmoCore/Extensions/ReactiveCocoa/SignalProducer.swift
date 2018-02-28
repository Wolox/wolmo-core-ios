//
//  SignalProducer.swift
//  WolmoCore
//
//  Created by Francisco Depascuali on 6/29/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import ReactiveSwift
import Result

public extension SignalProducer {
    
    /**
     Ignores errors.
     This is usually useful when the `flatMap` operator is used and the outer
     signal producer has `NoError` error type and the inner one a different type of error.

     - returns: A signal producer with the same value type but with `NoError` as the error type
     */
    public func dropError() -> SignalProducer<Value, NoError> {
        return flatMapError { _ in .empty }
    }

    /**
     Transforms a `Signal<Value, Error>` to `Signal<Value, NewError>`.
     This is usually useful when the `flatMap` operator is used and the outer
     signal producer has another error type and the inner one a different type of error.

     - returns: A signal producer with the same value type but with `NewError` as the error type
     - note: For transforming NoError to another error you can use `promoteError`
     - note: You can do this to avoid `.dropError().promoteError()` chaining
     */
    public func liftError<NewError>() -> SignalProducer<Value, NewError> {
        return flatMapError { _ in .empty }
    }
    
    /**
         Transforms the `SignalProducer<Value, Error>` to `SignalProducer<Result<Value, Error>, NoError>`.
         This is usually useful when the `flatMap` triggers different producers
         which if failed shouldn't finish the whole result producer, but we can't avoid stopping new producers
         from being triggered when a new value arrives at self.
     
         For example,
         ```
         var myProperty: MutableProperty<CLLocation>
     
         myProperty.producer.flatMap(.Latest) { clLocation -> SignalProducer<MyLocation, MyError> in
             return locationService.fetchLocation(clLocation)
         }
         ```
         can turn into
         ```
         var myProperty: MutableProperty<CLLocation>

         myProperty.producer.flatMap(.Latest) { clLocation -> SignalProducer<Result<MyLocation, MyError>, NoError> in
         return locationService.fetchLocation(clLocation).toResultSignalProducer()
         }
         ```
         
         It may be considered similar to the `events` signal of an `Action` (with only next and failed).
     */
    public func toResultSignalProducer() -> SignalProducer<Result<Value, Error>, NoError> {
        return map { Result<Value, Error>.success($0) }
            .flatMapError { error -> SignalProducer<Result<Value, Error>, NoError> in
                let errorValue = Result<Value, Error>.failure(error)
                return SignalProducer<Result<Value, Error>, NoError>(value: errorValue)
        }
    }

    /**
        Filters stream and only passes through the values that respond
        to the specific type, as elements of that specific type.
     
        - returns: A signal producer with value type T and the same error type.
    */
    public func filterType<T>() -> SignalProducer<T, Error> {
        return filter { $0 is T }.map { $0 as! T }  //swiftlint:disable:this force_cast
        //Can't restrict T to conform/inherit-from Value
    }

}

public extension SignalProducer where Value: OptionalProtocol {

    /**
        Skips all not-nil values, sending only the .none values through.
     */
    public func skipNotNil() -> SignalProducer<Value, Error> {
        return filter { $0.optional == nil }
    }

}

public extension SignalProducer where Value: ResultProtocol {
    
    /**
         Transforms a `SignalProducer<ResultProtocol<Value2, Error2>, Error>`
         to `SignalProducer<Value2, Error>`, ignoring all `Error2` events.
         
         It may be considered similar to the `values` signal of an `Action`,
         but for producers.
     */
    public func filterValues() -> SignalProducer<Value.Value, Error> {
        return filter {
            if $0.value != nil {
                return true
            }
            return false
        }.map { $0.value! }
    }
    
    /**
         Transforms a `SignalProducer<ResultProtocol<Value2, Error2>, Error>`
         to `SignalProducer<Error2, Error>`, ignoring all `Value2` events.
         
         It may be considered similar to the `errors` signal of an `Action`,
         but for producers.
     */
    public func filterErrors() -> SignalProducer<Value.Error, Error> {
        return filter {
            if $0.error != nil {
                return true
            }
            return false
        }.map { $0.error! }
    }
    
}
