//
//  MethodInfo.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 06/10/26.
//

struct Game: Decodable {
    let name: String
    let console: String
}

struct OddsPreset: Codable, Hashable {
    let label: String
    let denominator: Int
}

struct MethodInfo: Decodable, Identifiable {
    let id: HuntMethod
    let game: String              // a key into games.json, e.g. "pkm-bdsp"
    let short: String
    let name: String
    let description: String
    let oddsWithoutCharm: String
    let oddsWithCharm: String
    let oddsNote: String?
    let oddsPresets: [OddsPreset]
    let defaultRank: Int
}
