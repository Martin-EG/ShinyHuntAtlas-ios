//
//  DexPairDemo.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 26/09/26.
//

import SwiftUI

struct DexPairDemo: View {
    @State private var gible = Pokemon(dex: 443, name: "Gible", form: nil, comment: nil)
    @State private var gabite = Pokemon(dex: 444, name: "Gabite", form: nil, comment: nil)
    private var team: [Pokemon] { [gible, gabite] }
    
    
    var body: some View {
        VStack(spacing: 2) {
            Text("Caught \(team.filter { $0.isCaught }.count)/\(team.count)")
            
            HStack(spacing: 12) {
                DexCard(
                    pokemon: $gible,
                    methodTag: "BDSP Pokeradar"
                )
                
                DexCard(
                    pokemon: $gabite,
                    methodTag: "BDSP Pokeradar"
                )
            }
        }
    }
}

#Preview {
    DexPairDemo()
}
