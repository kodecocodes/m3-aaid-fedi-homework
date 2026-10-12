/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import SwiftData
import SwiftUI

struct TripDetailView: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var modelContext
  
  let trip: Trip
  @State private var viewModel: TripDetailViewModel
  @State private var showAddDestinationFullScreen = false
  @State private var showDestinationStartDatePicker = false
  @State private var showDestinationEndDatePicker = false
  @State private var destinationBeingEdited: Destination?
  @State private var destinationPendingDeletion: Destination?
  
  init(trip: Trip) {
    self.trip = trip
    _viewModel = State(initialValue: TripDetailViewModel(trip: trip))
  }
  
  var body: some View {
    ZStack {
      VStack(alignment: .leading, spacing: 30) {
        header
        ScrollView {
          VStack(spacing: 34) {
            destinationContent
            Button(action: presentAddDestination) {
              Text("Add Destination")
            }
            .buttonStyle(AppPrimaryButtonStyle())
          }
          .padding(.horizontal, AppLayout.screenHorizontalPadding)
          .padding(.top, 18)
          .padding(.bottom, 32)
        }
      }
      .background(Color.white)
      
      if let destinationPendingDeletion {
        deleteConfirmationBox(for: destinationPendingDeletion)
      }
    }
    .navigationBarBackButtonHidden(true)
    .toolbar(.hidden, for: .navigationBar)
    .navigationTransition(.crossFade)
    .fullScreenCover(isPresented: $showAddDestinationFullScreen) {
      addDestinationFullScreenView
    }
  }
  
  private var header: some View {
    AppBackHeader(onBack: { dismiss() }) {
      VStack(spacing: 4) {
        Text(trip.name)
          .font(AppFont.screenTitle)
          .foregroundStyle(Color.accentGreen)
          .lineLimit(1)
          .minimumScaleFactor(0.75)
        
        Text(AppDateFormat.dateRange(start: trip.startDate, end: trip.endDate))
          .font(AppFont.fieldLabel)
          .foregroundStyle(Color.accentGreen)
          .lineLimit(1)
          .minimumScaleFactor(0.8)
      }
      .padding(.horizontal, AppLayout.screenHorizontalPadding + 44)
    }
  }
  
  @ViewBuilder
  private var destinationContent: some View {
    if trip.destinations.isEmpty {
      EmptyDestinationsView()
    } else {
      VStack(spacing: 12) {
        ForEach(sortedDestinations) { destination in
          DestinationRowView(
            destination: destination,
            onEdit: { presentEditDestination(destination) },
            onDelete: { requestDeleteDestination(destination) })
        }
      }
    }
  }
  
  private var addDestinationFullScreenView: some View {
    DestinationView(
      tripName: trip.name,
      screenTitle: destinationScreenTitle,
      buttonTitle: destinationButtonTitle,
      viewModel: viewModel,
      showStartDatePicker: $showDestinationStartDatePicker,
      showEndDatePicker: $showDestinationEndDatePicker,
      onBack: dismissAddDestination,
      onSave: saveDestination)
  }
  
  private var destinationScreenTitle: String {
    destinationBeingEdited == nil ? "Add Destination" : "Edit Destination"
  }
  
  private var destinationButtonTitle: String {
    destinationBeingEdited == nil ? "Add Destination" : "Save Destination"
  }
  
  private var sortedDestinations: [Destination] {
    trip.destinations.sorted { first, second in
      if first.startDate == second.startDate {
        return first.createdAt < second.createdAt
      }
      return first.startDate < second.startDate
    }
  }
  
  private func deleteConfirmationBox(for destination: Destination) -> some View {
    DeleteConfirmationOverlay(
      title: "Delete Destination?",
      message: "\"\(destination.name)\" will be permanently removed.",
      deleteButtonTitle: "Delete Destination",
      onConfirm: confirmDeleteDestination,
      onCancel: cancelDeleteDestination)
  }
  
  private func presentAddDestination() {
    destinationBeingEdited = nil
    viewModel.resetDestinationForm(for: trip)
    showAddDestinationFullScreen = true
  }
  
  private func presentEditDestination(_ destination: Destination) {
    destinationBeingEdited = destination
    viewModel.load(destination: destination)
    showAddDestinationFullScreen = true
  }
  
  private func dismissAddDestination() {
    showAddDestinationFullScreen = false
    destinationBeingEdited = nil
  }
  
  private func saveDestination() {
    guard viewModel.canAddDestination else { return }
    
    if let destinationBeingEdited {
      viewModel.update(destination: destinationBeingEdited)
    } else {
      let destination = viewModel.addDestination(to: trip)
      modelContext.insert(destination)
    }
    
    do {
      try modelContext.save()
      showAddDestinationFullScreen = false
      destinationBeingEdited = nil
    } catch {
      print("Failed to save destination: \(error.localizedDescription)")
    }
  }
  
  private func requestDeleteDestination(_ destination: Destination) {
    destinationPendingDeletion = destination
  }
  
  private func cancelDeleteDestination() {
    destinationPendingDeletion = nil
  }
  
  private func confirmDeleteDestination() {
    guard let destination = destinationPendingDeletion else { return }
    destinationPendingDeletion = nil
    deleteDestination(destination)
  }
  
  private func deleteDestination(_ destination: Destination) {
    trip.destinations.removeAll { $0.destinationID == destination.destinationID }
    modelContext.delete(destination)
    
    do {
      try modelContext.save()
    } catch {
      print("Failed to delete destination: \(error.localizedDescription)")
    }
  }
}

#Preview {
  let trip = Trip(
    name: "Japan",
    startDate: Calendar.current.date(from: DateComponents(year: 2026, month: 12, day: 24)) ?? Date(),
    endDate: Calendar.current.date(from: DateComponents(year: 2027, month: 1, day: 2)) ?? Date(),
    notes: "",
    destinations: [
      Destination(
        name: "Kyoto",
        startDate: Calendar.current.date(from: DateComponents(year: 2026, month: 12, day: 24)) ?? Date(),
        endDate: Calendar.current.date(from: DateComponents(year: 2026, month: 12, day: 28)) ?? Date()),
      Destination(
        name: "Tokyo",
        startDate: Calendar.current.date(from: DateComponents(year: 2026, month: 12, day: 29)) ?? Date(),
        endDate: Calendar.current.date(from: DateComponents(year: 2027, month: 1, day: 2)) ?? Date())])
  
  NavigationStack {
    TripDetailView(trip: trip)
  }
  .modelContainer(for: [Trip.self, Destination.self], inMemory: true)
}
