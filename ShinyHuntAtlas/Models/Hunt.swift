//
//  Hunt.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 08/10/26.
//

import Foundation

struct Hunt: Hashable {
    let pokemonID: Pokemon.ID
    let method: HuntMethod
    var odds: OddsPreset              // the whole preset, not just the number (Z-A has two 1/1024s)
    var encounters = 0
    var startedAt: Date = .now
}
