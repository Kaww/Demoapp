import SwiftUI

struct SFSymbolsView: View {
    var body: some View {
        List {
            allSymbols
            symbolsByCategory
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("SF Symbols")
    }

    private var allSymbols: some View {
        NavigationLink {
            SFSymbolsCategoryView(
                category: .all,
                symbols: []
            )
        } label: {
            Label {
                Text(SFSymbolCategory.all.rawValue)
            } icon: {
                Image(systemName: SFSymbolCategory.all.symbolName)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.green)
            }
        }
    }

    private var symbolsByCategory: some View {
        Section {
            ForEach(SFSymbolCategory.allCases) { category in
                if category != .all {
                    NavigationLink {
                        SFSymbolsCategoryView(
                            category: category,
                            symbols: SFSymbol.symbols[category] ?? []
                        )
                    } label: {
                        Label {
                            Text(category.rawValue)
                        } icon: {
                            Image(systemName: category.symbolName)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.green)
                        }
                    }
                }
            }
        } header: {
            Text("Categories")
        } footer: {
            VStack {
                Text("Using SFSymbols Version 4.0 (78)")
                Text("SF Font Version 18.0d11e1")
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 15)
        }
    }
}

struct SFSymbolsCategoryView: View {
    let category: SFSymbolCategory
    let symbols: [SFSymbol]

    let columns = [
        GridItem(.adaptive(minimum: 70))
    ]

    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: columns,
                alignment: .center,
                spacing: 20,
                pinnedViews: category == .all ? .sectionHeaders : []
            ) {
                if category == .all {
                    allSymbols
                } else {
                    categorySymbols
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                HStack {
                    Image(systemName: category.symbolName)
                        .font(.system(size: 14, weight: .bold))

                    Text(category.rawValue)
                        .font(.system(size: 18, weight: .medium))
                }
            }
        }
    }

    private var allSymbols: some View {
        ForEach(SFSymbolCategory.allCases) { category in
            if category != .all {
                Section {
                    ForEach(SFSymbol.symbols[category] ?? []) { symbol in
                        symbolView(for: symbol)
                    }
                } header: {
                    categorySectionHeader(for: category)
                }
            }
        }
    }

    @ViewBuilder
    private func categorySectionHeader(for category: SFSymbolCategory) -> some View {
        HStack {
            Image(systemName: category.symbolName)
                .font(.system(size: 14, weight: .medium))
            Text(category.rawValue)
                .font(.system(size: 14, weight: .medium))
        }
        .foregroundColor(.white)
        .padding(.horizontal, 16)
        .padding(.vertical, 5)
        .background(
            Capsule(style: .continuous)
                .foregroundColor(.green)
                .shadow(color: .green.opacity(0.5), radius: 15)
        )
        .padding(.top, 10)
    }

    private var categorySymbols: some View {
        ForEach(symbols) { symbol in
            symbolView(for: symbol)
        }
    }

    private func symbolView(for symbol: SFSymbol) -> some View {
        VStack(spacing: 12) {
            Image(systemName: symbol.name)
                .font(.system(size: 30))

            Text(symbol.name)
                .font(.system(size: 10))
        }
    }
}

struct SFSymbolsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SFSymbolsView()
        }

        NavigationView {
            SFSymbolsCategoryView(
                category: .shapes,
                symbols: SFSymbol.symbols[.shapes] ?? []
            )
        }
    }
}
