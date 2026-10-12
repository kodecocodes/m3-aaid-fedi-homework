/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import Foundation

final class TripsHomeViewModel {
  private let trips: [Trip]
  private let today: Date
  private let calendar: Calendar
  
  init(
    trips: [Trip],
    today: Date = Date(),
    calendar: Calendar = .current) {
      self.trips = trips
      self.calendar = calendar
      self.today = DateValidation.startOfDay(date: today, calendar: calendar)
    }
  var ongoingTrips: [Trip] {
    trips.filter { status(for: $0) == .ongoing }
  }
  var upcomingTrips: [Trip] {
    trips.filter { status(for: $0) == .upcoming }
  }
  var pastTrips: [Trip] {
    trips
      .filter { status(for: $0) == .past }
      .sorted { $0.startDate > $1.startDate }
  }
  
  private func status(for trip: Trip) -> TripDateStatus {
    DateValidation.tripStatus(
      startDate: trip.startDate,
      endDate: trip.endDate,
      today: today,
      calendar: calendar)
  }
}
