// Views/AddItemView.swift

import SwiftUI
import SwiftData
import WidgetKit

struct AddItemView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var quantity: Int = 1
    @Query private var items: [ShoppingItem]

    var body: some View {
        VStack {
            Form {
                Section (header: Text("アイテム")) {
                    TextField("商品名", text: $name)
                    Stepper("個数: \(quantity)", value: $quantity, in: 1...99)
                    Button("追加") {
                        print("追加ボタン押下: name=\(name), quantity=\(quantity), currentCount=\(items.count)")
                        let newItem = ShoppingItem(name: name, quantity: quantity, sortIndex: items.count)
                        context.insert(newItem)
                        WidgetCenter.shared.reloadAllTimelines()
                        dismiss()
                    }
                }
            }
        }
        .navigationTitle("商品追加")
    }
}
