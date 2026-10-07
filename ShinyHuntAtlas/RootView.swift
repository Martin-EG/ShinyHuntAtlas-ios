//
//  RootView.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 03/10/26.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        TabView {
            Tab("Dex", systemImage: "sparkles") {
                DexView()
            }
            Tab("Hunts", systemImage: "timer") {
                Text("Lesson 8")
            }
            Tab("Methods", systemImage: "list.number") {
                Text("Coming soon")
            }
            Tab("Setup", systemImage: "gearshape") {
                SetupView()
            }
        }
        .tint(Theme.navy)
    }
}
