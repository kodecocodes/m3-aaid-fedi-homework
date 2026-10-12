/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import Foundation

enum TripDateStatus {
  case ongoing
  case upcoming
  case past
}

enum DateValidation {
  static func startOfDay(date: Date, calendar: Calendar = .current) -> Date {
    calendar.startOfDay(for: date)
  }
  
  static func dayAfter(date: Date, calendar: Calendar = .current) -> Date {
    let startDate = startOfDay(date: date, calendar: calendar)
    return calendar.date(byAdding: .day, value: 1, to: startDate) ?? startDate
  }
  
  static func dayBefore(date: Date, calendar: Calendar = .current) -> Date {
    let startDate = startOfDay(date: date, calendar: calendar)
    return calendar.date(byAdding: .day, value: -1, to: startDate) ?? startDate
  }
  
  static func isStrictDateRange(start: Date, end: Date, calendar: Calendar = .current) -> Bool {
    startOfDay(date: end, calendar: calendar) > startOfDay(date: start, calendar: calendar)
  }
  
  static func dateLimitedToRange(date: Date, range: ClosedRange<Date>, calendar: Calendar = .current) -> Date {
    let date = startOfDay(date: date, calendar: calendar)
    let lowerBound = startOfDay(date: range.lowerBound, calendar: calendar)
    let upperBound = startOfDay(date: range.upperBound, calendar: calendar)
    return min(max(date, lowerBound), upperBound)
  }
  
  static func tripStatus(
    startDate: Date,
    endDate: Date,
    today: Date = Date(),
    calendar: Calendar = .current) -> TripDateStatus {
      let startDate = startOfDay(date: startDate, calendar: calendar)
      let endDate = startOfDay(date: endDate, calendar: calendar)
      let today = startOfDay(date: today, calendar: calendar)
      if startDate > today {
        return .upcoming
      }
      if endDate < today {
        return .past
      }
      return .ongoing
    }
}
