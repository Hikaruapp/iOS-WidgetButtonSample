// buycheck.widget/buycheck_widgetBundle.swift

import WidgetKit
import SwiftUI

@main
struct buycheck_widgetBundle: WidgetBundle {
    @WidgetBundleBuilder
    var body: some Widget {
        BuyCheckWidget()
    }
}
