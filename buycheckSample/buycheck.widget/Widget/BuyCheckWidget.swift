// buycheck.widget/Widget/BuyCheckWidget.swift

import WidgetKit
import SwiftUI
import AppIntents

struct BuyCheckWidget: Widget {
    let kind: String = "BuyCheckWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: ShoppingTimelineProvider()) { entry in
            BuyCheckEntryView(entry: entry)
        }
        .configurationDisplayName("買い物ウィジェット")
        .description("次に買うアイテムを表示し、タップで購入状態を切り替えます。")
    }
}
