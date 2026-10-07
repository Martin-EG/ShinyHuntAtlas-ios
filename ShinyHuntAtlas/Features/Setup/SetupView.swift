//
//  SetupView.swift
//  ShinyHuntAtlas
//
//  Created by Martin Espericueta on 03/10/26.
//

import SwiftUI

struct SetupView: View {
    @Environment(HuntStore.self) private var store
    @State private var isShowingConfirmation = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    ForEach(store.order, id: \.self) { method in
                        let isOn = store.enabled.contains(method)
                        let rank = (store.order.firstIndex(of: method) ?? 0) + 1
                        
                        Toggle(isOn: enabledBinding(for: method)) {
                            HStack(alignment: .center, spacing: 12) {
                                Text("\(rank)")
                                    .font(.subheadline.monospaced()
                                    .weight(.semibold))
                                    .foregroundStyle(Theme.textMuted)
                                    .frame(width: 24, alignment: .trailing)
                                
                                VStack(alignment: .leading, spacing: 2) {
                                    Text(method.title)
                                        .font(.headline)
                                    Text(isOn ? method.rawValue.uppercased() : "Not owned")
                                        .font(.caption.monospaced())
                                        .foregroundStyle(.secondary)
                                }
                            }
                            .opacity(isOn ? 1 : 0.5)

                        }
                    }
                    .onMove { from, to in
                        store.order.move(fromOffsets: from, toOffset: to)
                    }
                } header: {
                    Text("Your order")
                } footer: {
                    Text("Turn off what you don't own. Drag to rank the rest. Number 1 wins ties.")
                }
            }
            .navigationTitle("Hunt setup")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Reset") {
                        isShowingConfirmation = true
                    }
                    .confirmationDialog(
                        "Reset your hunt setup?",
                        isPresented: $isShowingConfirmation,
                        titleVisibility: .visible
                    ) {
                        Button("Yes, reset", role: .destructive) {
                            resetSetup()
                        }
                        Button("Cancel", role: .cancel) { }
                    } message: {
                        Text("Reset Order and Games")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    
    private func enabledBinding(for method: HuntMethod) -> Binding<Bool> {
        Binding(
            get: { store.enabled.contains(method) },
            set: { isOn in
                if isOn { store.enabled.insert(method) } else { store.enabled.remove(method) }
            }
        )
    }
    
    private func resetSetup() {
        store.order = HuntMethod.allCases
        store.enabled = Set(HuntMethod.allCases)
    }
}

#Preview { SetupView().environment(HuntStore()) }
