//
//  FastFastFastMemoWidgetBundle.swift
//  FastFastFastMemoWidget
//
//  Created by 최형우 on 2022/12/29.
//

import WidgetKit
import SwiftUI

@main
struct FastFastFastMemoWidgetBundle: WidgetBundle {
    var body: some Widget {
        FastFastFastMemoLockScreenWidget()
        if #available(iOSApplicationExtension 16.1, *) {
            FastFastFastMemoWidgetLiveActivity()
        }
    }
}
