import SwiftUI

struct UndismissableSheetView: View {
    @State private var termsAccepted = false

    var body: some View {
        if #available(iOS 15, *) {
            VStack(spacing: 20) {
                Text("Terms and conditions")
                    .font(.title)
                Text("Please accept the conditions !")
                Toggle("Accept", isOn: $termsAccepted)

                Spacer()
            }
            .padding(40)
            .interactiveDismissDisabled(!termsAccepted)
        } else {
            UndismissableSheetUnavailableView()
        }
    }
}

struct UndismissableSheetUnavailableView: View {
    var body: some View {
        Text("Only available with iOS 15, please update your device...")
    }
}

struct UndismissableSheet_Previews: PreviewProvider {
    static var previews: some View {
        UndismissableSheetView()
    }
}
