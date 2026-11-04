//
//  DataTests.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 06/10/26.
//

import Testing
@testable import ShinyHuntAtlas

struct DataTests {
    @Test func pokedexLoadsEveryPokemon() throws {
        #expect(try DataLoader.pokedex().count == 1081)
    }

    @Test func slugsAreUnique() throws {
        let slugs = try DataLoader.pokedex().map(\.slug)
        #expect(Set(slugs).count == slugs.count)       // this would have caught the Nidoran bug
    }

    @Test func defaultRanksAreUniqueAndComplete() throws {
        let infos = try DataLoader.decode([MethodInfo].self, from: "methods")
        #expect(infos.map(\.defaultRank).sorted() == Array(1...HuntMethod.allCases.count))
    }

    @Test func fallbackSpriteOnlyForBaseForms() {
        #expect(Pokemon.preview.fallbackSpriteURL != nil)                    // "0443"
        let alolan = Pokemon(dexNumber: 37, slug: "alolan-vulpix-alola", name: "Alolan Vulpix",
                             form: "Alola", note: nil, sprite: "0037-1", methods: [:])
        #expect(alolan.fallbackSpriteURL == nil)
    }
}
