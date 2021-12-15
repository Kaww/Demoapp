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

            if #available(iOS 15, *) {
                NavigationLink(destination: BottomSheetView()) {
                    Label("Bottom sheet", systemImage: "rectangle.portrait.bottomhalf.inset.filled")
                }
            } else {
                BottomSheetUnavailableView()
            }
        } header: {
            Text("Sheets, navigation, ...")
        }
    }

    private var animationsSection: some View {
        Section {
            NavigationLink(destination: SpringAnimationsView()) {
                Label("Spring", systemImage: "tornado")
                    .accentColor(.orange)
            }
        } header: {
            Text("Animations")
        }
    }

    private var willBeAddedSoonLabel: some View {
        Section {
        } footer: {
            Text("Will be added soon...\n")
            + Text(" → Basic animations\n")
            + Text(" → Matched geometry effects\n")
            + Text(" → Haptics\n")
            + Text(" → Accessiblity\n")
            + Text(" → Navigation bars\n")
            + Text(" → Sliders, Toggles, ...\n")
            + Text(" → Color picker\n")
            + Text(" → Date picker\n")
            + Text(" → A page with some fun UI tricks...\n")
        }
    }
}

struct AppScreen_Previews: PreviewProvider {
    static var previews: some View {
        AppScreen()
    }
}
