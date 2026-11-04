//
//  SpriteView.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 08/10/26.
//

import SwiftUI

struct SpriteView: View {
    let pokemon: Pokemon
    let size: CGFloat

    var body: some View {
        Group {
            if let url = pokemon.spriteURL {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .success(let image): pixelArt(image)
                    case .failure:            fallback          // only now try PokeAPI
                    case .empty:              ProgressView()
                    @unknown default:         placeholder
                    }
                }
            } else {
                fallback                                        // no sprite ID at all
            }
        }
        .frame(width: size, height: size)
    }

    @ViewBuilder
    private var fallback: some View {
        if let url = pokemon.fallbackSpriteURL {
            AsyncImage(url: url) { phase in
                if let image = phase.image {
                    pixelArt(image)
                } else if phase.error != nil {
                    placeholder
                } else {
                    ProgressView()
                }
            }
        } else {
            placeholder
        }
    }

    private func pixelArt(_ image: Image) -> some View {
        image.resizable().interpolation(.none).scaledToFit()
    }

    private var placeholder: some View {
        Image(systemName: "sparkles")
            .font(.system(size: size * 0.4))
            .foregroundStyle(Theme.textMuted)
    }
}

#Preview("Normal") {
    SpriteView(pokemon: .preview, size: 96)
}

#Preview("Primary fails → fallback") {
    // "9999" doesn't exist on pokejungle, so this forces the PokeAPI fallback for #443
    SpriteView(pokemon: Pokemon(dexNumber: 443, slug: "test-fallback", name: "Gible",
                                form: nil, note: nil, sprite: "9999", methods: [:]),
               size: 96)
}

#Preview("No sprite") {
    SpriteView(pokemon: Pokemon(dexNumber: 0, slug: "test-none", name: "Missing",
                                form: nil, note: nil, sprite: nil, methods: [:]),
               size: 96)
}
