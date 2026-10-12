/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import SwiftUI

struct DeleteConfirmationOverlay: View {
  let title: String
  let message: String
  let deleteButtonTitle: String
  let onConfirm: () -> Void
  let onCancel: () -> Void
  
  var body: some View {
    ZStack {
      Color.black.opacity(0.28)
        .ignoresSafeArea()
      
      VStack(alignment: .leading, spacing: 18) {
        VStack(alignment: .leading, spacing: 8) {
          HStack {
            Spacer()
            Text(title)
              .font(AppFont.fieldLabel)
              .foregroundStyle(.primary)
            Spacer()
          }
          
          Text(message)
            .font(AppFont.fieldText)
            .foregroundStyle(Color.secondaryText)
            .fixedSize(horizontal: false, vertical: true)
        }
        
        VStack(spacing: 10) {
          Button(action: onConfirm) {
            Text(deleteButtonTitle)
              .font(AppFont.primaryButton)
              .frame(maxWidth: .infinity)
              .frame(height: AppLayout.buttonHeight)
              .foregroundStyle(.white)
              .background(Color.red)
              .clipShape(RoundedRectangle(cornerRadius: AppLayout.cornerRadius, style: .continuous))
          }
          .buttonStyle(AppPressButtonStyle())
          
          Button(action: onCancel) {
            Text("Cancel")
              .font(AppFont.primaryButton)
              .frame(maxWidth: .infinity)
              .frame(height: AppLayout.buttonHeight)
              .foregroundStyle(Color.accentGreen)
              .background(Color.fieldBackground)
              .clipShape(RoundedRectangle(cornerRadius: AppLayout.cornerRadius, style: .continuous))
          }
          .buttonStyle(AppPressButtonStyle())
        }
      }
      .padding(24)
      .background(Color.white)
      .clipShape(RoundedRectangle(cornerRadius: AppLayout.cornerRadius, style: .continuous))
      .padding(.horizontal, AppLayout.screenHorizontalPadding)
      .shadow(color: .black.opacity(0.18), radius: 18, x: 0, y: 8)
    }
  }
}

#Preview {
  DeleteConfirmationOverlay(
    title: "Delete Trip?",
    message: "This trip and all of its destinations will be permanently deleted.",
    deleteButtonTitle: "Delete Trip",
    onConfirm: { },
    onCancel: { })
}
