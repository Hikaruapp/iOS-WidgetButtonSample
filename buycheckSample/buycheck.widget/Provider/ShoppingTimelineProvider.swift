// buycheck.widget/Provider/ShoppingTimelineProvider.swift

import WidgetKit
import SwiftData
import Foundation

struct ShoppingTimelineProvider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), items: [])
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let items = fetchTopItems()
        let entry = SimpleEntry(date: Date(), items: items)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        let items = fetchTopItems()
        let entry = SimpleEntry(date: Date(), items: items)
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }

    private func fetchTopItems() -> [ShoppingItem] {
        let schema = Schema([ShoppingItem.self])
        guard let directory = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: Constants.appGroupID) else {
            print("App Group directory not found")
            return []
        }
        let storeURL = directory.appendingPathComponent("ShoppingModel.sqlite")
        let config = ModelConfiguration("ShoppingModel", url: storeURL)
        guard let container = try? ModelContainer(for: schema, configurations: [config]) else {
            print("Failed to initialize ModelContainer")
            return []
        }
        let context = ModelContext(container)
        let descriptor = FetchDescriptor<ShoppingItem>(sortBy: [SortDescriptor(\.sortIndex)])
        let items = (try? context.fetch(descriptor)) ?? []
        print("Fetched \(items.count) items in widget")
        return Array(items.prefix(3))
    }
}
