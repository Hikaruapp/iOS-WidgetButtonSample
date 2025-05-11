// Shared/ShoppingItem.swift

import Foundation
import SwiftData

@Model
class ShoppingItem {
    @Attribute(.unique) var id: String = UUID().uuidString
    var name: String
    var quantity: Int
    var isPurchased: Bool = false
    var uuu: String = UUID().uuidString
    var sortIndex: Int

    init(
        name: String,
        quantity: Int,
        sortIndex: Int,
        id: String = UUID().uuidString,
        isPurchased: Bool = false
    ) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.isPurchased = isPurchased
        self.sortIndex = sortIndex
    }
}
