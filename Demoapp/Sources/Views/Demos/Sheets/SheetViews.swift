import SwiftUI

struct SheetViews: View {

    var body: some View {
        List {
            DefaultSheetViews()
            FullScreenCoverViews()

            if #available(iOS 15, *) {
                BottomSheetViews()
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
