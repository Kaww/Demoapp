import SwiftUI

struct SpringAnimationsDemoView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("add spring demos")
                    .padding()
            }
        }
        .navigationTitle("Spring animations")
    }
}

struct SpringAnimationsDemoView_Previews: PreviewProvider {
    static var previews: some View {
        SpringAnimationsDemoView()
    }
}
