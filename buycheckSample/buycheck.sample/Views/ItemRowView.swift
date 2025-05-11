// Views/ItemRowView.swift

import SwiftUI

struct ItemRowView: View {
    let item: ShoppingItem

    var body: some View {
        HStack {
            Text(item.name)
            Spacer()
            Text("×\(item.quantity)")
            if item.isPurchased {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.green)
            }
        }
    }
}
