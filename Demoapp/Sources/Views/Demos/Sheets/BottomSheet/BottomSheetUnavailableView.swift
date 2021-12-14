import SwiftUI

struct BottomSheetUnavailableView: View {
    var body: some View {
        Section {
            Text("Only available with iOS 15, please update your device...")
        }
    }
}

struct BottomSheetUnavailable_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetUnavailableView()
    }
}
