/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import SwiftUI

struct AppPrimaryButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .font(AppFont.primaryButton)
      .frame(maxWidth: .infinity)
      .frame(height: AppLayout.buttonHeight)
      .foregroundStyle(.white)
      .background(isEnabled ? Color.accentGreen : Color.accentGreen.opacity(0.45))
      .clipShape(RoundedRectangle(cornerRadius: AppLayout.cornerRadius, style: .continuous))
      .opacity(configuration.isPressed && isEnabled ? 0.88 : 1)
  }
}

struct AppPressButtonStyle: ButtonStyle {
  @Environment(\.isEnabled) private var isEnabled
  func makeBody(configuration: Configuration) -> some View {
    configuration.label
      .opacity(configuration.isPressed && isEnabled ? 0.72 : 1)
  }
}
