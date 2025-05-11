import SwiftUI
import SwiftData

@main
struct buycheck_sampleApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(ShoppingModelContainer.container)
    }
}
