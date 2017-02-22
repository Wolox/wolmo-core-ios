//
//  Date.swift
//  Core
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

internal let DefaultDateFormatter: DateFormatter = {
    $0.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    $0.dateFormat = "yyyy-MM-dd"
    $0.locale = Locale(identifier: "en_US_POSIX")
    return $0
}(DateFormatter())

internal let DefaultWeekDateFormatter: DateFormatter = {
    $0.setLocalizedDateFormatFromTemplate("EEEE")
    return $0
}(DateFormatter())

public extension Date {
    
    /**
     Returns a Date with right now's time and date.
     
     - seealso: NSDate.init()
    */
    public static func now() -> Date {
        return Date()
    }
    
    /**
     Returns the hours from a date.
        
     - parameter calendar: the calendar to get the date components from. 
     Default: current user calendar.
     
     - seealso: NSCalendar().component()
     - returns: An Int value representing the hours, between 0 - 24.
     */
    public func hours(using calendar: Calendar = .current) -> Int {
       return calendar.component(.hour, from: self)
    }
    
    /**
     Returns the minutes from a date.
     
     - parameter calendar: the calendar to get the date components from. 
     Default: current user calendar.
     
     - seealso: NSCalendar().component()
     - returns: An Int value representing the minutes, between 0 - 60.
     */
    public func minutes(using calendar: Calendar = .current) -> Int {
        return calendar.component(.minute, from: self)
    }
    
    /**
     Returns the seconds from a date.
     
     - parameter calendar: the calendar to get the date components from. 
     Default: current user calendar.
     
     - seealso: NSCalendar().component()
     - returns: An Int value representing the seconds, between 0 - 60.
     */
    public func seconds(using calendar: Calendar = .current) -> Int {
        return calendar.component(.second, from: self)
    }
    
    /**
     Returns the date components specified by `units` from a date.
     
     - parameter units: The units to retrieve. ex: .Second
     - parameter calendar: the calendar to get the date components from. 
     Default: current user calendar.
     
     - seealso: NSCalendar().dateComponents()
     - note: You could pass an array to units, such as [.Hour, .Second] to 
     retrieve both components at the same time.
     - returns: The requested date components.
     */
    public func components(_ units: Set<Calendar.Component>, using calendar: Calendar = .current) -> DateComponents {
        return calendar.dateComponents(units, from: self)
    }
    
    /**
     Creates a Date from a string.
     
     - parameter dateString: The date string representation.
     - parameter dateFormatter: The formatter used for initializing the date.
            By default, formatter which uses format "yyyy-MM-dd" and US locale.
     */
    public init?(dateString: String, dateFormatter: DateFormatter = DefaultDateFormatter) {
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        self.init(timeInterval: 0, since: date)
    }
    
    /**
     Creates a Date from a string and a string format.
     
     - parameter dateString: The date string representation.
     - parameter formatString: The format string used for initializing the date.
     */
    public init?(dateString: String, formatString: String) {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate(formatString)
        self.init(dateString: dateString, dateFormatter: formatter)
    }
    
    /**
     Creates a Date from a day, month and year.
     
     - seealso: init(dateString: String)
     */
    public init?(day: Int, month: Int, year: Int) {
        var monthString: String = "\(month)"
        var dayString: String = "\(day)"
        if month < 10 {
            monthString = "0\(month)"
        }
        if day < 10 {
            dayString = "0\(day)"
        }
        self.init(dateString: "\(year)-\(monthString)-\(dayString)")
    }
    
    /**
     Returns the current day of the week (ex: Monday).
     
     - parameter dateFormatter: The dateFormatter to use.
     */
    public func getWeekDay(withFormat dateFormatter: DateFormatter = DefaultWeekDateFormatter) -> String {
        return dateFormatter.string(from: self)
    }
    
    /**
     Returns a new date that is set to a given number of days relative to the date.
     
     - seealso: dateByAddingTimeInterval()
     */
    public func adding(days: Int) -> Date {
        let secondsInDays = Double(days) * 60 * 60 * 24
        return addingTimeInterval(secondsInDays)
    }
    
    /**
     Returns a new date that is set to a given number of hours relative to the date.
     
     - seealso: dateByAddingTimeInterval()
     */
    public func adding(hours: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hours) * 60 * 60
        return addingTimeInterval(secondsInHours)
    }
    
    /**
     Returns a the string representation of self with the format specified in the dateFormatter.
     By default, uses a formatter with format "yyyy-MM-dd" and US locale.
     */
    public func toString(accordingTo dateFormatter: DateFormatter = DefaultDateFormatter) -> String {
        return dateFormatter.string(from: self)
    }
    
    /**
     Returns a the string representation of self with the format specified.
     */
    public func toString(with format: String) -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate(format)
        return toString(accordingTo: formatter)
    }
    
}
