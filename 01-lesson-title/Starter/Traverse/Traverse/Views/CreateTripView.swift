/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import SwiftData
import SwiftUI

struct CreateTripView: View {
  @Environment(\.dismiss) private var dismiss
  @Environment(\.modelContext) private var modelContext
  
  private let trip: Trip?
  @State private var viewModel: CreateTripViewModel
  @State private var showStartDatePicker = false
  @State private var showEndDatePicker = false
  @FocusState private var focusedField: Field?
  
  init(trip: Trip? = nil) {
    self.trip = trip
    _viewModel = State(initialValue: CreateTripViewModel(trip: trip))
  }
  
  var body: some View {
    VStack(spacing: 0) {
      header
      ScrollView {
        VStack(alignment: .leading, spacing: 26) {
          AppFormField(label: "Trip name *") {
            TextField("e.g. Japan", text: $viewModel.tripName)
              .textInputAutocapitalization(.words)
              .submitLabel(.done)
              .font(AppFont.fieldText)
              .foregroundStyle(.primary)
              .focused($focusedField, equals: .tripName)
          }
          
          AppDateFieldButton(label: "Start date *", date: viewModel.startDate) {
            showStartDatePicker = true
          }
          AppDateFieldButton(label: "End date *", date: viewModel.endDate) {
            showEndDatePicker = true
          }
          
          AppFormField(label: "Trip notes (optional)") {
            ZStack(alignment: .topLeading) {
              if viewModel.tripNotes.isEmpty {
                Text("Any notes about this trip...")
                  .foregroundStyle(Color(.placeholderText))
                  .font(AppFont.fieldText)
                  .padding(.top, 8)
                  .padding(.leading, 5)
              }
              
              TextEditor(text: $viewModel.tripNotes)
                .font(AppFont.fieldText)
                .scrollContentBackground(.hidden)
                .padding(.horizontal, -5)
                .padding(.vertical, -8)
            }
            .frame(minHeight: 122, alignment: .top)
          }
          
          Button(action: saveTrip) {
            Text(buttonTitle)
          }
          .buttonStyle(AppPrimaryButtonStyle())
          .disabled(!viewModel.canCreateTrip)
          .padding(.top, 14)
        }
        .padding(.horizontal, AppLayout.screenHorizontalPadding)
        .padding(.top, 34)
        .padding(.bottom, 32)
      }
    }
    .background(Color.white)
    .navigationBarBackButtonHidden(true)
    .toolbar(.hidden, for: .navigationBar)
    .navigationTransition(.crossFade)
    .sheet(isPresented: $showStartDatePicker) {
      AppDatePickerSheet(title: "Start Date", date: $viewModel.startDate, isPresented: $showStartDatePicker)
    }
    .sheet(isPresented: $showEndDatePicker) {
      AppDatePickerSheet(
        title: "End Date",
        date: $viewModel.endDate,
        isPresented: $showEndDatePicker,
        minimumDate: viewModel.minimumEndDate)
    }
    .onAppear {
      focusedField = .tripName
    }
  }
  
  private enum Field {
    case tripName
  }
  
  private var header: some View {
    AppBackHeader(onBack: { dismiss() }) {
      Text(screenTitle)
        .font(AppFont.screenTitle)
        .foregroundStyle(Color.accentGreen)
    }
  }
  
  private var screenTitle: String {
    trip == nil ? "Create Trip" : "Edit Trip"
  }
  
  private var buttonTitle: String {
    trip == nil ? "Create Trip" : "Save Trip"
  }
  
  private func saveTrip() {
    guard viewModel.canCreateTrip else { return }
    
    if let trip {
      viewModel.update(trip: trip)
    } else {
      modelContext.insert(viewModel.createTrip())
    }
    
    do {
      try modelContext.save()
      dismiss()
    } catch {
      print("Failed to save trip: \(error.localizedDescription)")
    }
  }
}

#Preview {
  NavigationStack {
    CreateTripView()
  }
  .modelContainer(for: [Trip.self, Destination.self], inMemory: true)
}
