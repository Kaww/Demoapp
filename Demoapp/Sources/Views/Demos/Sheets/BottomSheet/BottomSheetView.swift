import SwiftUI
import BottomSheet

@available(iOS 15, *)
struct BottomSheetView: View {

    @State private var show = false
    @State private var selectedDetent: BottomSheet.Detents = .medium
    @State private var shouldScrollExpandSheet = true
    @State private var largestUndimmedDetent: BottomSheet.LargestUndimmedDetent? = .none
    @State private var showGrabber = false

    @State private var useCustomCornerRadius = false
    private let cornerRadiusMinValue: CGFloat = .zero
    private let cornerRadiusMaxValue: CGFloat = 80
    @State private var cornerRadius: CGFloat = 0

    var body: some View {
        List {
            detentsSection
            largestUndimmedDetentSection
            scrollSection
            grabberSection
            customRadiusSection

            Button(action: { show.toggle() }) {
                Text("Show!")
                    .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle(Text("Bottom sheet"))
        .navigationBarTitleDisplayMode(.inline)
        .tint(.blue)
        .bottomSheet(
            isPresented: $show,
            detents: selectedDetent,
            shouldScrollExpandSheet: shouldScrollExpandSheet,
            largestUndimmedDetent: largestUndimmedDetent,
            showGrabber: showGrabber,
            cornerRadius: useCustomCornerRadius ? cornerRadius : nil
        ) {
            contentView
        }
    }

    private var contentView: some View {
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

    // MARK: Sections

    private var detentsSection: some View {
        Section {
            Picker("Detents", selection: $selectedDetent) {
                ForEach(BottomSheet.Detents.allCases) { detent in
                    Text(detent.description)
                        .tag(detent)
                }
            }
            .pickerStyle(.menu)
        } header: {
            Text("Detents")
        } footer: {
            Text("+ details")
        }
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
}

struct BottomSheet_Previews: PreviewProvider {
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
