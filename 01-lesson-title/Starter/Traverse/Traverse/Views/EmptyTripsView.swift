/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import SwiftUI

struct EmptyTripsView: View {
  var body: some View {
    VStack(spacing: 12) {
      Spacer()
      
      NavigationLink {
        CreateTripView()
          .navigationTransition(.crossFade)
      } label: {
        Image(systemName: "calendar.badge.plus")
          .font(.system(size: 42, weight: .regular))
          .foregroundStyle(Color.accentGreen)
      }
      .buttonStyle(AppPressButtonStyle())
      .accessibilityLabel("Create trip")
      
      Text("No trips yet")
        .font(AppFont.fieldLabel)
        .foregroundStyle(.primary)
      
      Text("Create your first trip to start planning.")
        .font(AppFont.fieldText)
        .foregroundStyle(Color.secondaryText)
        .multilineTextAlignment(.center)
      
      Spacer()
    }
    .padding(.horizontal, AppLayout.screenHorizontalPadding)
  }
}

#Preview {
  NavigationStack {
    EmptyTripsView()
  }
}
