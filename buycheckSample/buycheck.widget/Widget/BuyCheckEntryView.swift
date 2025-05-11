import SwiftUI
import WidgetKit
import AppIntents

struct BuyCheckEntryView: View {
    var entry: SimpleEntry

    var body: some View {
        let limitedItems = entry.items.prefix(3)
        VStack(alignment: .leading, spacing: 12) {
            Text("買うものリスト(上位３件)")
                .font(.headline)

            ForEach(limitedItems, id: \.id) { item in
                let intent: TogglePurchasedIntent = {
                    let i = TogglePurchasedIntent()
                    i.itemID = item.id
                    return i
                }()

                Button(intent: intent) {
                    HStack {
                        Text(item.name)
                            .strikethrough(item.isPurchased)
                            .foregroundColor(item.isPurchased ? .gray : .primary)
                            .lineLimit(1)
                            .truncationMode(.tail)

                        Spacer()

                        Text("\(item.quantity)個")
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .padding()
        .containerBackground(.fill.tertiary, for: .widget)
    }
}
