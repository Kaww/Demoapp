//
//  SpringAnimationControlPanelSettings.swift
//  Demoapp
//
//  Created by KAWRANTIN LE GOFF on 09/11/2021.
//

import SwiftUI

struct SpringAnimationControlPanelSettings: View {
    @Environment(\.presentationMode) var presentationMode

    @Binding var extendValues: Bool
    var extensionRatio: Double
    @Binding var customResponse: Double?
    @Binding var customDamping: Double?
    @Binding var customBlend: Double?

    var body: some View {
        NavigationView {
            List {
                Section {
                    Toggle(isOn: $extendValues) {
                        Label("Extend values by \(Int(extensionRatio))x", systemImage: "arrow.left.and.right")
                    }
                }

                Section {
                    TextField("Response", value: $customResponse, formatter: formatter)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Custom response:")
                }

                Section {
                    TextField("Damping", value: $customDamping, formatter: formatter)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Custom damping fraction:")
                }

                Section {
                    TextField("Blend", value: $customBlend, formatter: formatter)
                        .keyboardType(.decimalPad)
                } header: {
                    Text("Custom blend duration:")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: dismiss) {
                        Label("Dismiss", systemImage: "multiply")
                            .font(.system(size: 18, weight: .medium))
                    }
                }
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }

    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()

    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct SpringAnimationControlPanelSettings_Previews: PreviewProvider {
    static var previews: some View {
        SpringAnimationControlPanelSettings(
            extendValues: .constant(true),
            extensionRatio: 4.0,
            customResponse: .constant(nil),
            customDamping: .constant(4.8),
            customBlend: .constant(nil)
        )
    }
}

#if canImport(UIKit)
private extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
