/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import SwiftData
import SwiftUI

struct DestinationRowView: View {
  let destination: Destination
  let onEdit: () -> Void
  let onDelete: () -> Void
  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      rowContent
      AppActionsMenu {
        Button(action: onEdit) {
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
      Text(destination.name)
        .font(AppFont.fieldLabel)
        .foregroundStyle(.primary)
        .lineLimit(2)
        .padding(.trailing, 44)
      HStack(spacing: 8) {
        Image(systemName: "calendar")
          .font(AppFont.dateIcon)
          .foregroundStyle(Color.secondaryText)
        Text(dateRange)
          .font(AppFont.fieldText)
          .foregroundStyle(Color.secondaryText)
      }
    }
    .padding(16)
    .padding(.trailing, 44)
    .frame(maxWidth: .infinity, alignment: .leading)
    .contentShape(Rectangle())
  }
  
  private var dateRange: String {
    AppDateFormat.dateRange(start: destination.startDate, end: destination.endDate)
  }
}

#Preview {
  let destination = Destination(
    name: "Kyoto",
    startDate: Calendar.current.date(from: DateComponents(year: 2026, month: 12, day: 26)) ?? Date(),
    endDate: Calendar.current.date(from: DateComponents(year: 2026, month: 12, day: 29)) ?? Date())
  
  NavigationStack {
    DestinationRowView(
      destination: destination,
      onEdit: { },
      onDelete: { })
    .padding()
  }
  .modelContainer(for: [Trip.self, Destination.self], inMemory: true)
}
