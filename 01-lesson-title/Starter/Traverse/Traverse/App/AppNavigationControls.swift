/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import SwiftUI

struct AppBackHeader<Content: View>: View {
  let height: CGFloat
  let onBack: () -> Void
  @ViewBuilder let content: () -> Content
  
  init(
    height: CGFloat = 78,
    onBack: @escaping () -> Void,
    @ViewBuilder content: @escaping () -> Content) {
      self.height = height
      self.onBack = onBack
      self.content = content
    }
  
  var body: some View {
    ZStack {
      content()
      HStack {
        Button(action: onBack) {
          Image(systemName: "chevron.left")
            .font(AppFont.backIcon)
            .foregroundStyle(Color.accentGreen)
            .frame(width: 44, height: 44)
        }
        .buttonStyle(AppPressButtonStyle())
        Spacer()
      }
    }
    .padding(.horizontal, 18)
    .padding(.top, 20)
    .frame(height: height)
  }
}

struct AppActionsMenu<Content: View>: View {
  @ViewBuilder let content: () -> Content
  
  var body: some View {
    Menu {
      content()
    } label: {
      Image(systemName: "ellipsis")
        .font(.system(size: 18, weight: .semibold))
        .foregroundStyle(Color.secondaryText)
        .frame(width: 36, height: 36)
    }
    .buttonStyle(AppPressButtonStyle())
  }
}
