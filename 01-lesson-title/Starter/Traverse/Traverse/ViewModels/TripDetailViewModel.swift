/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import Foundation
import Observation

@Observable
final class TripDetailViewModel {
  var destinationName = ""
  var destinationStartDate: Date {
    didSet {
      limitDestinationDatesToTripRange()
    }
  }
  var destinationEndDate: Date {
    didSet {
      limitDestinationDatesToTripRange()
    }
  }
  
  private let tripStartDate: Date
  private let tripEndDate: Date
  private let calendar: Calendar
  
  init(trip: Trip, calendar: Calendar = .current) {
    self.calendar = calendar
    tripStartDate = DateValidation.startOfDay(date: trip.startDate, calendar: calendar)
    tripEndDate = DateValidation.startOfDay(date:trip.endDate, calendar: calendar)
    destinationStartDate = tripStartDate
    destinationEndDate = tripEndDate
  }
  
  var canAddDestination: Bool {
    !trimmedDestinationName.isEmpty && hasValidDestinationDateRange && isWithinTripDateRange
  }
  
  var destinationStartDateRange: ClosedRange<Date> {
    tripStartDate...latestDestinationStartDate
  }
  
  var destinationEndDateRange: ClosedRange<Date> {
    minimumDestinationEndDate...tripEndDate
  }
  
  var minimumDestinationEndDate: Date {
    DateValidation.dayAfter(date: destinationStartDate, calendar: calendar)
  }
  
  func addDestination(to trip: Trip) -> Destination {
    let destination = Destination(
      name: trimmedDestinationName,
      startDate: destinationStartDate,
      endDate: destinationEndDate,
      trip: trip)
    trip.destinations.append(destination)
    resetDestinationForm(for: trip)
    return destination
  }
  
  func load(destination: Destination) {
    destinationName = destination.name
    destinationStartDate = DateValidation.startOfDay(date: destination.startDate, calendar: calendar)
    destinationEndDate = DateValidation.startOfDay(date:destination.endDate, calendar: calendar)
    limitDestinationDatesToTripRange()
  }
  
  func update(destination: Destination) {
    destination.name = trimmedDestinationName
    destination.startDate = destinationStartDate
    destination.endDate = destinationEndDate
  }
  
  func resetDestinationForm(for trip: Trip) {
    destinationName = ""
    destinationStartDate = DateValidation.startOfDay(date: trip.startDate, calendar: calendar)
    destinationEndDate = DateValidation.startOfDay(date: trip.endDate, calendar: calendar)
    limitDestinationDatesToTripRange()
  }
  
  private var latestDestinationStartDate: Date {
    let latestStart = DateValidation.dayBefore(date: tripEndDate, calendar: calendar)
    return max(tripStartDate, latestStart)
  }
  
  private var trimmedDestinationName: String {
    destinationName.trimmingCharacters(in: .whitespacesAndNewlines)
  }
  
  private var hasValidDestinationDateRange: Bool {
    DateValidation.isStrictDateRange(start: destinationStartDate, end: destinationEndDate, calendar: calendar)
  }
  
  private var isWithinTripDateRange: Bool {
    let startDate = DateValidation.startOfDay(date: destinationStartDate, calendar: calendar)
    let endDate = DateValidation.startOfDay(date: destinationEndDate, calendar: calendar)
    return startDate >= tripStartDate && startDate <= latestDestinationStartDate && endDate <= tripEndDate
  }
  
  private func limitDestinationDatesToTripRange() {
    let limitedStartDate = DateValidation.dateLimitedToRange(
      date: destinationStartDate,
      range: tripStartDate...latestDestinationStartDate,
      calendar: calendar
    )
    if destinationStartDate != limitedStartDate {
      destinationStartDate = limitedStartDate
    }
    
    let earliestEndDate = minimumDestinationEndDate
    let limitedEndDate = DateValidation.dateLimitedToRange(
      date: destinationEndDate,
      range: earliestEndDate...tripEndDate,
      calendar: calendar
    )
    if destinationEndDate != limitedEndDate {
      destinationEndDate = limitedEndDate
    }
  }
}
