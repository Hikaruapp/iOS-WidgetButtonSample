import SwiftUI
import SwiftData
import WidgetKit

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.scenePhase) private var scenePhase

    @Query(filter: #Predicate<ShoppingItem> { !$0.isPurchased },
           sort: [SortDescriptor(\.sortIndex)]) var unpurchasedItems: [ShoppingItem]

    @Query(filter: #Predicate<ShoppingItem> { $0.isPurchased },
           sort: [SortDescriptor(\.sortIndex)]) var purchasedItems: [ShoppingItem]

    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section(header: Text("買い物リスト")) {
                        ForEach(unpurchasedItems) { item in
                            ItemRowView(item: item)
                                .onTapGesture {
                                    item.isPurchased.toggle()
                                    try? context.save()
                                    WidgetCenter.shared.reloadAllTimelines()
                                }
                        }
                        .onMove { indices, newOffset in
                            moveItems(from: indices, to: newOffset)
                        }
                        .onDelete { indexSet in
                            for index in indexSet {
                                context.delete(unpurchasedItems[index])
                            }
                            try? context.save()
                            WidgetCenter.shared.reloadAllTimelines()
                        }
                        if unpurchasedItems.isEmpty {
                            Text("買い物はありません")
                                .foregroundStyle(.secondary)
                        }
                    }
                    if !purchasedItems.isEmpty {
                        Section(header: Text("購入チェック済み")) {
                            ForEach(purchasedItems) { item in
                                ItemRowView(item: item)
                                    .onTapGesture {
                                        item.isPurchased.toggle()
                                        try? context.save()
                                        WidgetCenter.shared.reloadAllTimelines()
                                    }
                            }
                            .onDelete { indexSet in
                                for index in indexSet {
                                    context.delete(purchasedItems[index])
                                }
                                try? context.save()
                                WidgetCenter.shared.reloadAllTimelines()
                            }
                        }
                    }
                }
                HStack {
                    Spacer()
                    NavigationLink(destination: AddItemView()) {
                        Image(systemName: "plus")
                        Text("買い物を追加する")
                    }
                    Spacer()
                }
            }
            .navigationTitle("買い物リスト")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarLeading) {
                    Button("強制反映") {
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                }
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
            .onChange(of: scenePhase) {
                if scenePhase == .active {
                    WidgetCenter.shared.reloadAllTimelines()
                }
            }
        }
    }

    private func moveItems(from source: IndexSet, to destination: Int) {
        var revisedItems = unpurchasedItems
        revisedItems.move(fromOffsets: source, toOffset: destination)
        for (i, item) in revisedItems.enumerated() {
            item.sortIndex = i
        }
        try? context.save()
        WidgetCenter.shared.reloadAllTimelines()
    }
}
