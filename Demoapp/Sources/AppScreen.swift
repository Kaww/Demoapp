import SwiftUI

struct AppScreen: View {
    var body: some View {
        NavigationView {
            DemosListView()
        }
    }
}

struct DemosListView: View {

    // MARK: - Private properties

    @State private var showInfosView = false
    @State private var showSettingsView = false

    // MARK: - Body

    var body: some View {
        List {
            sheetsSection
            animationsSection
            hapticsSection
            resourcesSection
            willBeAddedSoonLabel
        }
        .navigationTitle(Text("Demoapp (:"))
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(action: { showInfosView = true }) {
                    Label("Infos", systemImage: "info.circle.fill")
                }
            }

            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: { showSettingsView = true }) {
                    Label("Settings", systemImage: "gearshape.fill")
                }
            }
        }
        .sheet(isPresented: $showInfosView) { InfosView() }
        .sheet(isPresented: $showSettingsView) { SettingsView() }
    }

    // MARK: - Subbiews

    private var sheetsSection: some View {
        Section {
            NavigationLink(destination: DefaultSheetView()) {
                Label("Default sheet", systemImage: "doc.text.fill")
            }

            NavigationLink(destination: FullScreenCoverViews()) {
                Label("Full screen cover", systemImage: "doc.plaintext.fill")
            }

            NavigationLink {
                if #available(iOS 15, *) {
                    BottomSheetView()
                } else {
                    BottomSheetUnavailableView()
                }
            } label: {
                Label("Bottom sheet", systemImage: "rectangle.portrait.bottomhalf.inset.filled")
            }
        } header: {
            Text("Sheets, navigation, ...")
        }
    }

    private var animationsSection: some View {
        Section {
            NavigationLink(destination: SpringAnimationsView()) {
                Label {
                    Text("Spring")
                } icon: {
                    Image(systemName: "tornado")
                        .foregroundColor(.orange)
                }
            }
        } header: {
            Text("Animations")
        }
    }

    private var hapticsSection: some View {
        Section {
            NavigationLink(destination: HapticsView()) {
                Label {
                    Text("Haptics and vibrations")
                } icon: {
                    Image(systemName: "hand.tap.fill")
                        .foregroundColor(.purple)
                }
            }
        } header: {
            Text("Sensors")
        }
    }

    private var resourcesSection: some View {
        Section {
            NavigationLink(destination: SFSymbolsView()) {
                Label {
                    Text("SF Symbols")
                } icon: {
                    Image(systemName: "photo.stack")
                        .foregroundColor(.green)
                }
            }
        } header: {
            Text("Resources")
        }
    }

    private var willBeAddedSoonLabel: some View {
        Section {
        } footer: {
            Text("Will be added soon:\n")
            + Text(" → Basic animations\n")
            + Text(" → Matched geometry effects\n")
            + Text(" → Accessiblity\n")
            + Text(" → Navigation bars\n")
            + Text(" → Native color picker\n")
            + Text(" → Native date picker\n")
        }
    }
}

struct AppScreen_Previews: PreviewProvider {
    static var previews: some View {
        AppScreen()
    }
}
