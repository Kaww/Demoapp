import SwiftUI

struct SpringAnimationControlPanel: View {

    struct AnimationType: Identifiable {
        let id: Int
        let name: String
    }

    // MARK: - Parameters

    @Binding var response: Double
    @Binding var damping: Double
    @Binding var blend: Double
    @Binding var selectedAnimationType: AnimationType.ID
    let animationTypes: [AnimationType]

    // MARK: - Private properties

    // Response
    private let minResponse: Double = 0
    private let maxResponse: Double = 2.5
    private let responseStep: Double = 0.1
    @State private var customResponse: Double? = nil

    // Damping
    private let minDamping: Double = 0
    private let maxDamping: Double = 2
    private let dampingStep: Double = 0.1
    @State private var customDamping: Double? = nil

    // Blend
    private let minBlend: Double = 0
    private let maxBlend: Double = 2.5
    private let blendStep: Double = 0.1
    @State private var customBlend: Double? = nil

    @State private var extendValues = false
    private let extensionRatio: Double = 4.0

    @State private var showSettingsView = false
    @State private var showShareView = false
    @State private var showInfosView = false

    // MARK: - Body

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

    // MARK: - Private methods

    private func extendIfNeeded(_ value: Double) -> Double {
        extendValues ? value * extensionRatio : value
    }

    private func showShareSheet() {
        let codeSample = """
Animation.spring(
    response: \(String(format: "%.2f", response)),
    dampingFraction: \(String(format: "%.2f", damping)),
    blendDuration: \(String(format: "%.2f", blend))
)
"""
        let activityViewController = UIActivityViewController(activityItems: [codeSample], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }

    private func reset() {
        response = 0.5
        customResponse = nil
        damping = 0.5
        customDamping = nil
        blend = 0
        customBlend = nil
        extendValues = false
    }
    
    // MARK: - Subviews

    private var animationTypeControl: some View {
        Picker("Select the animation type", selection: $selectedAnimationType) {
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
                maximumValueLabel: { Text("\(response, specifier: "%.2f")") },
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
                maximumValueLabel: { Text("\(damping, specifier: "%.2f")") },
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
                maximumValueLabel: { Text("\(blend, specifier: "%.2f")") },
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
                SpringAnimationControlPanelInfos()
                    .accentColor(.orange)
            }

            Spacer()

            Button(action: showShareSheet) {
                Image(systemName: "square.and.arrow.up")
                    .font(.system(size: 22, weight: .medium))
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
                    customBlend: $customBlend,
                    reset: reset
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
