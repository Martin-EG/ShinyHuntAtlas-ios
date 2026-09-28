//
//  Pokemon.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 26/09/26.
//

struct Pokemon {
    let dex: Int
    let name: String
    let form: String?
    let comment: String?
    var isCaught: Bool = false
    
    var displayName: String {
        guard let form else {
            return name
        }
        
        return "\(name) (\(form))"
    }
}
