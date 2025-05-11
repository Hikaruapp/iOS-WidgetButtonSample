// Shared/ShoppingModelContainer.swift

import Foundation
import SwiftData

enum ShoppingModelContainer {
    static var container: ModelContainer {
        // App Group のディレクトリURLを取得
        guard let directory = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: Constants.appGroupID) else {
            fatalError("App Group container URL not found")
        }

        // SQLiteファイル名を指定
        let storeURL = directory.appendingPathComponent("ShoppingModel.sqlite")

        // スキーマを明示
        let schema = Schema([ShoppingItem.self])

        // URL付きの構成を定義
        let config = ModelConfiguration("ShoppingModel", url: storeURL)

        // コンテナ初期化
        guard let container = try? ModelContainer(for: schema, configurations: [config]) else {
            fatalError("Failed to initialize ModelContainer")
        }

        return container
    }
}
