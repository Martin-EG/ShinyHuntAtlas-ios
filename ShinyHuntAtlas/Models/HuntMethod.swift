//
//  HuntMethod.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 02/10/26.
//

enum HuntMethod: String, CaseIterable {
    case pla, za, lg, sv, uw, g4, sos, h, ss, cf, bdsp, dn, fs, pr

    var title: String {
        switch self {
        case .pla: "Legends: Arceus"
        case .za:  "Legends: ZA"
        case .lg:  "Let's go Pikachu/Eevee"
        case .sv:  "Scarlet & Violet"
        case .uw:  "Ultra Sun & Ultra Moon"
        case .g4:  "Gen 4 HGSS/DP/PT"
        case .sos:  "Sun & Moon SOS"
        case .h:  "X/Y/ORAS Horde"
        case .ss:  "Sword & Shield"
        case .cf:  "X/Y/ORAS Chain Fishing"
        case .bdsp:  "Brilliant Diamond & Shining Pearl"
        case .dn:  "ORAS DexNav"
        case .fs:  "X/Y Friend Safari"
        case .pr:  "X/Y PokeRadar"
        default:   rawValue.uppercased()
        }
    }
}
