import SwiftUI
import BottomSheet

@available(iOS 15, *)
struct BottomSheetDetentsSelect: View {
    @State private var showCustomValueView = false

    @Binding var values: [BottomSheet.Detent]
    @Binding var selection: [BottomSheet.Detent]

    var body: some View {
        Section("Detents") {
            ForEach(values) { value in
                Button {
                    if selection.contains(value) {
                        selection.removeAll(where: { $0 == value })
                    } else {
                        selection.append(value)
                    }
                } label: {
                    HStack {
                        Text(value.description)

                        Spacer()

                        if selection.contains(value) {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .deleteDisabled(isDeleteDisabled(for: value))
            }
            .onDelete(perform: delete)

            Button {
                showCustomValueView = true
            } label: {
                Label("Add custom", systemImage: "plus.circle.fill")
            }
            .bottomSheet(
                isPresented: $showCustomValueView,
                detents: [BottomSheet.Detent.medium],
                dismissable: false
            ) {
                BottomSheetDetentsSelectCustomValuePicker {
                    values.append($0)
                    selection.append($0)
                }
            }
        }

        if !selection.isEmpty {
            Section("Selection and order") {
                ForEach(selection) { value in
                    HStack {
                        Text(value.description)
                        Spacer()
                        if selection.contains(value) {
                            Image(systemName: "line.3.horizontal")
                        }
                    }
                }
                .onMove(perform: move)
            }
            .environment(\.editMode, .constant(EditMode.active))
        }
    }

    private func isDeleteDisabled(for item: BottomSheet.Detent) -> Bool {
        item == .medium || item == .large
    }

    func move(from source: IndexSet, to destination: Int) {
        selection.move(fromOffsets: source, toOffset: destination)
    }

    func delete(from source: IndexSet) {
        let items = source.map { values[$0] }
        values.remove(atOffsets: source)
        selection.removeAll(where: items.contains(_:))
    }
}

@available(iOS 15, *)
private struct BottomSheetDetentsSelectCustomValuePicker: View {
    private enum ValueType { case ratio, fixed }

    @State private var value: String = ""
    @State private var selectedValueType: ValueType = .ratio

    var onSubmit: (BottomSheet.Detent) -> Void

    var body: some View {
        List {
            Section {
                Picker("Type of value", selection: $selectedValueType) {
                    Text("Size ratio").tag(ValueType.ratio)
                    Text("Fixed height").tag(ValueType.fixed)
                }
                .pickerStyle(.segmented)

                TextField("werwer", text: $value)
                    .textFieldStyle(.plain)
                    .keyboardType(.decimalPad)
                    .overlay {
                        HStack {
                            if selectedValueType == .ratio {
                                Text("x")
                                    .offset(x: -10)
                            }
                            Spacer()
                        }
                    }

                Button {
                    submitValue()
                } label: {
                    Text("Add value")
                        .frame(maxWidth: .infinity)
                        .disabled(!isFormValid)
                }
            } footer: {
                switch selectedValueType {
                case .ratio:
                    Text("A ratio of the height within the safe area of the sheet")

                case .fixed:
                    Text("A fixed a height within the safe area of the sheet")
                }
            }

        }
        .navigationTitle("Custom value")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    BottomSheet.dismiss()
                } label: {
                    Text("Cancel")
                }
            }
        }
    }

    private var isFormValid: Bool {
        switch selectedValueType {
        case .ratio:
            return Double(value.replacingOccurrences(of: ",", with: ".")) != nil

        case .fixed:
            return Int(value) != nil
        }
    }

    private func submitValue() {
        switch selectedValueType {
        case .ratio:
            submitRatio(value: value)

        case .fixed:
            submitFixed(value: value)
        }
    }

    private func submitRatio(value: String) {
        guard let doubleValue = Double(value.replacingOccurrences(of: ",", with: ".")) else { return }
        onSubmit(.ratio(doubleValue))
        BottomSheet.dismiss()
    }

    private func submitFixed(value: String) {
        guard let intValue = Int(value) else { return }
        onSubmit(.fixed(intValue))
        BottomSheet.dismiss()
    }
}

@available(iOS 15, *)
struct BottomSheetDetentsSelectPreview: View {
    @State private var values: [BottomSheet.Detent] = [
        .medium,
        .large,
        .fixed(150),
        .ratio(0.5)
    ]

    @State private var selectedValues: [BottomSheet.Detent] = [
        .medium
    ]

    var body: some View {
        BottomSheetDetentsSelect(
            values: $values,
            selection: $selectedValues
        )
    }
}

@available(iOS 15, *)
struct BottomSheetDetentsSelect_Previews: PreviewProvider {
    static var previews: some View {
        BottomSheetDetentsSelectPreview()

        NavigationView {
            BottomSheetDetentsSelectCustomValuePicker { _ in }
        }
    }
}
