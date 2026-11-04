//
//  HuntEngineTests.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 02/10/26.
//

import Testing
@testable import ShinyHuntAtlas

struct HuntEngineTests {
    let gible = Pokemon.preview     // pla, lza, sv, dexNav

    @Test func picksHighestRankedMethod() {
        let engine = HuntEngine(order: [.pla, .sv], enabled: [.pla, .sv])
        #expect(engine.best(for: gible)?.method == .pla)
    }

    @Test func respectsUserOrder() {
        let engine = HuntEngine(order: [.sv, .pla], enabled: [.pla, .sv])
        #expect(engine.best(for: gible)?.method == .sv)
    }

    @Test func skipsGamesYouDontOwn() {
        let engine = HuntEngine(order: [.pla, .sv], enabled: [.sv])
        #expect(engine.best(for: gible)?.method == .sv)
    }

    @Test func returnsNilWhenNothingIsAvailable() {
        let engine = HuntEngine(order: [.bdspRadar], enabled: [.bdspRadar])
        #expect(engine.best(for: gible) == nil)
    }
}
