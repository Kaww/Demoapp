import SwiftUI

struct SpringAnimationControlPanel: View {

    struct AnimationType: Identifiable {
        var id: Int
        var name: String
    }

    @Binding var response: Double
    private let minResponse: Double = 0
    private let maxResponse: Double = 2.5
    private let responseStep: Double = 0.1
    @State private var customResponse: Double? = nil

    @Binding var damping: Double
    private let minDamping: Double = 0
    private let maxDamping: Double = 2
    private let dampingStep: Double = 0.1
    @State private var customDamping: Double? = nil

    @Binding var blend: Double
    private let minBlend: Double = 0
    private let maxBlend: Double = 2.5
    private let blendStep: Double = 0.1
    @State private var customBlend: Double? = nil

    @State private var extendValues = false
    @State private var extensionRatio: Double = 4.0

    @Binding var selectedAnimationType: AnimationType.ID
    let animationTypes: [AnimationType]

    @State private var showSettingsView = false
    @State private var showShareView = false
    @State private var showInfosView = false

    var body: some View {
        VStack {
            animationTypeControl

            VStack {
                responseSlider
                dampingFractionSlider
                blendDurationSlider
                toolbar
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .foregroundColor(.gray100)
                    .shadow(color: .black.opacity(0.1), radius: 20, x: 0, y: 0)
            )
        }
        .padding()
        .onReceive(customResponse.publisher) { v in response = v }
        .onReceive(customDamping.publisher) { v in damping = v }
        .onReceive(customBlend.publisher) { v in blend = v }
    }

    // MARK: Private methods

    private func extendIfNeeded(_ value: Double) -> Double {
        extendValues ? value * extensionRatio : value
    }

    // MARK: Subview

    private var animationTypeControl: some View {
        Picker("What is your favorite color?", selection: $selectedAnimationType) {
            ForEach(animationTypes) { type in
                Text(type.name).tag(type.id)
            }
        }
        .pickerStyle(.segmented)
        .padding(.horizontal, 10)
    }

    private var responseSlider: some View {
        HStack(spacing: 0) {
            Text("Response")
                .frame(width: 80, alignment: .leading)
            Slider(
                value: $response,
                in: minResponse...extendIfNeeded(maxResponse),
                step: responseStep,
                label: { Text("Response") },
                minimumValueLabel: { Text("") },
                maximumValueLabel: { Text("\(response, specifier: "%.1f")") },
                onEditingChanged: { isEditing in
                    if isEditing {
                        customResponse = nil
                    }
                }
            )
        }
    }

    private var dampingFractionSlider: some View {
        HStack(spacing: 0) {
            Text("Damping")
                .frame(width: 80, alignment: .leading)
            Slider(
                value: $damping,
                in: minDamping...extendIfNeeded(maxDamping),
                step: dampingStep,
                label: { Text("Damping") },
                minimumValueLabel: { Text("") },
                maximumValueLabel: { Text("\(damping, specifier: "%.1f")") },
                onEditingChanged: { isEditing in
                    if isEditing {
                        customDamping = nil
                    }
                }
            )
        }
    }

    private var blendDurationSlider: some View {
        HStack(spacing: 0) {
            Text("Blend")
                .frame(width: 80, alignment: .leading)
            Slider(
                value: $blend,
                in: minBlend...extendIfNeeded(maxBlend),
                step: blendStep,
                label: { Text("Blend") },
                minimumValueLabel: { Text("") },
                maximumValueLabel: { Text("\(blend, specifier: "%.1f")") },
                onEditingChanged: { isEditing in
                    if isEditing {
                        customBlend = nil
                    }
                }
            )
        }
    }

    private var toolbar: some View {
        HStack {
            Button(action: { showInfosView = true }) {
                Image(systemName: "info.circle")
                    .font(.system(size: 22, weight: .medium))
            }
            .sheet(isPresented: $showInfosView) {
                Text("Infos")
            }

            Spacer()

            Button(action: { showShareView = true }) {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 22, weight: .medium))
            }
            .sheet(isPresented: $showShareView) {
                Text("Share")
            }

            Spacer()

            Button(action: { showSettingsView = true }) {
                Image(systemName: "gearshape")
                    .font(.system(size: 22, weight: .medium))
            }
            .sheet(isPresented: $showSettingsView) {
                SpringAnimationControlPanelSettings(
                    extendValues: $extendValues,
                    extensionRatio: extensionRatio,
                    customResponse: $customResponse,
                    customDamping: $customDamping,
                    customBlend: $customBlend
                )
                .accentColor(.orange)
            }
        }
        .padding(.top, 2)
        .padding(.horizontal, 25)
    }
}

struct SpringAnimationControlPanel_Previews: PreviewProvider {
    static let animationTypes = [
        SpringAnimationControlPanel.AnimationType(id: 0, name: "Scale"),
        SpringAnimationControlPanel.AnimationType(id: 1, name: "Move"),
        SpringAnimationControlPanel.AnimationType(id: 2, name: "Drag")
    ]

    static var previews: some View {
        SpringAnimationControlPanel(
            response: .constant(0.8),
            damping: .constant(0.4),
            blend: .constant(0.4),
            selectedAnimationType: .constant(0),
            animationTypes: animationTypes
        )
    }
}
