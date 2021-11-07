import SwiftUI

struct InfosView: View {
    var body: some View {
        NavigationView {
            Text("Infos")
                .navigationTitle("Infos")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct InfosView_Previews: PreviewProvider {
    static var previews: some View {
        InfosView()
    }
}
