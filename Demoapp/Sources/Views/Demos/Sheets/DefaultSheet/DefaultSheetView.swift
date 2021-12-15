import SwiftUI

struct DefaultSheetView: View {

    @State private var showDefaultSheet = false
    @State private var showDefaultSheetNavigation = false
    @State private var showDefaultSheetScrolling = false
    @State private var showDefaultSheetNavigationScrolling = false
    @State private var showStackedSheets = false
    @State private var showSecondStackedSheets = false
    @State private var showDismissWithButtonSheet = false
    @State private var showPreventDismissSheet = false

    var body: some View {
        List {

            // MARK: Default

            Section {
                Button(action: { showDefaultSheet.toggle() }) {
                    Label("Default sheet", systemImage: "doc.fill")
                }
                .sheet(isPresented: $showDefaultSheet) {
                    defaultSheetView()
                }
            } footer: {
                Text("Use a sheet to present new views over existing ones, while still allowing users to drag down to dismiss the new view when they are ready.")
            }

            // MARK: Navigation

            Section {
                Button(action: { showDefaultSheetNavigation.toggle() }) {
                    Label("With navigation", systemImage: "doc.fill")
                }
                .sheet(isPresented: $showDefaultSheetNavigation) {
                    defaultSheetNavigationView()
                }
            } footer: {
                Text("Navigation is possible inside sheets.")
            }

            // MARK: Scroll

            Section {
                Button(action: { showDefaultSheetScrolling.toggle() }) {
                    Label("With scrolling", systemImage: "arrow.up.doc.fill")
                }
                .sheet(isPresented: $showDefaultSheetScrolling) {
                    defaultSheetScrollingView()
                }

                Button(action: { showDefaultSheetNavigationScrolling.toggle() }) {
                    Label("Scrolling & navigation", systemImage: "arrow.up.doc.fill")
                }
                .sheet(isPresented: $showDefaultSheetNavigationScrolling) {
                    defaultSheetNavigationAndScrollingView()
                }
            } footer: {
                Text("Scrolling is possible inside sheets. If scroll down is possible, the view will scroll, if not, the sheet will be dragged down.")
            }

            // MARK: Stack

            Section {
                Button(action: { showStackedSheets.toggle() }) {
                    Label("Stacked sheets", systemImage: "doc.on.doc.fill")
                }
                .sheet(isPresented: $showStackedSheets) {
                    stackedSheetView()
                }
            } footer: {
                Text("Sheets can easily be stacked.")
            }

            // MARK: Dismiss

            Section {
                Button(action: { showDismissWithButtonSheet.toggle() }) {
                    Label("Dismiss with a button", systemImage: "lock.doc.fill")
                }
                .sheet(isPresented: $showDismissWithButtonSheet) {
                    DismissWithButtonSheetView()
                }

                Button(action: { showPreventDismissSheet.toggle() }) {
                    Label("Undismissable sheet", systemImage: "lock.doc.fill")
                }
                .sheet(isPresented: $showPreventDismissSheet) {
                    UndismissableSheetView()
                }
            } header: {
                Text("Dismiss")
            } footer: {
                Text("It's possible to force-dismiss a sheet or to prevent a it to be dismissed.")
            }

            Section {
            } footer: {
                Text("More infos....")
            }
        }
        .navigationTitle(Text("Default sheet"))
        .navigationBarTitleDisplayMode(.inline)
    }

    private func defaultSheetView() -> some View {
        Text("Default sheet")
    }

    private func defaultSheetNavigationView() -> some View {
        NavigationView {
            NavigationLink("Default sheet...") {
                Text("... and navigation")
            }
            .navigationTitle("Navigation")
        }
    }

    private func defaultSheetScrollingView() -> some View {
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

    private func defaultSheetNavigationAndScrollingView() -> some View {
        NavigationView {
            List {
                Section {
                    ForEach(1..<31, id: \.self) { id in
                        NavigationLink("Item \(id)") {
                            Text("Item \(id)")
                        }
                    }
                } header: {
                    Text("... & scrolling")
                }
            }
            .navigationTitle(Text("Navigation..."))
        }
    }

    private func stackedSheetView() -> some View {
        Button(action: { showSecondStackedSheets.toggle() }) {
            Text("Show second sheet")
        }
        .sheet(isPresented: $showSecondStackedSheets) {
            Text("Stacked sheet")
        }
    }
}

struct DefaultSheets_Previews: PreviewProvider {
    static var previews: some View {
        List {
            DefaultSheetView()
        }
    }
}

// MARK: - Private Subviews

private struct DismissWithButtonSheetView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            Text("I'm a sheet! 🤩")

            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Text("Dismiss")
            }
        }
    }
}
