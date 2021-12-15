import SwiftUI
import CoreHaptics

// MARK: Environment Keys
struct HapticsKey: EnvironmentKey {
    static var defaultValue = Haptics()
}

extension EnvironmentValues {
    var haptics: Haptics {
        get { self[HapticsKey.self] }
        set { self[HapticsKey.self] = newValue }
    }
}

// MARK: Haptics
struct Haptics {

    let notification: Notification
    let selection: Selection
    let impact: Impact
    let engine: Engine

    init() {
        notification = Notification(generator: UINotificationFeedbackGenerator())
        selection = Selection(generator: UISelectionFeedbackGenerator())
        impact = Impact(generator: UIImpactFeedbackGenerator())
        engine = Engine()
    }

    // MARK: Notification
    struct Notification {
        private let generator: UINotificationFeedbackGenerator

        init(generator: UINotificationFeedbackGenerator) {
            self.generator = generator
        }

        func notify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
            generator.notificationOccurred(feedbackType)
        }
    }

    // MARK: Selection
    struct Selection {
        private let generator: UISelectionFeedbackGenerator

        init(generator: UISelectionFeedbackGenerator) {
            self.generator = generator
        }

        func selectionChanged() {
            generator.selectionChanged()
        }
    }

    // MARK: Impact
    struct Impact {
        private let generator: UIImpactFeedbackGenerator

        init(generator: UIImpactFeedbackGenerator) {
            self.generator = generator
        }

        func impactOccurred(intensity: CGFloat? = nil) {
            if let intensity = intensity {
                generator.impactOccurred(intensity: intensity)
            } else {
                generator.impactOccurred()
            }
        }
    }

    // MARK: Engine
    struct Engine {
        // Do some sketchy shit.
    }
}
