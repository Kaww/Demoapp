import SwiftUI
import CoreHaptics

struct HapticsKey: EnvironmentKey {
    static var defaultValue = Haptics()
}

extension EnvironmentValues {
    var haptics: Haptics {
        get { self[HapticsKey.self] }
        set { self[HapticsKey.self] = newValue }
    }
}

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
            self.generator.prepare()
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
            self.generator.prepare()
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
            self.generator.prepare()
        }

        func impactOccurred(intensity: CGFloat? = nil) {
            if let intensity = intensity {
                generator.impactOccurred(intensity: intensity)
            } else {
                generator.impactOccurred()
            }
        }
    }

    // MARK: Custom Engine

    struct Engine {
        // Do some sketchy shit...
        // https://www.hackingwithswift.com/example-code/core-haptics/how-to-play-custom-vibrations-using-core-haptics
    }
}
