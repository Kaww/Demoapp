import SwiftUI
import BottomSheet

@available(iOS 15, *)
struct BottomSheetView: View {

    @State private var show = false
    @State private var shouldScrollExpandSheet = true
    @State private var largestUndimmedDetent: BottomSheet.LargestUndimmedDetent? = .none
    @State private var showGrabber = false
    @State private var showsInCompactHeight = false
    @State private var showNavigationBar = true
    @State private var dismissable = true

    // Detents
    @State private var bottomSheetDetents: [BottomSheet.Detent] = [.medium, .large]
    @State private var selectedBottomSheetDetents: [BottomSheet.Detent] = [.medium]

    @State private var useCustomCornerRadius = false
    private let cornerRadiusMinValue: CGFloat = .zero
    private let cornerRadiusMaxValue: CGFloat = 80
    @State private var cornerRadius: CGFloat = 0

    var body: some View {
        List {
            detentsSection
            largestUndimmedDetentSection
            scrollSection
            compactHeightConfigSection
            showNavigationBarSection
            dismissableSection
            grabberSection
            customRadiusSection
        }
        .navigationTitle(Text("Bottom sheet"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: { show.toggle() }) {
                    Text("Show!")
                }
            }
        }
        .tint(.blue)
        .bottomSheet(
            isPresented: $show,
            detents: selectedBottomSheetDetents,
            shouldScrollExpandSheet: shouldScrollExpandSheet,
            largestUndimmedDetent: largestUndimmedDetent,
            showGrabber: showGrabber,
            cornerRadius: useCustomCornerRadius ? cornerRadius : nil,
            showsInCompactHeight: showsInCompactHeight,
            showNavigationBar: showNavigationBar,
            dismissable: dismissable
        ) {
            sheetContentView
        }
        .onDisappear {
            show = false
        }
    }

    // MARK: Sheet Content

    private var sheetContentView: some View {
        List {
            Section {
                Button(action: { BottomSheet.dismiss() }) {
                    Label("Dismiss", systemImage: "multiply")
                        .foregroundColor(.red)
                }

                ForEach(1..<31, id: \.self) { id in
                    Text("Item \(id)")
                }
            } header: {
                Text("Default sheet with scrolling")
            }
        }
        .navigationTitle(Text("Bottom sheet content"))
    }

    // MARK: Detents

    private var detentsSection: some View {
        Section {
            NavigationLink("Select detents") {
                List {
                    BottomSheetDetentsSelect(
                        values: $bottomSheetDetents,
                        selection: $selectedBottomSheetDetents
                    )
                }
            }
        } header: {
            Text("Detents")
        } footer: {
            Text(detentsFooterText)
        }
    }

    private var detentsFooterText: String {
        var text = "Defines the heights where the sheet can rest.\n"
        for detent in selectedBottomSheetDetents {
            text.append("- " + detent.description)
            if detent != selectedBottomSheetDetents.last {
                text.append("\n")
            }
        }
        return text
    }

    private var largestUndimmedDetentSection: some View {
        Section {
            Picker("Detents", selection: $largestUndimmedDetent) {
                Text("None")
                    .tag(.none as BottomSheet.LargestUndimmedDetent?)

                ForEach(BottomSheet.LargestUndimmedDetent.allCases) { detent in
                    Text(detent.description)
                        .tag(detent as BottomSheet.LargestUndimmedDetent?)
                }
            }
            .pickerStyle(.menu)
        } header: {
            Text("Interact with content underneath")
        } footer: {
            Text("+ details")
        }
    }

    // MARK: Scroll

    private var scrollSection: some View {
        Section {
            Toggle(isOn: $shouldScrollExpandSheet) {
                Text("Should scroll expand sheet")
            }
        } header: {
            Text("Scroll")
        } footer: {
            Text("+ details")
        }
    }

    // MARK: Compact Height

    private var compactHeightConfigSection: some View {
        Section {
            Toggle(isOn: $showsInCompactHeight) {
                Text("Attach to bottom")
            }
        } header: {
            Text("Compact height")
        } footer: {
            Text("Determines whether the sheet attaches to the bottom edge of the screen in a compact-height size class.")
        }
    }

    // MARK: Dismiss

    private var dismissableSection: some View {
        Section {
            Toggle(isOn: $dismissable) {
                Text("Dismissable")
            }
        } header: {
            Text("Dismiss")
        } footer: {}
    }

    // MARK: Grabber

    private var grabberSection: some View {
        Section {
            Toggle(isOn: $showGrabber) {
                Text("Show grabber")
            }
        } header: {
            Text("Grabber")
        } footer: {
            Text("+ details")
        }
    }

    // MARK: Corner Radius

    private var customRadiusSection: some View {
        Section {
            Toggle(isOn: $useCustomCornerRadius) {
                Text("Use custom corner radius")
            }
            Slider(
                value: $cornerRadius,
                in: cornerRadiusMinValue...cornerRadiusMaxValue,
                step: 1,
                label: { Text("\(cornerRadius.rounded())") },
                minimumValueLabel: { Text("") },
                maximumValueLabel: { Text("\(Int(cornerRadius))") }
            )
            .disabled(!useCustomCornerRadius)
            .tint(useCustomCornerRadius ? .blue : .gray)
        } header: {
            Text("Corner radius")
        } footer: {
            Text("+ details")
        }
    }

    // MARK: Navigation Bar

    private var showNavigationBarSection: some View {
        Section {
            Toggle(isOn: $showNavigationBar) {
                Text("Show NavigationBar")
            }
        } header: {
            Text("Navigation bar")
        } footer: {
            Text("Defines if the NavigationBar is visible or hidden in the sheet content view.")
        }
    }
}

struct BottomSheetView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            if #available(iOS 15, *) {
                BottomSheetView()
            } else {
                BottomSheetUnavailableView()
            }
        }
    }
}
