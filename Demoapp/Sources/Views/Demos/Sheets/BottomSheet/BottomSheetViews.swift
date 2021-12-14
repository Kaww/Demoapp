import SwiftUI
import BottomSheet

@available(iOS 15, *)
struct BottomSheetViews: View {

    @State private var show = false

    var body: some View {
        VStack {
            Text("Hello, World!")

            Button(action: { show.toggle() }) {
                Text("Show!")
            }
            .bottomSheet(
                isPresented: $show,
                detents: .largeAndMedium,
                shouldScrollExpandSheet: true,
                largestUndimmedDetent: .medium,
                showGrabber: true,
                cornerRadius: 20
            ) {
                Text("Yoho")
            }
        }
    }

    private var contentView: some View {
        List {
            Section {
                ForEach(1..<31, id: \.self) { id in
                    Text("Item \(id)")
                }
            } header: {
                Text("Default sheet with scrolling")
            }
        }
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            BottomSheetViews()
        }
    }
}
