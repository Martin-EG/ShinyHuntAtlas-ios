//
//  Pokemon.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 26/09/26.
//

struct Pokemon: Identifiable {
    let dex: Int
    let name: String
    let form: String?
    let comment: String?
    
    var id: String { "\(dex)-\(form ?? "base")" }
    var displayName: String {
        guard let form else {
            return name
        }
        
        return "\(name) (\(form))"
    }
}

extension Pokemon {
    static let samples: [Pokemon] = [
        Pokemon(dex: 387, name: "Turtwig",  form: nil, comment: nil),
        Pokemon(dex: 390, name: "Chimchar", form: nil, comment: nil),
        Pokemon(dex: 393, name: "Piplup",   form: nil, comment: nil),
        Pokemon(dex: 443, name: "Gible",    form: nil, comment: nil),
        Pokemon(dex: 444, name: "Gabite",   form: nil, comment: nil),
        Pokemon(dex: 445, name: "Garchomp", form: nil, comment: nil),
        Pokemon(dex: 447, name: "Riolu",    form: nil, comment: nil),
        Pokemon(dex: 448, name: "Lucario",  form: nil, comment: nil),
    ]
}
