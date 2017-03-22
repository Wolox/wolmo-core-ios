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

public class NSDateSpec: QuickSpec {
    
    override public func spec() {
        
        describe("#init") {
            
            context("When initializing a Date from a string") {
                
                context("When using the default formatter") {
                    
                    context("When the format is correct") {
                        
                        it("should be a Date") {
                            let date = Date(dateString: "1992-12-18")
                            expect(date).toNot(beNil())
                        }
                        
                        it("should have hours in 00") {
                            let date = Date(dateString: "1992-12-18")
                            expect(date!.hours()).to(equal(0))
                        }
                        
                        it("should have seconds in 00") {
                            let date = Date(dateString: "1992-12-18")
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
            }
        }
        
        describe("#getWeekDay") {
            
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
        
        describe("#<") {
            
            context("When left date is before right date") {
                
                context("When both dates are in the same week") {
                    
                    it("should return true") {
                        expect(week[1] < week[2]).to(beTrue())
                    }
                }
                
                context("When dates are in different weeks") {
                    
                    it("should return true") {
                        let comparison = week[2] < week[1].adding(days: 7)
                        expect(comparison).to(beTrue())
                    }
                }
            }
            
            context("When left date is after right date") {
                
                it("should return false") {
                    expect(week[2] < week[1]).to(beFalse())
                }
            }
        }
        
        describe("#>") {
            
            context("When left date is after right date") {
                
                context("When both dates are in the same week") {
                    
                    it("should return true") {
                        expect(week[2] > week[1]).to(beTrue())
                    }
                    
                }
                
                context("When dates are in different weeks") {
                    
                    it("should return true") {
                        let comparison = week[1].adding(days: 7) > week[2]
                        expect(comparison).to(beTrue())
                    }
                }
            }
            
            context("When left date is before right date") {
                
                it("should return false") {
                    expect(week[1] > week[2]).to(beFalse())
                }
            }
        }
        
        describe("#==") {
            
            context("When comparing equal dates") {
                
                it("should return true") {
                    let date = Date(dateString: "1992-12-18")
                    let _date = Date(day: 18, month: 12, year: 1992)
                    
                    expect(date == _date).to(beTrue())
                }
            }
            
            context("When comparing different dates") {
                
                it("should return false") {
                    let date = Date(dateString: "1992-12-17")
                    let _date = Date(day: 18, month: 12, year: 1992)
                    
                    expect(date == _date).to(beFalse())
                }
            }
            
        }
    }
}
