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
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(store)
        }
        .onChange(of: scenePhase) { _, newPhase in
            if newPhase == .background { store.save() }
        }
    }
}
