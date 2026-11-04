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
            catchButton
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
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(.white, in: .rect(cornerRadius: 18))
        .overlay(RoundedRectangle(cornerRadius: 18).stroke(Theme.border))
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
