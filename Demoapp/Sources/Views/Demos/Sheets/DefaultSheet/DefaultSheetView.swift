import SwiftUI

struct DefaultSheetView: View {

    @State private var showDefaultSheet = false
    @State private var showDefaultSheetNavigation = false
    @State private var showDefaultSheetScrolling = false
    @State private var showDefaultSheetNavigationScrolling = false
    @State private var showStackedSheets = false
    @State private var showSecondStackedSheets = false

    var body: some View {
        List {
            Button(action: { showDefaultSheet.toggle() }) {
                Label("Default sheet", systemImage: "doc.fill")
            }
            .sheet(isPresented: $showDefaultSheet) {
                defaultSheetView()
            }

            Button(action: { showDefaultSheetNavigation.toggle() }) {
                Label("With navigation", systemImage: "doc.fill")
            }
            .sheet(isPresented: $showDefaultSheetNavigation) {
                defaultSheetNavigationView()
            }

            Button(action: { showDefaultSheetScrolling.toggle() }) {
                Label("With scrolling", systemImage: "arrow.up.doc.fill")
            }
            .sheet(isPresented: $showDefaultSheetScrolling) {
                defaultSheetScrollingView()
            }

            Button(action: { showDefaultSheetNavigationScrolling.toggle() }) {
                Label("With navigation + scrolling", systemImage: "arrow.up.doc.fill")
            }
            .sheet(isPresented: $showDefaultSheetNavigationScrolling) {
                defaultSheetNavigationAndScrollingView()
            }

            Button(action: { showStackedSheets.toggle() }) {
                Label("Stacked sheets", systemImage: "doc.on.doc.fill")
            }
            .sheet(isPresented: $showStackedSheets) {
                stackedSheetView()
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
