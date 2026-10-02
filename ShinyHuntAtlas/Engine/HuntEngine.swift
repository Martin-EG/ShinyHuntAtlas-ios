//
//  HuntEngine.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 02/10/26.
//

struct Match: Equatable {
    let method: HuntMethod
    let code: String
}

struct HuntEngine {
    let order: [HuntMethod]
    let enabled: Set<HuntMethod>
    
    func bestTwo(for mon: Pokemon) -> [Match] {
        var found: [Match] = []
        for method in order where enabled.contains(method) {
            if let code = mon.methods[method] {
                found.append(Match(method: method, code: code))
                if found.count == 2 { break }
            }
        }
        
        return found
    }
    
    func best(for mon: Pokemon) -> Match? {
        bestTwo(for: mon).first
    }
}
