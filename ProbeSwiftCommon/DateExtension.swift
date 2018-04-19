//
//  DateExtension.swift
//  ProbeSwiftCommon
//
//  Created by codeComposer on 2018. 4. 19..
//  Copyright © 2018년 Probe. All rights reserved.
//

import Foundation

extension Date {
    func toNSDate() -> NSDate {
        return NSDate(timeIntervalSince1970: self.timeIntervalSince1970)
    }
    
    func nextDay(amount: Int) -> Optional<Date> {
        return Calendar.current.date(byAdding: .day, value: amount, to: self)
    }
    
    func year() -> Int {
        return Calendar.current.component(.year, from: self)
    }
    
    func month() -> Int {
        return Calendar.current.component(.month, from: self)
    }
    
    func weekday() -> Int {
        return Calendar.current.component(.weekday, from: self)
    }
    
    func day() -> Int {
        return Calendar.current.component(.day, from: self)
    }
    
    func toZeroHour() -> Date {
        let gregorian = Calendar(identifier: .gregorian)
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.hour = 0
        components.minute = 0
        components.second = 0
        
        return gregorian.date(from: components)!
    }
    
    static func createUTC(year: Int, month: Int, day: Int) -> Date {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        return Calendar.current.date(from: components)!
    }
    
    func between(startDate: Date, endDateOptional: Optional<Date>) -> Bool {
        guard let endDate = endDateOptional else {
            return (startDate <= self)
        }
        return startDate <= self && endDate >= self ? true : false
    }
    
    func dayDiff(to: Date) -> Optional<Int> {
        let date1 = Calendar.current.startOfDay(for: to)
        let date2 = Calendar.current.startOfDay(for: self)
        return Calendar.current.dateComponents([.day], from: date1, to: date2).day
    }
    
    func weekDiff(to: Date) -> Optional<Int> {
        let date1 = Calendar.current.startOfDay(for: to)
        let date2 = Calendar.current.startOfDay(for: self)
        return Calendar.current.dateComponents([.weekOfYear], from: date1, to: date2).weekOfYear
    }
    
    func monthDiff(to: Date) -> Optional<Int> {
        let date1 = Calendar.current.startOfDay(for: to)
        let date2 = Calendar.current.startOfDay(for: self)
        return Calendar.current.dateComponents([.month], from: date1, to: date2).month
    }
    
    func yearDiff(to: Date) -> Optional<Int> {
        let date1 = Calendar.current.startOfDay(for: to)
        let date2 = Calendar.current.startOfDay(for: self)
        return Calendar.current.dateComponents([.year], from: date1, to: date2).year
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(
            from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    static func min(dates: Date...) -> Date {
        return dates.sorted { (date1, date2) -> Bool in
            date1.compare(date2) == .orderedDescending
            }.first ?? Date()
    }
    
    static func max(dates: Date...) -> Date {
        return dates.sorted { (date1, date2) -> Bool in
            date1.compare(date2) == .orderedAscending
            }.first ?? Date()
    }
    
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: self)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: self)!
    }
}
