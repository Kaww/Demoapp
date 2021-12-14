import SwiftUI

struct SheetViews: View {

    var body: some View {
        List {
            DefaultSheetViews()
            FullScreenCoverViews()

            if #available(iOS 15, *) {
                NavigationLink(destination: BottomSheetViews()) {
                    Label("Bottom sheets", systemImage: "doc.text.image")
                }
            } else {
                BottomSheetUnavailableView()
            }
        }
        .navigationTitle(Text("Sheets"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SheetsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SheetViews()
        }
    }
}
