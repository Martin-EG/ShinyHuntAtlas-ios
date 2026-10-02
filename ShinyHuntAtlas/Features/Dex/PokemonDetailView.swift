//
//  PokemonDetailView.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 29/09/26.
//

import SwiftUI

struct PokemonDetailView: View {
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
        .safeAreaInset(edge: .bottom) { catchButton }
    }
    
    private var header: some View {
        HStack(spacing: 16) {
            Image(systemName: "sparkles")
                .font(.system(size: 44))
                .foregroundStyle(Theme.gold)
                .frame(width: 96, height: 96)
                .background(.white, in: .rect(cornerRadius: 18))
            
            VStack(alignment: .leading, spacing: 2) {
                Text(String(format: "#%04d", pokemon.dex))
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
    
    private var bestHuntCard: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text("Best hunt in your game")
                .font(.caption.monospaced().weight(.semibold))
                .textCase(.uppercase)
                .foregroundStyle(Theme.textMuted)
            Text("BDSP PokeRadar")
                .font(.title3.bold())
                .foregroundStyle(Theme.navy)
            Text("Brilliant Diamond / Shining Pearl · Switch")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(16)
            .background(.white, in: .rect(cornerRadius: 18))
            .overlay(
                RoundedRectangle(cornerRadius: 18)
                    .stroke(Theme.border)
            )
    }
    
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
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(.bar)
    }
}

#Preview {
    @Previewable @State var caught = false
    
    NavigationStack {
        PokemonDetailView(pokemon: .samples[3], isCaught: $caught)
    }
}
