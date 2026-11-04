//
//  Odds.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 08/10/26.
//

import Foundation

enum Odds {
    /// Chance that at least one shiny appeared in `encounters` tries at 1/`denominator`.
    /// P = 1 − (1 − 1/n)^k
    static func chanceByNow(encounters: Int, denominator: Int) -> Double {
        guard encounters > 0, denominator > 0 else { return 0 }
        let miss = 1 - 1 / Double(denominator)
        return 1 - pow(miss, Double(encounters))
    }
}
