/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import SwiftData
import SwiftUI

struct TripRowView: View {
  let trip: Trip
  let onDelete: () -> Void
  
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      NavigationLink {
        TripDetailView(trip: trip)
          .navigationTransition(.crossFade)
      } label: {
        rowContent
      }
      .buttonStyle(AppPressButtonStyle())
      
      AppActionsMenu {
        NavigationLink {
          CreateTripView(trip: trip)
            .navigationTransition(.crossFade)
        } label: {
          Label("Edit", systemImage: "pencil")
        }
        
        Button(role: .destructive, action: onDelete) {
          Label("Delete", systemImage: "trash")
        }
      }
      .padding(.trailing, 16)
      .padding(.bottom, 16)
    }
    .background(Color.fieldBackground)
    .clipShape(RoundedRectangle(cornerRadius: AppLayout.cornerRadius, style: .continuous))
  }
  
  private var rowContent: some View {
    VStack(alignment: .leading, spacing: 8) {
      Text(trip.name)
        .font(AppFont.fieldLabel)
        .foregroundStyle(.primary)
      
      HStack(spacing: 8) {
        Image(systemName: "calendar")
          .font(AppFont.dateIcon)
          .foregroundStyle(Color.secondaryText)
        
        Text(dateRange)
          .font(AppFont.fieldText)
          .foregroundStyle(Color.secondaryText)
      }
      
      if !trip.notes.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
        Text(trip.notes)
          .font(AppFont.fieldText)
          .foregroundStyle(Color.secondaryText)
          .lineLimit(2)
          .padding(.trailing, 44)
      }
    }
    .padding(16)
    .padding(.trailing, 44)
    .frame(maxWidth: .infinity, alignment: .leading)
    .contentShape(Rectangle())
  }
  
  private var dateRange: String {
    AppDateFormat.dateRange(start: trip.startDate, end: trip.endDate)
  }
}

#Preview {
  let trip = Trip(
    name: "Japan",
    startDate: Calendar.current.date(from: DateComponents(year: 2026, month: 12, day: 24)) ?? Date(),
    endDate: Calendar.current.date(from: DateComponents(year: 2027, month: 1, day: 2)) ?? Date(),
    notes: "Winters in Japan, carry jackets.")
  
  NavigationStack {
    TripRowView(trip: trip) { }
  }
  .modelContainer(for: [Trip.self, Destination.self], inMemory: true)
}
