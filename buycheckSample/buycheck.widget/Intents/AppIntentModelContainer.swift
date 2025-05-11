// buycheck.widget/Intents/AppIntentModelContainer.swift

import SwiftData

enum AppIntentModelContainer {
    static var container: ModelContainer = {
        let schema = Schema([ShoppingItem.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        return try! ModelContainer(for: schema, configurations: [modelConfiguration])
    }()
}
