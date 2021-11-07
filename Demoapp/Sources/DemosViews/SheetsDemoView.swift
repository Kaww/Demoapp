import SwiftUI

struct SheetsDemoView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("add sheets demos")
                    .padding()
            }
        }
        .navigationTitle("Sheets")
    }
}

struct SheetsDemoView_Previews: PreviewProvider {
    static var previews: some View {
        SheetsDemoView()
    }
}
