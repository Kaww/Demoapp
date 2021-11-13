import SwiftUI

struct SpringAnimationControlPanelInfos: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Response")
                        .font(.title3)

                    Text("→ The stiffness of the spring, defined as an approximate duration in seconds.\nA value of zero requests an infinitely-stiff spring, suitable for driving interactive animations.")
                        .padding(.bottom, 12)

                    Text("Damping fraction")
                        .font(.title3)
                        .font(.headline)

                    Text("→ The amount of drag applied to the value being animated, as a fraction of an estimate of amount needed to produce critical damping.")

                    Text("→ Between the overdamped and underdamped cases, there exists a certain level of damping at which the system will just fail to overshoot and will not make a single oscillation. This case is called critical damping.")

                    VStack {
                        Image("damping")
                            .resizable()
                        .aspectRatio(contentMode: .fit)

                        Text("1.0 correspond to the critical damping. Under that, the spring is overdamped which mean that it will bounce.")
                            .multilineTextAlignment(.center)
                            .font(.subheadline)
                            .foregroundColor(.gray40)
                    }
                    .padding(.bottom, 12)

                    Text("Blend duration")
                        .font(.title3)
                        .font(.headline)

                    Text("→ The duration in seconds over which to interpolate changes to the response value of the spring. That corresponds to the transition of the physics of the original spring to the new one.")
                        .padding(.bottom, 12)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: dismiss) {
                        Label("Dismiss", systemImage: "multiply")
                            .font(.system(size: 18, weight: .medium))
                    }
                }
            }
        }
    }

    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct SpringAnimationControlPanelInfos_Previews: PreviewProvider {
    static var previews: some View {
        SpringAnimationControlPanelInfos()
            .preferredColorScheme(.dark)
    }
}
