//
//  OddsTests.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 08/10/26.
//

import Testing
@testable import ShinyHuntAtlas

struct OddsTests {
    @Test func noEncountersMeansNoChance() {
        #expect(Odds.chanceByNow(encounters: 0, denominator: 99) == 0)
    }

    @Test func oneInOneIsCertain() {
        #expect(Odds.chanceByNow(encounters: 1, denominator: 1) == 1)
    }

    @Test func reachingTheOddsIsOnly63Percent() {
        // 1 − (98/99)^99 ≈ 0.634
        let p = Odds.chanceByNow(encounters: 99, denominator: 99)
        #expect(abs(p - 0.634) < 0.001)
    }

    @Test func designMockupNumbersDontMatchTheMath() {
        // The mockup said "1,284 encounters → 92.4%" at 1/99. It doesn't add up:
        #expect(Odds.chanceByNow(encounters: 1284, denominator: 99) > 0.9999)
        // 92.4% actually happens around 254 encounters:
        #expect(abs(Odds.chanceByNow(encounters: 254, denominator: 99) - 0.924) < 0.001)
    }
}
