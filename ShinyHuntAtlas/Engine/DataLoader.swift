//
//  DataLoader.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 06/10/26.
//

import Foundation

enum DataLoader {
    enum LoadError: Error {
        case missingFile(String)
    }

    /// Decode any bundled JSON file into any Decodable type.
    static func decode<T: Decodable>(_ type: T.Type, from file: String) throws -> T {
        guard let url = Bundle.main.url(forResource: file, withExtension: "json") else {
            throw LoadError.missingFile(file)
        }
        return try JSONDecoder().decode(T.self, from: Data(contentsOf: url))
    }

    static let generationFiles = [
        "gen-1-kanto", "gen-2-johto", "gen-3-hoenn", "gen-4-sinnoh", "gen-5-unova",
        "gen-6-kalos", "gen-7-alola", "gen-8-galar-hisui", "gen-9-paldea",
    ]

    static func pokedex() throws -> [Pokemon] {
        try generationFiles.flatMap { try decode([Pokemon].self, from: $0) }
    }
}
