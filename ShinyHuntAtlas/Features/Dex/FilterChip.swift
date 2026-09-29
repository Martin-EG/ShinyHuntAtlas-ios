//
//  FilterChipt.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 28/09/26.
//
import SwiftUI

struct FilterChip: View {
    let title: String
    @Binding var isOn: Bool

    
    var body: some View {
        Button {
            withAnimation(.snappy) {
                isOn.toggle()
            }
        } label: {
            HStack(spacing: 6) {
                if isOn {
                    Image(systemName: "checkmark")
                }
                
                Text(title)
            }
            .font(.subheadline.weight(.semibold))
            .foregroundStyle(isOn ? Color.white : Theme.chipText)
            .padding(.horizontal, 14)
            .frame(height: 40)
            .background(
                isOn ? Theme.navy : Color.white,
                in: .capsule)
            .overlay(
                Capsule().stroke(
                    isOn ? Theme.navy : Theme.chipBorder
                )
            )
        }
        .buttonStyle(.plain)
        .sensoryFeedback(.selection, trigger: isOn)
        .accessibilityAddTraits(
            isOn ? .isSelected : []
        )
    }
 
}

#Preview {
    @Previewable @State var onlyUncaught = false
    
    FilterChip(title: "Not caught", isOn: $onlyUncaught)
}
