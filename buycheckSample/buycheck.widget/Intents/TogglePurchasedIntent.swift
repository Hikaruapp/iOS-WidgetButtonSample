// buycheck.widget/Intents/TogglePurchasedIntent.swift
import AppIntents
import SwiftData

struct TogglePurchasedIntent: AppIntent {
    static var title: LocalizedStringResource = "購入状態を切り替える"

    @Parameter(title: "アイテムID")
    var itemID: String

    func perform() async throws -> some IntentResult {
        let modelURL = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: Constants.appGroupID)!
            .appendingPathComponent("ShoppingModel.sqlite")
        let config = ModelConfiguration("ShoppingModel", url: modelURL)
        let container = try ModelContainer(for: ShoppingItem.self, configurations: config)
        let context = ModelContext(container)

        let descriptor = FetchDescriptor<ShoppingItem>(
            predicate: #Predicate<ShoppingItem> { $0.id == itemID }
        )

        if let item = try? context.fetch(descriptor).first {
            item.isPurchased.toggle()
            try context.save()
        }

        return .result()
    }
}
