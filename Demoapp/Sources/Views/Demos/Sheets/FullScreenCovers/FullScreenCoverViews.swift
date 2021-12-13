import SwiftUI

struct FullScreenCoverViews: View {

    @State private var showFSC = false

    var body: some View {
        Section {
            Button(action: { showFSC.toggle() }) {
                Label("Default sheet", systemImage: "doc.plaintext.fill")
            }
            .fullScreenCover(isPresented: $showFSC) {
                DefaultFSCView()
            }
        } header: {
            Text("Full screen covers")
        }
    }
}

struct FullScreenCovers_Previews: PreviewProvider {
    static var previews: some View {
        List {
            FullScreenCoverViews()
        }
    }
}

// MARK: - Private Subviews

private struct DefaultFSCView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("Full screen cover")

            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Text("Dismiss")
            }
        }
    }
}
