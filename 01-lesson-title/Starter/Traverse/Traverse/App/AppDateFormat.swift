/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import Foundation

enum AppDateFormat {
  static func date(date: Date) -> String {
    date.formatted(.dateTime.day().month(.abbreviated).year())
  }
  static func dateRange(start: Date, end: Date) -> String {
    "\(date(date:start)) - \(date(date:end))"
  }
}
