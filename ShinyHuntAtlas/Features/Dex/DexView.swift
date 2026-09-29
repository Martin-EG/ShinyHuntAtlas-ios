//
//  DexView.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 28/09/26.
//

import SwiftUI

struct DexView: View {
    @State private var caught: Set<Pokemon.ID> = []
    @State private var query = ""
    @State private var onlyUncaught = false
    
    private let pokedex = Pokemon.samples
    
    private var results: [Pokemon] {
        pokedex.filter {
            mon in
            let matchesQuery = query.isEmpty
                || mon.displayName.localizedStandardContains(query)
                || String(mon.dex).contains(query)
            let matchesChip = !onlyUncaught || !caught.contains(mon.id)
            
            return matchesQuery && matchesChip
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ProgressView(
                        "Living dex \(caught.count) / \(pokedex.count)",
                        value: Double(caught.count), total: Double(pokedex.count)
                    )
                        .tint(Theme.gold)
                    
                    FilterChip(title: "Not caught", isOn: $onlyUncaught)
                    
                    Text("\(results.count) Pokemon")
                        .font(.footnote.monospaced())
                        .foregroundStyle(.secondary)
                    
                    LazyVGrid(
                        columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ],
                        spacing: 12
                    ) {
                        ForEach(results) { mon in
                            DexCard(
                                pokemon: mon,
                                isCaught: caughtBinding(for: mon),
                                methodTag: "BDSP Pokeradar"
                            )
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .background(Theme.background)
            .navigationTitle("Dex")
            .searchable(text: $query, prompt: "Search name or dex number")
        }
    }
    
    
    private func caughtBinding(for mon: Pokemon) -> Binding<Bool> {
        Binding(
            get: { caught.contains(mon.id) },
            set: { isOn in
                if isOn {
                    caught.insert(mon.id)
                } else {
                    caught.remove(mon.id)
                }
            }
        )
    }
}

#Preview {
    DexView()
}
