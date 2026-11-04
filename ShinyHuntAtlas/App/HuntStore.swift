//
//  HuntStore.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 03/10/26.
//

import Foundation
import Observation

@Observable
final class HuntStore {
    // MARK: Static data, loaded once from the bundle
    let pokedex: [Pokemon]
    let methodInfo: [HuntMethod: MethodInfo]
    let games: [String: Game]
    let defaultOrder: [HuntMethod]

    // MARK: User data
    var caught: Set<Pokemon.ID> = []
    var order: [HuntMethod]
    var enabled: Set<HuntMethod> = Set(HuntMethod.allCases)

    init() {
        do {
            pokedex = try DataLoader.pokedex()
            games = try DataLoader.decode([String: Game].self, from: "games")

            let infos = try DataLoader.decode([MethodInfo].self, from: "methods")
            methodInfo = Dictionary(uniqueKeysWithValues: infos.map { ($0.id, $0) })

            let ranked = infos.sorted { $0.defaultRank < $1.defaultRank }.map(\.id)
            defaultOrder = ranked     // a local, because we can't read `self` until every property is set
            order = ranked
        } catch {
            fatalError("Bundled data is broken: \(error)")
        }
    }

    // MARK: Derived
    var engine: HuntEngine { HuntEngine(order: order, enabled: enabled) }

    func shortName(for method: HuntMethod) -> String {
        methodInfo[method]?.short ?? method.rawValue
    }

    func consoleName(for method: HuntMethod) -> String {
        guard let info = methodInfo[method], let game = games[info.game] else { return "" }
        return game.console
    }

    func bestMethodName(for mon: Pokemon) -> String {
        guard let match = engine.best(for: mon) else { return "No method" }
        return shortName(for: match.method)
    }

    // MARK: Caught & setup
    func setCaught(_ mon: Pokemon, _ isOn: Bool) {
        if isOn { caught.insert(mon.id) } else { caught.remove(mon.id) }
    }

    func resetSetup() {
        order = defaultOrder
        enabled = Set(defaultOrder)
    }
}

#if DEBUG
extension HuntStore {
    static func preview(caught: Set<Pokemon.ID> = []) -> HuntStore {
        let store = HuntStore()
        store.caught = caught
        return store
    }
}
#endif
