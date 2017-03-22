//
//  DateSpec.swift
//  Core
//
//  Created by Francisco Depascuali on 7/18/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import Foundation

import Quick
import Nimble
import Core

private let DefaultDateFormatter: DateFormatter = {
    $0.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    $0.dateFormat = "yyyy-MM-dd"
    $0.locale = Locale(identifier: "en_US_POSIX")
    return $0
}(DateFormatter())

private let DefaultTimeFormatter: DateFormatter = {
    $0.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    $0.dateFormat = "HH:mm:ss"
    $0.locale = Locale(identifier: "en_US_POSIX")
    return $0
}(DateFormatter())

private let DefaultDayAndTimeFormatter: DateFormatter = {
    $0.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
    $0.dateFormat = "yyyy-MM-dd HH:mm:ss"
    $0.locale = Locale(identifier: "en_US_POSIX")
    return $0
}(DateFormatter())

private let week: [Date] = {
    var week: [Date] = []
    let monday = DefaultDateFormatter.date(from: "2016-07-25")!
    
    for dateIterator in 0...6 {
        let date = (Calendar.current as NSCalendar)
            .date(
                byAdding: .day,
                value: dateIterator,
                to: monday,
                options: [])
        
        week.append(date!)
    }
    
    return week
}()

public class DateSpec: QuickSpec {
    
    override public func spec() {
        
        describe("#now") {
            
            it("should return the current date") {
                let normal_now = Date()
                let new_now = Date.now()
                expect(DefaultDateFormatter.string(from: new_now))
                    .to(equal(DefaultDateFormatter.string(from: normal_now)))
            }
            
        }
        
        describe("#hours(using:)") {
            
            it("should return the hours of the date") {
                let dateString = "11:20:30"
                let date = DefaultTimeFormatter.date(from: dateString)!
                let hours = date.hours()
                expect(hours).to(equal(11))
            }
            
        }
        
        describe("#minutes(using:)") {
            
            it("should return the minutes of the date") {
                let dateString = "10:02:01"
                let date = DefaultTimeFormatter.date(from: dateString)!
                let hours = date.minutes()
                expect(hours).to(equal(2))
            }
            
        }
        
        describe("#seconds(using:)") {
            
            it("should return the seconds of the date") {
                let dateString = "08:59:21"
                let date = DefaultTimeFormatter.date(from: dateString)!
                let hours = date.seconds()
                expect(hours).to(equal(21))
            }
            
        }
        
        describe("#day(using:)") {
            
            it("should return the day of month of the date") {
                let dateString = "1992-12-18"
                let date = DefaultDateFormatter.date(from: dateString)!
                let hours = date.day()
                expect(hours).to(equal(18))
            }
            
        }
        
        describe("#month(using:)") {
            
            it("should return the month of the date") {
                let dateString = "1992-12-18"
                let date = DefaultDateFormatter.date(from: dateString)!
                let hours = date.month()
                expect(hours).to(equal(12))
            }
            
        }
        
        describe("#year(using:)") {
            
            it("should return the year of the date") {
                let dateString = "1992-12-18"
                let date = DefaultDateFormatter.date(from: dateString)!
                let hours = date.year()
                expect(hours).to(equal(1992))
            }
            
        }
        
        describe("#components(_:using:)") {
            
            it("should give us all the components asked for") {
                let dateString = "2016-01-24 08:59:21"
                let date = DefaultDayAndTimeFormatter.date(from: dateString)!
                let components = date.components([.hour, .day, .minute, .month, .calendar])
                expect(components.hour).toNot(beNil())
                expect(components.day).toNot(beNil())
                expect(components.minute).toNot(beNil())
                expect(components.month).toNot(beNil())
                expect(components.calendar).toNot(beNil())
                
                expect(components.hour).to(equal(8))
                expect(components.day).to(equal(24))
                expect(components.minute).to(equal(59))
                expect(components.month).to(equal(1))
                expect(components.calendar!.identifier).to(equal(Calendar.Identifier.gregorian))
            }
            
            it("shouldn't give us the component that weren't asked for") {
                let dateString = "2016-01-24 08:59:21"
                let date = DefaultDayAndTimeFormatter.date(from: dateString)!
                let components = date.components([.hour, .day, .minute, .month, .calendar])
                expect(components.second).to(beNil())
                expect(components.year).to(beNil())
                expect(components.era).to(beNil())
                expect(components.nanosecond).to(beNil())
                expect(components.quarter).to(beNil())
                expect(components.timeZone).to(beNil())
                expect(components.weekday).to(beNil())
                expect(components.weekdayOrdinal).to(beNil())
                expect(components.weekOfMonth).to(beNil())
                expect(components.weekOfYear).to(beNil())
                expect(components.yearForWeekOfYear).to(beNil())
            }
            
        }
        
        describe("#init(dateString:dateFormatter:)") {
                
            context("When using the default formatter") {
                
                context("When the format is correct") {
                    
                    var date: Date?
                    
                    beforeEach {
                        date = Date(dateString: "1992-12-18")
                    }
                    
                    it("should be a Date") {
                        expect(date).toNot(beNil())
                    }
                    
                    it("should have the correct day") {
                        expect(date!.day()).to(equal(18))
                    }
                    
                    it("should have the correct month") {
                        expect(date!.month()).to(equal(12))
                    }
                    
                    it("should have the correct year") {
                        expect(date!.year()).to(equal(1992))
                    }
                    
                    it("should have hours in 00") {
                        expect(date!.hours()).to(equal(0))
                    }
                    
                    it("should have minutes in 00") {
                        expect(date!.minutes()).to(equal(0))
                    }
                    
                    it("should have seconds in 00") {
                        expect(date!.seconds()).to(equal(0))
                    }
                    
                }
                
                context("When the format is incorrect") {
                    
                    it("should be nil") {
                        let date = Date(dateString: "18/12/1992")
                        expect(date).to(beNil())
                    }
                    
                }
                
            }
            
            context("When using another formatter") {
                
                context("When the format is correct") {
                    
                    var date: Date?
                    
                    beforeEach {
                        date = Date(dateString: "1992-12-18 21:02:44",
                                    dateFormatter: DefaultDayAndTimeFormatter)
                    }
                    
                    it("should be a Date") {
                        expect(date).toNot(beNil())
                    }
                    
                    it("should have the correct day") {
                        expect(date!.day()).to(equal(18))
                    }
                    
                    it("should have the correct month") {
                        expect(date!.month()).to(equal(12))
                    }
                    
                    it("should have the correct year") {
                        expect(date!.year()).to(equal(1992))
                    }
                    
                    it("should have the correct hours") {
                        expect(date!.hours()).to(equal(21))
                    }
                    
                    it("should have the correct minutes") {
                        expect(date!.minutes()).to(equal(2))
                    }
                    
                    it("should have the correct seconds") {
                        expect(date!.seconds()).to(equal(44))
                    }
                    
                }
                
                context("When the format is incorrect") {
                    
                    it("should be nil") {
                        let date = Date(dateString: "1992-12-18", dateFormatter: DefaultDayAndTimeFormatter)
                        expect(date).to(beNil())
                    }
                    
                }
                
            }
            
        }
        
        describe("#init(dateString:formatString:)") {
            
            var date: Date?
            
            context("when the format is correct") {
                
                beforeEach {
                    date = Date(dateString: "1992-12-18 21:02:12", formatString: "yyyy-MM-dd ss:mm:HH")
                }
                
                it("should be a Date") {
                    expect(date).toNot(beNil())
                }
                
                it("should have the correct day") {
                    expect(date!.day()).to(equal(18))
                }
                
                it("should have the correct month") {
                    expect(date!.month()).to(equal(12))
                }
                
                it("should have the correct year") {
                    expect(date!.year()).to(equal(1992))
                }
                
                it("should have the correct hours") {
                    expect(date!.hours()).to(equal(12))
                }
                
                it("should have the correct minutes") {
                    expect(date!.minutes()).to(equal(2))
                }
                
                it("should have the correct seconds") {
                    expect(date!.seconds()).to(equal(21))
                }
                
            }
            
            context("when the format is incorrect") {
                
                beforeEach {
                    date = Date(dateString: "18/12/1992", formatString: "yyyy-MM-dd ss:mm:HH")
                }
                
                it("should be nil") {
                    expect(date).to(beNil())
                }
                
            }
            
        }
        
        describe("#init(day:month:year:)") {
            
            var date: Date?
            
            context("when arguments are valid") {
                
                beforeEach {
                    date = Date(day: 18, month: 12, year: 1992)
                }
                
                it("should be a Date") {
                    expect(date).toNot(beNil())
                }
                
                it("should have the correct day") {
                    expect(date!.day()).to(equal(18))
                }
                
                it("should have the correct month") {
                    expect(date!.month()).to(equal(12))
                }
                
                it("should have the correct year") {
                    expect(date!.year()).to(equal(1992))
                }
                
                it("should have hours in 00") {
                    expect(date!.hours()).to(equal(0))
                }
                
                it("should have minutes in 00") {
                    expect(date!.minutes()).to(equal(0))
                }
                
                it("should have seconds in 00") {
                    expect(date!.seconds()).to(equal(0))
                }
                
            }
            
            context("when arguments are invalid") {
                
                beforeEach {
                    date = Date(day: 62, month: 25, year: 1992)
                }
                
                it("should be a Date") {
                    expect(date).to(beNil())
                }
                
            }
            
        }
    
        describe("#getWeekDay(withFormat:)") {
    
            context("When getting the week day for every day in a week") {
    
                it("should match to the week made of date's string representation") {
    
                    let _week = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
                    
                    expect(week.map { $0.getWeekDay() }).to(equal(_week))
                }
            }
        }
        
        describe("#adding(days:)") {
            
            context("When adding one day to a week") {
                
                it("should return the new week") {
                    let newWeek = ["Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday", "Monday"]
                    let _newWeek = week
                        .map { $0.adding(days: 1) }
                        .map { $0.getWeekDay() }
                    expect(_newWeek).to(equal(newWeek))
                }
            }
        }
        
        describe("#adding(hours:)") {
            
            context("When adding hours in the same date") {
                
                it("should add the hours to the current hours") {
                    // mondays hours are 00:00.
                    let monday = week[0]
                    let newDate = monday.adding(hours: 18)
                    expect(newDate.hours()).to(equal(18))
                }
                
                it("should remain being the same date") {
                    // mondays hours are 00:00.
                    let monday = week[0]
                    let newDate = monday.adding(hours: 20)
                    expect(newDate.getWeekDay()).to(equal("Monday"))
                }
                
            }
            
            context("When adding hours and getting a new date") {
                
                it("should be the day after") {
                    // mondays hours are 00:00.
                    let monday = week[0]
                    let newDate = monday.adding(hours: 25)
                    expect(newDate.getWeekDay()).to(equal("Tuesday"))
                }
                
                it("should have the corresponding hours") {
                    // mondays hours are 00:00.
                    let monday = week[0]
                    let newDate = monday.adding(hours: 25)
                    expect(newDate.hours()).to(equal(1))
                }
            }
        }
        
        describe("#toString(accordingTo:)") {
            
            var dateString: String!
            var date: Date!
            
            beforeEach {
                dateString = "1992-04-12 21:55:17"
            }
            
            context("when using the default formatter") {
                
                beforeEach {
                    date = DefaultDayAndTimeFormatter.date(from: dateString)
                }
                
                it("should return the string with the format documented in function") {
                    let string = date.toString()
                    expect(string).to(equal("1992-04-12"))
                }
                
            }
            
            context("when using another formatter") {
                
                var formatter: DateFormatter!
                
                beforeEach {
                    dateString = "1992-04-12 21:55:17"
                    formatter = DefaultDayAndTimeFormatter
                    date = DefaultDayAndTimeFormatter.date(from: dateString)!
                }
                
                it("should return the string with the format specified in the formatter") {
                    let string = date.toString(accordingTo: formatter)
                    expect(string).to(equal(dateString))
                }
                
            }
            
        }
        
        describe("#toString(with:)") {
            
            var date: Date!
            
            beforeEach {
                let dateString = "1992-04-12 21:55:17"
                date = DefaultDayAndTimeFormatter.date(from: dateString)
            }
            
            context("when requiring day, month and year") {
                
                it("should return the string with the right format and date information") {
                    let string = date.toString(with: "dd/MM/yyyy")
                    expect(string).to(equal("12/04/1992"))
                }
                
            }
            
            context("when requiring time") {
                
                it("should return the string with the right format and time information") {
                    let string = date.toString(with: "HH ss    mm")
                    expect(string).to(equal("21 17    55"))
                }
                
            }
            
        }
        
        describe("#toString(withLocalized:)") {
            
            var date: Date!
            
            beforeEach {
                let dateString = "1992-04-12 21:55:17"
                date = DefaultDayAndTimeFormatter.date(from: dateString)
            }
            
            // The localized format based on template `yyyy-MM-dd ss:mm:HH`
            //  is `MM/dd/yyyy, HH:mm:ss` for default formatter.
            it("should return the string with the right format and time information") {
                let string = date.toString(withLocalized: "yyyy-MM-dd ss:mm:HH")
                expect(string).to(equal("04/12/1992, 21:55:17"))
            }
            
        }
        
    }
    
}
