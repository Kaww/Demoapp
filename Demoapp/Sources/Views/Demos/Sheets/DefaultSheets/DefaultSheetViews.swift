import SwiftUI

struct DefaultSheetViews: View {

    @State private var showDefaultSheet = false
    @State private var showDefaultSheetNavigation = false
    @State private var showDefaultSheetScrolling = false
    @State private var showDefaultSheetNavigationScrolling = false
    @State private var showStackedSheets = false
    @State private var showSecondStackedSheets = false

    var body: some View {
        Section {
            Button(action: { showDefaultSheet.toggle() }) {
                Label("Default sheet", systemImage: "doc.plaintext.fill")
            }
            .sheet(isPresented: $showDefaultSheet) {
                defaultSheetView()
            }

            Button(action: { showDefaultSheetNavigation.toggle() }) {
                Label("With navigation", systemImage: "doc.plaintext.fill")
            }
            .sheet(isPresented: $showDefaultSheetNavigation) {
                defaultSheetNavigationView()
            }

            Button(action: { showDefaultSheetScrolling.toggle() }) {
                Label("With scrolling", systemImage: "doc.plaintext.fill")
            }
            .sheet(isPresented: $showDefaultSheetScrolling) {
                defaultSheetScrollingView()
            }

            Button(action: { showDefaultSheetNavigationScrolling.toggle() }) {
                Label("With navigation + scrolling", systemImage: "doc.plaintext.fill")
            }
            .sheet(isPresented: $showDefaultSheetNavigationScrolling) {
                defaultSheetNavigationAndScrollingView()
            }

            Button(action: { showStackedSheets.toggle() }) {
                Label("Stacked sheets", systemImage: "doc.plaintext.fill")
            }
            .sheet(isPresented: $showStackedSheets) {
                stackedSheetView()
            }
        } header: {
            Text("Default sheet")
        }
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
            DefaultSheetViews()
        }
    }
}
