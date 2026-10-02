//
//  MethodCode.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 02/10/26.
//

struct MethodCode: Equatable {
    let game: String
    let isEvolution: Bool
    let isSoftReset: Bool
    let needsDLC: Bool
    
    init(_ raw: String) { // "E$SV*"
        var rest = raw
        
        isEvolution = rest.hasPrefix("E")
        if isEvolution {
            rest.removeFirst()
        }
        
        isSoftReset = rest.hasPrefix("$")
        if isSoftReset {
            rest.removeFirst()
        }
        
        needsDLC = rest.hasSuffix("*")
        if needsDLC {
            rest.removeLast()
        }
        
        game = rest
    }
}
