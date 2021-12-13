import SwiftUI

// Bottom sheet source:
// https://sarunw.com/posts/bottom-sheet-in-ios-15-with-uisheetpresentationcontroller/

@available(iOS 15, *)
struct BottomSheetViews: View {
    var body: some View {
        VStack {
            Text("Hello, World!")

            Button(action: presentModal) {
                Text("Show!")
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

    @available(iOS 15, *)
    private func presentModal() {
        let detailViewController = UIHostingController(rootView: contentView)
        let nav = UINavigationController(rootViewController: detailViewController)

        nav.modalPresentationStyle = .pageSheet

        if let sheet = nav.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }

        UIApplication.shared.windows.first?.rootViewController?.present(nav, animated: true, completion: nil)
    }
}

struct BottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        if #available(iOS 15, *) {
            BottomSheetViews()
        }
    }
}
