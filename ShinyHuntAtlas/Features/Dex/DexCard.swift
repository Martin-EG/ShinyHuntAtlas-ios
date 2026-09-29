//
//  DexCard.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 26/09/26.
//

import SwiftUI

struct DexCard: View {
    let pokemon: Pokemon
    @Binding var isCaught: Bool
    let methodTag: String
    
    var body: some View {
        VStack(spacing: 2) {
            Image(systemName: "sparkles")
                .font(.system(size: 36))
                .foregroundStyle(Theme.gold)
                .frame(width: 76, height: 76)
            
            Text(String(format: "#%04d", pokemon.dex)) // 443 -> #0443
                .font(.caption.monospaced())
                .foregroundStyle(Theme.textMuted)
            
            Text(pokemon.displayName)
                .font(.headline)
                .foregroundStyle(Theme.navy)
            
            Text(methodTag)
                .font(.caption.monospaced().weight(.semibold))
                .foregroundStyle(Theme.tagText)
                .padding(.horizontal, 9)
                .padding(.vertical, 3)
                .background(Theme.tagBackground, in: .rect(cornerRadius: 8))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Theme.tagBorder))
                .padding(.top, 6)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 14)
        .background(.white, in: .rect(cornerRadius: 18))
        .overlay(
            RoundedRectangle(cornerRadius: 18).stroke(Theme.border)
        )
        .overlay(alignment: .topTrailing) {
            caughtButton
        }
    }
    
    private var caughtButton: some View {
        Button {
            withAnimation(.snappy) {
                isCaught.toggle()
            }
        } label: {
            Image(
                systemName: isCaught
                    ? "checkmark"
                    : "sparkle"
            )
            .contentTransition(.symbolEffect(.replace))
                .frame(width: 44, height: 44)
                .background(
                    isCaught
                        ? Theme.gold
                        : Theme.background,
                    in: .rect(cornerRadius: 14)
                )
        }
        .sensoryFeedback(.success, trigger: isCaught)
        .foregroundStyle(
            isCaught
                ? Theme.navy
                : Theme.textMuted
        )
        .accessibilityLabel(
            isCaught
                ? "Caught"
                : "Mark as caught")
        .padding(8)
    }
}

#Preview {
    @Previewable @State var gible = Pokemon(dex: 443, name: "Gible", form: nil, comment: nil)
    @Previewable @State var caught = false
    
    DexCard(pokemon: .samples[3], isCaught: $caught, methodTag: "BDSP PokéRadar")
    .frame(width: 180)
    .padding()
    .background(Theme.background)
}

