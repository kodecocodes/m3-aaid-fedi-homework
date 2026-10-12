/// Copyright (c) 2026 Kodeco Inc. See COPYRIGHT for details.
/// Caution: This is AI-generated code.

import SwiftData
import SwiftUI

@main struct MyApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
    .modelContainer(for: [Trip.self, Destination.self])
  }
}

struct ContentView: View {
  var body: some View {
    TripsHomeView()
  }
}
