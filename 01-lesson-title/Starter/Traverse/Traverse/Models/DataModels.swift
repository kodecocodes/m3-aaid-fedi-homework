/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import Foundation
import SwiftData

@Model
final class Trip {
  var tripID: UUID
  var name: String
  var startDate: Date
  var endDate: Date
  var notes: String
  var createdAt: Date
  @Relationship(deleteRule: .cascade, inverse: \Destination.trip) var destinations: [Destination]
  
  init(
    tripID: UUID = UUID(),
    name: String,
    startDate: Date,
    endDate: Date,
    notes: String,
    createdAt: Date = Date(),
    destinations: [Destination] = []) {
      self.tripID = tripID
      self.name = name
      self.startDate = startDate
      self.endDate = endDate
      self.notes = notes
      self.createdAt = createdAt
      self.destinations = destinations
    }
}

@Model
final class Destination {
  var destinationID: UUID
  var name: String
  var startDate: Date
  var endDate: Date
  var createdAt: Date
  var trip: Trip?
  
  init(
    destinationID: UUID = UUID(),
    name: String,
    startDate: Date,
    endDate: Date,
    createdAt: Date = Date(),
    trip: Trip? = nil) {
      self.destinationID = destinationID
      self.name = name
      self.startDate = startDate
      self.endDate = endDate
      self.createdAt = createdAt
      self.trip = trip
    }
}
