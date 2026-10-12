/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import SwiftUI

struct AppTextFieldContainer: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(.horizontal, AppLayout.fieldHorizontalPadding)
      .frame(maxWidth: .infinity, alignment: .leading)
      .frame(minHeight: AppLayout.fieldMinHeight)
      .background(
        RoundedRectangle(cornerRadius: AppLayout.cornerRadius, style: .continuous)
          .stroke(Color.borderColor, lineWidth: 2)
          .background(Color.white))
  }
}

struct AppDateFieldContainer: ViewModifier {
  func body(content: Content) -> some View {
    content
      .padding(.horizontal, AppLayout.fieldHorizontalPadding)
      .frame(maxWidth: .infinity, alignment: .leading)
      .frame(height: AppLayout.dateFieldHeight)
      .background(Color.fieldBackground)
      .clipShape(RoundedRectangle(cornerRadius: AppLayout.cornerRadius, style: .continuous))
  }
}

extension View {
  func appTextFieldContainer() -> some View {
    modifier(AppTextFieldContainer())
  }
  
  func appDateFieldContainer() -> some View {
    modifier(AppDateFieldContainer())
  }
}
