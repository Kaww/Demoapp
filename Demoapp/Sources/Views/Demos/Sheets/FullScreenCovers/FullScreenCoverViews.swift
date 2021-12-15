import SwiftUI

struct FullScreenCoverViews: View {

    @State private var showFSC = false

    var body: some View {
        List {
            Section {
                Button(action: { showFSC.toggle() }) {
                    Label("Show cover", systemImage: "doc.plaintext.fill")
                }
                .fullScreenCover(isPresented: $showFSC) {
                    DefaultFSCView()
                }
            } footer: {
                Text("→ Full screen covers shows up by covering all the visual space.\n→ As the user can't drag the view to dismiss it, you have to provide a dedicated action, like an \"X\" mark on the navigation bar.")
            }
        }
        .navigationTitle(Text("Full screen cover"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct FullScreenCovers_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FullScreenCoverViews()
        }
    }
}

// MARK: - Private Subviews

private struct DefaultFSCView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Text("Cover content")
            }
            .navigationTitle(Text("Cover title"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { presentationMode.wrappedValue.dismiss() }) {
                        Label("Dismiss", systemImage: "multiply")
                    }
                }
            }
        }
    }
}
