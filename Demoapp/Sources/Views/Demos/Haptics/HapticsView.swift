import SwiftUI

struct HapticsView: View {
    @Environment(\.haptics) var haptics

    var body: some View {
        VStack(spacing: 20) {
            Text("Selection")
                .onTapGesture {
                    haptics.selection.selectionChanged()
                }

            Text("Impact default")
                .onTapGesture {
                    haptics.impact.impactOccurred()
                }

            Text("Impact 0.5")
                .onTapGesture {
                    haptics.impact.impactOccurred(intensity: 1)
                }

            Text("Impact 1")
                .onTapGesture {
                    haptics.impact.impactOccurred(intensity: 1)
                }

            Text("Success")
                .onTapGesture {
                    haptics.notification.notify(.success)
                }

            Text("Warning")
                .onTapGesture {
                    haptics.notification.notify(.warning)
                }

            Text("Error")
                .onTapGesture {
                    haptics.notification.notify(.error)
                }
        }
    }
}

struct HapticsView_Previews: PreviewProvider {
    static var previews: some View {
        HapticsView()
    }
}
