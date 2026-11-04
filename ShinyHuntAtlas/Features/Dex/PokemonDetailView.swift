//
//  PokemonDetailView.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 29/09/26.
//

import SwiftUI

struct PokemonDetailView: View {
    @Environment(HuntStore.self) private var store
    let pokemon: Pokemon
    @Binding var isCaught: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                header
                bestHuntCard
                huntCard
            }
            .padding(20)
        }
        .background(Theme.background)
        .navigationTitle(pokemon.displayName)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ShareLink(
                item: "I'm hunting a shiny \(pokemon.displayName) ✦ ShinyHunt Atlas"
            )
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 10) {
                if store.hunt(for: pokemon) != nil {
                    HStack(spacing: 10) {
                        counterButton("−1", delta: -1)
                        counterButton("+1 encounter", delta: 1, prominent: true)
                        counterButton("+10", delta: 10)
                    }
                }
                catchButton
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(.bar)
        }
    }

    // MARK: Header

    private var header: some View {
        HStack(spacing: 16) {
            SpriteView(pokemon: pokemon, size: 96)
                .background(.white, in: .rect(cornerRadius: 18))

            VStack(alignment: .leading, spacing: 2) {
                Text(String(format: "#%04d", pokemon.dexNumber))
                    .font(.caption.monospaced())
                    .foregroundStyle(Theme.textMuted)
                Text(pokemon.displayName)
                    .font(.title.bold())
                    .foregroundStyle(Theme.navy)
                Label(
                    isCaught ? "Caught" : "Not caught yet",
                    systemImage: isCaught ? "checkmark.seal.fill" : "circle.dashed"
                )
                .font(.subheadline)
                .foregroundStyle(.secondary)
            }
        }
    }

    // MARK: Best hunt

    private var bestHuntCard: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Best hunt in your games")
                .font(.caption.monospaced().weight(.semibold))
                .textCase(.uppercase)
                .foregroundStyle(Theme.textMuted)

            if let match = store.engine.best(for: pokemon),
               let info = store.methodInfo[match.method] {          // two unwraps in one `if`
                Text(info.short)
                    .font(.title3.bold())
                    .foregroundStyle(Theme.navy)
                Text(store.games[info.game]?.name ?? "")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(info.oddsWithoutCharm)
                    .font(.footnote.monospaced())
                    .foregroundStyle(Theme.navy)
            } else {
                Text("Not huntable in your games")
                    .font(.title3.bold())
                    .foregroundStyle(Theme.navy)
            }
        }
        .card()
    }

    // MARK: Hunt counter

    @ViewBuilder
    private var huntCard: some View {
        if let hunt = store.hunt(for: pokemon) {
            let chance = Odds.chanceByNow(encounters: hunt.encounters,
                                          denominator: hunt.odds.denominator)
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .firstTextBaseline, spacing: 10) {
                    Text(hunt.encounters.formatted())                  // 1284 → "1,284"
                        .font(.system(size: 48, weight: .bold, design: .monospaced))
                        .contentTransition(.numericText())
                        .foregroundStyle(Theme.navy)
                    Text("encounters\nthis hunt")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                }

                Text("\(chance.formatted(.percent.precision(.fractionLength(1)))) of hunts at 1/\(hunt.odds.denominator) find a shiny by now. The next encounter is still 1 in \(hunt.odds.denominator).")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)

                Picker("Odds", selection: oddsBinding(for: hunt)) {
                    ForEach(presets(for: hunt), id: \.self) { preset in
                        Text("\(preset.label) · 1/\(preset.denominator)")
                            .tag(preset)
                    }
                }
                .pickerStyle(.menu)
                .tint(Theme.navy)
            }
            .card()
        } else if store.engine.best(for: pokemon) != nil {
            Button("Start hunting \(pokemon.name)", systemImage: "play.fill") {
                withAnimation(.snappy) { store.startHunt(for: pokemon) }
            }
            .buttonStyle(.borderedProminent)
            .tint(Theme.navy)
        }
    }

    private func presets(for hunt: Hunt) -> [OddsPreset] {
        store.methodInfo[hunt.method]?.oddsPresets ?? []
    }

    private func oddsBinding(for hunt: Hunt) -> Binding<OddsPreset> {
        Binding(
            get: { store.hunt(for: pokemon)?.odds ?? hunt.odds },   // read fresh from the store
            set: { store.setOdds($0, for: pokemon) }                // write through the store
        )
    }

    private func counterButton(_ title: String, delta: Int, prominent: Bool = false) -> some View {
        Button {
            withAnimation(.snappy) { store.addEncounters(delta, to: pokemon) }
        } label: {
            Text(title)
                .font(prominent ? .title3.bold() : .headline.monospacedDigit())
                .foregroundStyle(prominent ? Color.white : Theme.navy)
                .frame(maxWidth: prominent ? .infinity : 64)
                .frame(height: 64)                                 // the design's thumb-zone target
                .background(prominent ? Theme.navy : Color.white, in: .rect(cornerRadius: 16))
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(prominent ? Theme.navy : Theme.border))
        }
        .buttonStyle(.plain)
        .buttonRepeatBehavior(.enabled)       // hold the button to keep counting
        .sensoryFeedback(.increase, trigger: store.hunt(for: pokemon)?.encounters)
    }

    // MARK: Catch

    private var catchButton: some View {
        Button {
            withAnimation(.snappy) {
                isCaught.toggle()
            }
        } label: {
            Label(
                isCaught ? "Caught!" : "Mark \(pokemon.displayName) as caught",
                systemImage: isCaught ? "checkmark" : "sparkle"
            )
            .font(.headline)
            .foregroundStyle(isCaught ? Theme.navy : Color.white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                isCaught ? Theme.gold : Theme.navy,
                in: .rect(cornerRadius: 14)
            )
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.success, trigger: isCaught)
    }
}

#Preview {
    @Previewable @State var caught = false

    NavigationStack {
        PokemonDetailView(pokemon: .preview, isCaught: $caught)
    }
    .environment(HuntStore.preview())
}
