//
//  ShinyHuntAtlasApp.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 24/09/26.
//

import SwiftUI

@main
struct ShinyHuntAtlasApp: App {
    @State private var store = HuntStore()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(store)
        }
    }
}
