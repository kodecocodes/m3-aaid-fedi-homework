/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import SwiftData
import SwiftUI

struct DestinationView: View {
  let tripName: String
  let screenTitle: String
  let buttonTitle: String
  @Bindable var viewModel: TripDetailViewModel
  @Binding var showStartDatePicker: Bool
  @Binding var showEndDatePicker: Bool
  @FocusState private var focusedField: Field?
  let onBack: () -> Void
  let onSave: () -> Void
  
  var body: some View {
    VStack(spacing: 0) {
      header
      ScrollView {
        VStack(alignment: .leading, spacing: 22) {
          AppFormField(label: "Destination name *") {
            TextField("e.g. Kyoto", text: $viewModel.destinationName)
              .textInputAutocapitalization(.words)
              .submitLabel(.done)
              .font(AppFont.fieldText)
              .foregroundStyle(.primary)
              .focused($focusedField, equals: .destinationName)
          }
          
          AppDateFieldButton(label: "Start date", date: viewModel.destinationStartDate) {
            showStartDatePicker = true
          }
          
          AppDateFieldButton(label: "End date", date: viewModel.destinationEndDate) {
            showEndDatePicker = true
          }
          
          Button(action: onSave) {
            Text(buttonTitle)
          }
          .buttonStyle(AppPrimaryButtonStyle())
          .disabled(!viewModel.canAddDestination)
          .padding(.top, 10)
        }
        .padding(.horizontal, AppLayout.screenHorizontalPadding)
        .padding(.vertical, 28)
      }
    }
    .background(Color.white)
    .sheet(isPresented: $showStartDatePicker) {
      AppDatePickerSheet(
        title: "Start Date *",
        date: $viewModel.destinationStartDate,
        isPresented: $showStartDatePicker,
        dateRange: viewModel.destinationStartDateRange)
    }
    .sheet(isPresented: $showEndDatePicker) {
      AppDatePickerSheet(
        title: "End Date *",
        date: $viewModel.destinationEndDate,
        isPresented: $showEndDatePicker,
        dateRange: viewModel.destinationEndDateRange)
    }
    .onAppear {
      focusedField = .destinationName
    }
  }
  
  private enum Field {
    case destinationName
  }
  
  private var header: some View {
    AppBackHeader(height: 92, onBack: onBack) {
      VStack(spacing: 4) {
        Text(screenTitle)
          .font(AppFont.screenTitle)
          .foregroundStyle(Color.accentGreen)
          .lineLimit(1)
          .minimumScaleFactor(0.75)
        
        Text("for your \"\(tripName)\" trip")
          .font(AppFont.fieldText)
          .foregroundStyle(Color.secondaryText)
          .lineLimit(1)
          .minimumScaleFactor(0.7)
      }
      .padding(.horizontal, AppLayout.screenHorizontalPadding + 44)
    }
  }
}

private struct DestinationViewPreviewHost: View {
  @State private var viewModel: TripDetailViewModel
  @State private var showStartDatePicker = false
  @State private var showEndDatePicker = false
  private let trip: Trip
  init() {
    let startDate = Calendar.current.date(from: DateComponents(year: 2026, month: 12, day: 24)) ?? Date()
    let endDate = Calendar.current.date(from: DateComponents(year: 2027, month: 1, day: 2)) ?? Date()
    let trip = Trip(name: "Japan", startDate: startDate, endDate: endDate, notes: "")
    self.trip = trip
    _viewModel = State(initialValue: TripDetailViewModel(trip: trip))
  }
  
  var body: some View {
    NavigationStack {
      DestinationView(
        tripName: trip.name,
        screenTitle: "Add Destination",
        buttonTitle: "Save Destination",
        viewModel: viewModel,
        showStartDatePicker: $showStartDatePicker,
        showEndDatePicker: $showEndDatePicker,
        onBack: { },
        onSave: { })
    }
  }
}

#Preview {
  DestinationViewPreviewHost()
    .modelContainer(for: [Trip.self, Destination.self], inMemory: true)
}
