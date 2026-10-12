/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import SwiftData
import SwiftUI

struct TripsHomeView: View {
  @Environment(\.modelContext) private var modelContext
  @Query(sort: \Trip.startDate, order: .forward) private var trips: [Trip]
  @State private var tripPendingDeletion: Trip?
  
  var body: some View {
    NavigationStack {
      ZStack {
        VStack(spacing: 0) {
          header
          
          if trips.isEmpty {
            EmptyTripsView()
          } else {
            tripList
          }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        
        if let tripPendingDeletion {
          deleteConfirmationBox(for: tripPendingDeletion)
        }
      }
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .navigationBarBackButtonHidden(true)
      .toolbar(.hidden, for: .navigationBar)
    }
  }
  
  private var header: some View {
    HStack(alignment: .center) {
      Spacer()
      Text("Trips")
        .font(AppFont.screenTitle)
        .foregroundStyle(Color.accentGreen)
      Spacer()
      NavigationLink {
        CreateTripView()
          .navigationTransition(.crossFade)
      } label: {
        Image(systemName: "plus")
          .font(.system(size: 20, weight: .semibold))
          .foregroundStyle(.white)
          .frame(width: 42, height: 42)
          .background(Color.accentGreen)
          .clipShape(Circle())
      }
      .buttonStyle(AppPressButtonStyle())
      .accessibilityLabel("Create Trip")
    }
    .padding(.horizontal, AppLayout.screenHorizontalPadding)
    .padding(.top, 28)
    .padding(.bottom, 20)
  }
  
  private var tripList: some View {
    ScrollView {
      VStack(alignment: .leading, spacing: 24) {
        if !viewModel.ongoingTrips.isEmpty {
          tripSection(title: "Ongoing", trips: viewModel.ongoingTrips)
        }
        
        if !viewModel.upcomingTrips.isEmpty {
          tripSection(title: "Upcoming", trips: viewModel.upcomingTrips)
        }
        
        if !viewModel.pastTrips.isEmpty {
          tripSection(title: "Past", trips: viewModel.pastTrips)
        }
      }
      .padding(.horizontal, AppLayout.screenHorizontalPadding)
      .padding(.vertical, 12)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
  }
  
  private var viewModel: TripsHomeViewModel {
    TripsHomeViewModel(trips: trips)
  }
  
  private func tripSection(title: String, trips: [Trip]) -> some View {
    VStack(alignment: .leading, spacing: 12) {
      Text(title)
        .font(AppFont.fieldLabel)
        .foregroundStyle(Color.accentGreen)
      
      VStack(spacing: 12) {
        ForEach(trips) { trip in
          TripRowView(trip: trip) {
            requestDeleteTrip(trip: trip)
          }
        }
      }
    }
  }
  
  private func deleteConfirmationBox(for trip: Trip) -> some View {
    DeleteConfirmationOverlay(
      title: "Delete Trip?",
      message: "\"\(trip.name)\" and its destinations will be permanently removed.",
      deleteButtonTitle: "Delete Trip",
      onConfirm: confirmDeleteTrip,
      onCancel: cancelDeleteTrip)
  }
  
  private func requestDeleteTrip(trip: Trip) {
    tripPendingDeletion = trip
  }
  
  private func cancelDeleteTrip() {
    tripPendingDeletion = nil
  }
  
  private func confirmDeleteTrip() {
    guard let trip = tripPendingDeletion else { return }
    tripPendingDeletion = nil
    deleteTrip(trip: trip)
  }
  
  private func deleteTrip(trip: Trip) {
    modelContext.delete(trip)
    do {
      try modelContext.save()
    } catch {
      print("Failed to delete trip: \(error.localizedDescription)")
    }
  }
}

#Preview {
  let configuration = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try! ModelContainer(
    for: Trip.self,
    Destination.self,
    configurations: configuration)
  let calendar = Calendar.current
  let trip = Trip(
    name: "Japan",
    startDate: calendar.date(from: DateComponents(year: 2026, month: 12, day: 24)) ?? Date(),
    endDate: calendar.date(from: DateComponents(year: 2027, month: 1, day: 2)) ?? Date(),
    notes: "Winters in Japan, carry jackets.")
  
  container.mainContext.insert(trip)
  
  return TripsHomeView()
    .modelContainer(container)
}
