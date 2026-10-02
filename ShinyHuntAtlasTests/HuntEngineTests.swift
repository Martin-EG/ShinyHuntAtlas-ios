//
//  HuntEngineTests.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 02/10/26.
//

import Testing
@testable import ShinyHuntAtlas

struct HuntEngineTests {
    let gible = Pokemon(
        dex: 443,
        name: "Gible",
        form: nil,
        comment: nil,
        methods: [.bdsp: "BDSP", .sv: "SV"]
    )
    
    @Test func picksHighestRankedMethod() {
        let engine = HuntEngine(order: [.bdsp, .sv], enabled: [.bdsp, .sv])
        
        #expect(engine.best(for: gible)?.method == .bdsp)
    }
    
    @Test func respectsUserOrder() {
        let engine = HuntEngine(order: [.sv, .bdsp], enabled: [.bdsp, .sv])
        
        #expect(engine.best(for: gible)?.method == .sv)
    }
    
    @Test func skipsGamesYouDontOwn() {
        let engine = HuntEngine(order: [.bdsp, .sv], enabled: [.sv])
        #expect(engine.best(for: gible)?.method == .sv)
    }

    @Test func returnsNilWhenNothingIsAvailable() {
        let engine = HuntEngine(order: [.pla], enabled: [.pla])
        #expect(engine.best(for: gible) == nil)
    }
}
