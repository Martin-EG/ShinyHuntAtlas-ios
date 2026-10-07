//
//  DexView.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 28/09/26.
//

import SwiftUI

struct DexView: View {
    @Environment(HuntStore.self) private var store
    @State private var query = ""
    @State private var onlyUncaught = false
    @State private var path: [Pokemon] = []
    
    private let pokedex = Pokemon.samples
    private var uncaughtPokemon: [Pokemon] {
        pokedex.filter { !store.caught.contains($0.id) }
   }
    
    private var results: [Pokemon] {
        pokedex.filter {
            mon in
            let matchesQuery = query.isEmpty
                || mon.displayName.localizedStandardContains(query)
                || String(mon.dex).contains(query)
            let matchesChip = !onlyUncaught || !store.caught.contains(mon.id)
            
            return matchesQuery && matchesChip
        }
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    ProgressView(
                        "Living dex \(store.caught.count) / \(pokedex.count)",
                        value: Double(store.caught.count), total: Double(pokedex.count)
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
                            NavigationLink(value: mon) {
                                DexCard(
                                    pokemon: mon,
                                    isCaught: caughtBinding(for: mon),
                                    methodTag: store.engine.best(for: mon)?.method.title ?? "No method"
                                )
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            .toolbar {
                Button("Pick my next hunt", systemImage: "dice") {
                    goToRandomPokemonView()
                }
                .disabled(
                    uncaughtPokemon.isEmpty
                )
            }
            .background(Theme.background)
            .navigationTitle("Dex")
            .navigationDestination(for: Pokemon.self) { mon in
                PokemonDetailView(
                    pokemon: mon,
                    isCaught: caughtBinding(for: mon))
            }
            .searchable(text: $query, prompt: "Search name or dex number")
        }
    }
    
    
    private func caughtBinding(for mon: Pokemon) -> Binding<Bool> {
        Binding(
            get: { store.caught.contains(mon.id) },
            set: { isOn in
                if isOn {
                    store.caught.insert(mon.id)
                } else {
                    store.caught.remove(mon.id)
                }
            }
        )
    }
    
    private func goToRandomPokemonView() {
        guard let randomPokemon = uncaughtPokemon.randomElement() else { return }
        
        path.append(randomPokemon)
    }
}

#Preview { DexView().environment(HuntStore())
}
