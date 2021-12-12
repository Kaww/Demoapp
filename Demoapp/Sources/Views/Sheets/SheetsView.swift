import SwiftUI

struct SheetsView: View {
    
    var body: some View {
        List {
            DefaultSheets()
            FullScreenCovers()

            // iOS 15 bottom sheet
            // https://sarunw.com/posts/bottom-sheet-in-ios-15-with-uisheetpresentationcontroller/
        }
        .navigationTitle(Text("Sheets"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SheetsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SheetsView()
        }
    }
}
