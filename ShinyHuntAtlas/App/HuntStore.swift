//
//  HuntStore.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 03/10/26.
//

import Observation

@Observable
final class HuntStore {
    var caught: Set<Pokemon.ID> = []
    var order: [HuntMethod] = HuntMethod.allCases
    var enabled: Set<HuntMethod> = Set(HuntMethod.allCases)
    
    var engine: HuntEngine {
        HuntEngine(order: order, enabled: enabled)
    }
    
    func setCaught(_ mon: Pokemon, _ isOn: Bool) {
        if isOn {
            caught.insert(mon.id)
        } else {
            caught.remove(mon.id)
        }
    }
}
