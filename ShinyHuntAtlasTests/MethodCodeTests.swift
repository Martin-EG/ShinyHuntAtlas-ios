//
//  MethodCodeTests.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 02/10/26.
//
import Testing
@testable import ShinyHuntAtlas

struct MethodCodeTests {
    @Test func plain() {
        let c = MethodCode("PLA")
        #expect(c.game == "PLA")
        #expect(!c.isEvolution && !c.isSoftReset && !c.needsDLC)
    }
    @Test func softReset() {
        let c = MethodCode("$LG")
        #expect(c.isSoftReset && c.game == "LG")
    }
    @Test func dlc() {
        let c = MethodCode("SV*")
        #expect(c.needsDLC && c.game == "SV")
    }
    @Test func everything() {
        let c = MethodCode("E$SV*")
        #expect(c.isEvolution && c.isSoftReset && c.needsDLC)
        #expect(c.game == "SV")
    }
}
