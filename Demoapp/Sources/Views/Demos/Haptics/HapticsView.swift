import SwiftUI

struct HapticsView: View {
    @Environment(\.haptics) var haptics

    @State private var impactIntensity: CGFloat = 0.5

    private let columns = [
        GridItem(.adaptive(minimum: 100, maximum: 150), spacing: 20)
    ]

    var body: some View {
        List {
            selectionSection
            notificationsSection
            impactsSection
            
        }
        .accentColor(.purple)
        .navigationTitle(Text("Haptics feedbacks"))
        .navigationBarTitleDisplayMode(.inline)
    }

    private var selectionSection: some View {
        Section {
            Button(action: { haptics.selection.selectionChanged() }) {
                Label("Selection", systemImage: "hand.tap.fill")
            }
        } header: {
            Text("Selection")
        } footer: {
            Text("Use selection feedback to communicate movement through a series of discrete values.")
        }
    }

    private var notificationsSection: some View {
        Section {
            Button(action: { haptics.notification.notify(.success) }) {
                Label("Success", systemImage: "checkmark.circle.fill")
                    .accentColor(.green)
            }

            Button(action: { haptics.notification.notify(.warning) }) {
                Label("Warning", systemImage: "exclamationmark.triangle.fill")
                    .accentColor(.orange)
            }

            Button(action: { haptics.notification.notify(.error) }) {
                Label("Error", systemImage: "multiply.square.fill")
                    .accentColor(.red)
            }
        } header: {
            Text("Notifications")
        } footer: {
            Text("Use notification feedback to communicate that a task or action has succeeded, failed, or produced a warning of some kind.")
        }
    }

    private var impactsSection: some View {
        Section {
            Button(action: { haptics.impact.impactOccurred() }) {
                Text("Default impact")
            }

            Button(action: { haptics.impact.impactOccurred(intensity: impactIntensity) }) {
                Text("Impact with intensity of \(String(format: "%.2f", impactIntensity))")
            }

            Slider(
                value: $impactIntensity,
                in: 0...1,
                step: 0.05
            )
        } header: {
            Text("Impacts")
        } footer: {
            Text("Use impact feedback to indicate that an impact has occurred. For example, you might trigger impact feedback when a user interface object collides with another object or snaps into place.")
        }
    }
}

struct HapticsView_Previews: PreviewProvider {
    static var previews: some View {
        HapticsView()
            .preferredColorScheme(.dark)
    }
}
