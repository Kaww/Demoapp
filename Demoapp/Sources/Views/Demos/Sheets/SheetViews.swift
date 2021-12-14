import SwiftUI

struct SheetViews: View {

    var body: some View {
        List {
            DefaultSheetViews()
            FullScreenCoverViews()

            if #available(iOS 15, *) {
                NavigationLink(destination: BottomSheetViews()) {
                    Label("Bottom sheets", systemImage: "rectangle.portrait.bottomhalf.inset.filled")
                }
            } else {
                BottomSheetUnavailableView()
            }
        }
        .navigationTitle(Text("Sheets"))
        .navigationBarTitleDisplayMode(.inline)
        .accentColor(.blue)
    }
}

struct SheetsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SheetViews()
        }
    }
}
