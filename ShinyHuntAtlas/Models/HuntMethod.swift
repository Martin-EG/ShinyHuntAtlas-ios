//
//  HuntMethod.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 02/10/26.
//

/// Identity only. Names, odds and descriptions live in methods.json (see MethodInfo).
enum HuntMethod: String, CaseIterable, Codable, CodingKeyRepresentable {
    case pla          = "pkm-pla"
    case lza          = "pkm-lza"
    case lgpe         = "pkm-lgpe"
    case sv           = "pkm-sv"
    case usumWormhole = "pkm-usum-wormhole"
    case hgssOddEgg   = "pkm-hgss-oddegg"
    case sos          = "pkm-smusum-sos"
    case horde        = "pkm-xyoras-horde"
    case ss           = "pkm-ss"
    case chainFishing = "pkm-xyoras-fishing"
    case bdspRadar    = "pkm-bdsp-radar"
    case dexNav       = "pkm-oras-dexnav"
    case friendSafari = "pkm-xy-safari"
    case xyRadar      = "pkm-xy-radar"
}
