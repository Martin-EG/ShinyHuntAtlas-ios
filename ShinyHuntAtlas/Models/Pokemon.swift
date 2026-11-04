//
//  Pokemon.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 26/09/26.
//

import Foundation

struct Pokemon: Identifiable, Hashable, Decodable {
    let dexNumber: Int
    let slug: String
    let name: String
    let form: String?
    let note: String?
    let sprite: String?
    let methods: [HuntMethod: String]

    var id: String { slug }
    var displayName: String { name }      // the data already includes the form ("Alolan Vulpix")
}

extension Pokemon {
    var spriteURL: URL? {
        sprite.flatMap { URL(string: "https://pokejungle.net/sprites/shiny/\($0).png") }
    }

    /// PokeAPI fallback, only for base forms (a plain 4-digit sprite ID).
    var fallbackSpriteURL: URL? {
        guard let sprite, sprite.count == 4, sprite.allSatisfy(\.isNumber) else { return nil }
        return URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/\(dexNumber).png")
    }
}

#if DEBUG
extension Pokemon {
    // A real entry for previews and tests
    static let preview = Pokemon(
        dexNumber: 443, slug: "gible", name: "Gible", form: nil, note: nil, sprite: "0443",
        methods: [.pla: "PLA", .lza: "ZA", .sv: "SV", .dexNav: "DN"]
    )
}
#endif
