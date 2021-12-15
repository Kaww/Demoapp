import SwiftUI

@main
struct DemoappApp: App {
    var body: some Scene {
        WindowGroup {
            let haptics = Haptics()

            AppScreen()
                .environment(\.haptics, haptics)
        }
    }
}
