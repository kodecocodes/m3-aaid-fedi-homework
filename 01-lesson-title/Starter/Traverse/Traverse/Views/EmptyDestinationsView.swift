/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import SwiftUI
import SwiftData

struct EmptyDestinationsView: View {
  var body: some View {
    VStack(spacing: 10) {
      Image(systemName: "info.circle")
        .font(.system(size: 34, weight: .regular))
        .foregroundStyle(Color.secondaryText)
      
      Text("No destinations yet")
        .font(AppFont.fieldLabel)
        .foregroundStyle(Color.black)
      
      Text("Add destinations to plan your trip\nand cover all dates.")
        .font(AppFont.fieldText)
        .foregroundStyle(Color.secondaryText)
        .multilineTextAlignment(.center)
        .lineSpacing(4)
    }
    .frame(maxWidth: .infinity)
    .frame(minHeight: 190)
    .padding(24)
    .background(Color.fieldBackground)
    .clipShape(RoundedRectangle(cornerRadius: AppLayout.cornerRadius, style: .continuous))
  }
}

#Preview {
  let trip = Trip(
    name: "Japan",
    startDate: Calendar.current.date(from: DateComponents(year: 2026, month: 12, day: 24)) ?? Date(),
    endDate: Calendar.current.date(from: DateComponents(year: 2027, month: 1, day: 2)) ?? Date(),
    notes: "")
  
  NavigationStack {
    TripDetailView(trip: trip)
  }
  .modelContainer(for: [Trip.self, Destination.self], inMemory: true)
}
