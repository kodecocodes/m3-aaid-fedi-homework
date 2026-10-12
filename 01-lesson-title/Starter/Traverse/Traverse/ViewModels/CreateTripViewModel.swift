/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import Foundation
import Observation

@Observable
final class CreateTripViewModel {
  var tripName: String
  var startDate: Date {
    didSet {
      ensureEndDateIsAfterStartDate()
    }
  }
  var endDate: Date {
    didSet {
      ensureEndDateIsAfterStartDate()
    }
  }
  var tripNotes: String
  private let calendar: Calendar
  init(trip: Trip? = nil, calendar: Calendar = .current) {
    self.calendar = calendar
    let defaultStartDate = Date()
    let defaultEndDate = calendar.date(byAdding: .day, value: 7, to: defaultStartDate) ?? defaultStartDate
    tripName = trip?.name ?? ""
    startDate = trip?.startDate ?? defaultStartDate
    endDate = trip?.endDate ?? defaultEndDate
    tripNotes = trip?.notes ?? ""
    ensureEndDateIsAfterStartDate()
  }
  var canCreateTrip: Bool {
    !trimmedTripName.isEmpty && hasValidDateRange
  }
  var minimumEndDate: Date {
    DateValidation.dayAfter(date: startDate, calendar: calendar)
  }
  
  func createTrip() -> Trip {
    Trip(
      name: trimmedTripName,
      startDate: startDate,
      endDate: endDate,
      notes: trimmedTripNotes)
  }
  
  func update(trip: Trip) {
    trip.name = trimmedTripName
    trip.startDate = startDate
    trip.endDate = endDate
    trip.notes = trimmedTripNotes
  }
  
  private var trimmedTripName: String {
    tripName.trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  private var trimmedTripNotes: String {
    tripNotes.trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  private var hasValidDateRange: Bool {
    DateValidation.isStrictDateRange(start: startDate, end: endDate, calendar: calendar)
  }
  
  private func ensureEndDateIsAfterStartDate() {
    guard !hasValidDateRange else { return }
    endDate = minimumEndDate
  }
}
