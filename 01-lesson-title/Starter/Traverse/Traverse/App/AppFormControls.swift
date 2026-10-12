/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import SwiftUI

struct AppFormField<Content: View>: View {
  let label: String
  @ViewBuilder let content: () -> Content
  
  var body: some View {
    VStack(alignment: .leading, spacing: AppLayout.fieldSpacing) {
      Text(label)
        .font(AppFont.fieldLabel)
        .foregroundStyle(Color.accentGreen)
      content()
        .appTextFieldContainer()
    }
  }
}

struct AppDateFieldButton: View {
  let label: String
  let date: Date
  let action: () -> Void
  
  init(
    label: String,
    date: Date,
    action: @escaping () -> Void) {
      self.label = label
      self.date = date
      self.action = action
    }
  
  var body: some View {
    VStack(alignment: .leading, spacing: AppLayout.fieldSpacing) {
      Text(label)
        .font(AppFont.fieldLabel)
        .foregroundStyle(Color.accentGreen)
      Button(action: action) {
        HStack(spacing: 12) {
          Image(systemName: "calendar")
            .font(AppFont.dateIcon)
            .foregroundStyle(Color.secondaryText)
          Text(AppDateFormat.date(date:date))
            .font(AppFont.fieldText)
            .foregroundStyle(.primary)
          Spacer()
        }
        .appDateFieldContainer()
      }
      .buttonStyle(AppPressButtonStyle())
    }
  }
}

struct AppDatePickerSheet: View {
  let title: String
  @Binding var date: Date
  @Binding var isPresented: Bool
  let dateRange: ClosedRange<Date>?
  let minimumDate: Date?
  
  init(
    title: String,
    date: Binding<Date>,
    isPresented: Binding<Bool>,
    dateRange: ClosedRange<Date>? = nil,
    minimumDate: Date? = nil) {
      self.title = title
      _date = date
      _isPresented = isPresented
      self.dateRange = dateRange
      self.minimumDate = minimumDate
    }
  
  var body: some View {
    NavigationStack {
      datePicker
        .datePickerStyle(.graphical)
        .tint(Color.accentGreen)
        .padding()
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
          ToolbarItem(placement: .confirmationAction) {
            Button("Done") {
              isPresented = false
            }
            .buttonStyle(AppPressButtonStyle())
            .foregroundStyle(Color.accentGreen)
          }
        }
    }
    .presentationDetents([.medium])
  }
  
  @ViewBuilder
  private var datePicker: some View {
    if let dateRange {
      DatePicker(title, selection: $date, in: dateRange, displayedComponents: .date)
    } else if let minimumDate {
      DatePicker(title, selection: $date, in: minimumDate..., displayedComponents: .date)
    } else {
      DatePicker(title, selection: $date, displayedComponents: .date)
    }
  }
}
