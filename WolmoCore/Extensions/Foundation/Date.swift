//
//  Date.swift
//  WolmoCore
//
//  Created by Guido Marucci Blas on 5/7/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

public let DefaultDateFormatter: DateFormatter = {
    $0.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    $0.dateFormat = "yyyy-MM-dd"
    $0.locale = Locale(identifier: "en_US_POSIX")
    return $0
}(DateFormatter())

public let DefaultWeekDateFormatter: DateFormatter = {
    $0.setLocalizedDateFormatFromTemplate("EEEE")
    return $0
}(DateFormatter())

public extension Date {
    /**
     Returns a Date with right now's time and date.
     
     - seealso: Date.init()
    */
    static func now() -> Date {
        return Date()
    }
    
    /**
     Returns the hours from a date.
        
     - parameter calendar: the calendar to get the date components from. 
     Default: current user calendar.
     
     - seealso: Calendar().component()
     - returns: An Int value representing the hours, between 0 - 24.
     */
    func hours(using calendar: Calendar = .current) -> Int {
       return calendar.component(.hour, from: self)
    }
    
    /**
     Returns the minutes from a date.
     
     - parameter calendar: the calendar to get the date components from. 
     Default: current user calendar.
     
     - seealso: Calendar().component()
     - returns: An Int value representing the minutes, between 0 - 60.
     */
    func minutes(using calendar: Calendar = .current) -> Int {
        return calendar.component(.minute, from: self)
    }
    
    /**
     Returns the seconds from a date.
     
     - parameter calendar: the calendar to get the date components from. 
     Default: current user calendar.
     
     - seealso: Calendar().component()
     - returns: An Int value representing the seconds, between 0 - 60.
     */
    func seconds(using calendar: Calendar = .current) -> Int {
        return calendar.component(.second, from: self)
    }
    
    /**
     Returns the day from a date.
     
     - parameter calendar: the calendar to get the date components from.
     Default: current user calendar.
     
     - seealso: Calendar().component()
     - returns: An Int value representing the day of month.
     */
    func day(using calendar: Calendar = .current) -> Int {
        return calendar.component(.day, from: self)
    }
    
    /**
     Returns the month from a date.
     
     - parameter calendar: the calendar to get the date components from.
     Default: current user calendar.
     
     - seealso: Calendar().component()
     - returns: An Int value representing the month.
     */
    func month(using calendar: Calendar = .current) -> Int {
        return calendar.component(.month, from: self)
    }
    
    /**
     Returns the year from a date.
     
     - parameter calendar: the calendar to get the date components from.
     Default: current user calendar.
     
     - seealso: Calendar().component()
     - returns: An Int value representing the year.
     */
    func year(using calendar: Calendar = .current) -> Int {
        return calendar.component(.year, from: self)
    }
    
    /**
     Returns the date components specified by `units` from a date.
     
     - parameter units: The units to retrieve. ex: .Second
     - parameter calendar: the calendar to get the date components from. 
     Default: current user calendar.
     
     - seealso: Calendar().dateComponents()
     - note: You could pass an array to units, such as [.Hour, .Second] to 
     retrieve both components at the same time.
     - returns: The requested date components.
     */
    func components(_ units: Set<Calendar.Component>, using calendar: Calendar = .current) -> DateComponents {
        return calendar.dateComponents(units, from: self)
    }
    
    /**
     Creates a Date from a string.
     
     - parameter dateString: The date string representation.
     - parameter dateFormatter: The formatter used for initializing the date.
            By default, formatter which uses format "yyyy-MM-dd" and US locale.
     */
    init?(dateString: String, dateFormatter: DateFormatter = DefaultDateFormatter) {
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
    init?(dateString: String, formatString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = formatString
        self.init(dateString: dateString, dateFormatter: formatter)
    }
    
    /**
     Creates a Date from a day, month and year.
     
     - seealso: init(dateString: String)
     */
    init?(day: Int, month: Int, year: Int) {
        let yearString = String(format: "%.4d", year)
        let monthString = String(format: "%.2d", month)
        let dayString = String(format: "%.2d", day)
        self.init(dateString: "\(yearString)-\(monthString)-\(dayString)")
    }
    
    /**
     Returns the current day of the week (ex: Monday).
     
     - parameter dateFormatter: The dateFormatter to use.
     */
    func getWeekDay(withFormat dateFormatter: DateFormatter = DefaultWeekDateFormatter) -> String {
        return dateFormatter.string(from: self)
    }
    
    /**
     Returns a new date that is set to a given number of days relative to the date.
     
     - seealso: dateByAddingTimeInterval()
     */
    func adding(days: Int) -> Date {
        let secondsInDays = Double(days) * 60 * 60 * 24
        return addingTimeInterval(secondsInDays)
    }
    
    /**
     Returns a new date that is set to a given number of hours relative to the date.
     
     - seealso: dateByAddingTimeInterval()
     */
    func adding(hours: Int) -> Date {
        let secondsInHours: TimeInterval = Double(hours) * 60 * 60
        return addingTimeInterval(secondsInHours)
    }
    
    /**
     Returns a the string representation of self with the format specified in the dateFormatter.
     By default, uses a formatter with format "yyyy-MM-dd" and US locale.
     */
    func toString(accordingTo dateFormatter: DateFormatter = DefaultDateFormatter) -> String {
        return dateFormatter.string(from: self)
    }
    
    /**
     Returns a the string representation of self with the format specified.
     */
    func toString(with format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return toString(accordingTo: formatter)
    }
    
    /**
     Returns a the string representation of self with the localized format
     created from the format specified.
     
     - seealso: Dateformatter.setLocalizedDateFormatFromTemplate
     */
    func toString(withLocalized formatToLocalize: String) -> String {
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate(formatToLocalize)
        return toString(accordingTo: formatter)
    }
}
