//
//  Date+Intervals.swift
//  DevExtensions
//
//  Created by abuzeid on 22.12.20.
//

import Foundation

public extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }

    func relativeDaysFromToday() -> String {
        if #available(iOS 13.0, *) {
            let formatter = RelativeDateTimeFormatter()
            formatter.dateTimeStyle = .named
            formatter.unitsStyle = .abbreviated

            let currentDate = Date()
            return formatter.localizedString(for: self, relativeTo: currentDate)
        } else {
            return getElapsedInterval()
        }
    }

    func getElapsedInterval() -> String {
        let interval = Calendar.current.dateComponents([.month, .day, .hour, .minute], from: self, to: Date())

        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year ago" :
                "\(year)" + " " + "years ago"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month ago" :
                "\(month)" + " " + "months ago"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day ago" :
                "\(day)" + " " + "days ago"
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "hour ago" :
                "\(hour)" + " " + "hours ago"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "day ago" :
                "\(minute)" + " " + "days ago"
        } else {
            return "a moment ago"
        }
    }
}
