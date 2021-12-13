import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section {
                    Button(action: {}) {
                        Label("Contact the team", systemImage: "envelope.fill")
                    }

                    Button(action: {}) {
                        Label("Request a feature", systemImage: "star.fill")
                            .foregroundColor(.purple)
                    }


                    Link(destination: URL(string: "https://github.com/Kaww/Demoapp")!) {
                        Label("Contribute", systemImage: "chevron.left.forwardslash.chevron.right")
                            .foregroundColor(.orange)
                    }

                } header: {
                    Text("Contact")
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
