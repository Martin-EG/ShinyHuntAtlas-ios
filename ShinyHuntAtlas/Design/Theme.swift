//
//  Theme.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 26/09/26.
//

import SwiftUI

extension Color {
    init(hex: UInt32) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }
}

enum Theme {
    static let navy          = Color(hex: 0x101C34)
    static let gold          = Color(hex: 0xFFC62E)
    static let background    = Color(hex: 0xF7F8FC)
    static let border        = Color(hex: 0xE6E8EF)
    static let textMuted     = Color(hex: 0x8A90A3)
    static let tagBackground = Color(hex: 0xFBE7B4)
    static let tagBorder     = Color(hex: 0xF0CE72)
    static let tagText       = Color(hex: 0x6A4A00)
    static let chipBorder = Color(hex: 0xD9DCE6)
    static let chipText   = Color(hex: 0x3D4459)
}
