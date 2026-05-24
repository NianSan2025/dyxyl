import SwiftUI

@main
struct dyxylApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    @State private var isParentMode = false

    var body: some View {
        if isParentMode {
            ParentHomeView()
        } else {
            StudentHomeView()
        }
    }
}