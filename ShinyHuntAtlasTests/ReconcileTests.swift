//
//  ReconcileTests.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 04/11/26.
//

import Testing
@testable import ShinyHuntAtlas

struct ReconcileTests {
    @Test func keepsUserOrderAndAppendsNewMethods() {
        #expect(HuntStore.reconcile(saved: [.sv, .pla], defaults: [.pla, .lza, .sv]) == [.sv, .pla, .lza])
    }

    @Test func removesDuplicates() {
        #expect(HuntStore.reconcile(saved: [.sv, .sv], defaults: [.sv, .pla]) == [.sv, .pla])
    }

    @Test func emptySavedOrderGivesDefaults() {
        #expect(HuntStore.reconcile(saved: [], defaults: [.pla, .sv]) == [.pla, .sv])
    }
}
