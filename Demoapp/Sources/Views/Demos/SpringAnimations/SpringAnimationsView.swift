import SwiftUI

struct SpringAnimationsView: View {

    typealias AnimationType = SpringAnimationsControlPanel.AnimationType

    // MARK: - Private properties

    @State private var animateScale = false
    @State private var animateMove = false
    @State private var animateRotation = false
    @State private var dragOffset = CGSize.zero

    @State private var selectedAnimationType: AnimationType.ID = 1
    @State private var animationResponse: Double = 0.5
    @State private var animationDampingFraction: Double = 0.5
    @State private var animationBlendDuration: Double = 0

    private let animationTypes = [
        AnimationType(id: 0, name: "Scale"),
        AnimationType(id: 1, name: "Move"),
        AnimationType(id: 2, name: "Rotation"),
        AnimationType(id: 3, name: "Ball")
    ]

    private var springAnimation: Animation {
        .spring(
            response: animationResponse,
            dampingFraction: animationDampingFraction,
            blendDuration: animationBlendDuration
        )
    }

    // MARK: - Body

    var body: some View {
        ZStack {
            switch selectedAnimationType {
            case 0: scaleAnimationView.transition(.opacity.animation(.linear(duration:  0.2)))
            case 1: moveAnimationView.transition(.opacity.animation(.linear(duration:  0.2)))
            case 2: rotationAnimationView.transition(.opacity.animation(.linear(duration:  0.2)))
            case 3: dragAnimationView.transition(.opacity.animation(.linear(duration:  0.2)))
            default: Text("Nothing here...")
            }

            controlPanel
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .navigationTitle(Text("Spring animations"))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: stopAnimation) {
                    Label("Stop animation", systemImage: "arrow.counterclockwise")
                        .font(.system(size: 18, weight: .medium))
                }
            }
        }
        .accentColor(.orange)
    }

    // MARK: - Actions

    private func stopAnimation() {
        withAnimation(.easeInOut(duration: 0.5)) {
            animateScale.toggle()
            animateMove.toggle()
            animateRotation.toggle()
            dragOffset = .init(width: 0, height: 1)
        }

        withAnimation(.easeInOut(duration: 0.1)) {
            animateScale = false
            animateMove = false
            animateRotation = false
            dragOffset = .zero
        }
    }

    // MARK: - Subviews

    private var scaleAnimationView: some View {
        VStack {
            Circle()
                .frame(height: animateScale ? 200 : 100)
                .foregroundColor(.accentColor)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(tapScaleBackground)
        .onAppear {
            stopAnimation()
            print("Show SCALE animation")
        }
    }

    private var moveAnimationView: some View {
        VStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundColor(.accentColor)
                .frame(width: 100, height: 200)

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: animateMove ? .trailing : .leading)
        .padding(.horizontal, 30)
        .padding(.top, 50)
        .background(tapMoveBackground)
        .onAppear {
            stopAnimation()
            print("Show MOVE animation")
        }
    }

    private var rotationAnimationView: some View {
        VStack {
            Capsule(style: .circular)
                .frame(width: 200, height: 100)
                .foregroundColor(.accentColor)
                .rotationEffect(animateRotation ? .degrees(30) : .degrees(-30))

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.top, 80)
        .background(tapRotationBackground)
        .onAppear {
            stopAnimation()
            print("Show ROTATION animation")
        }
    }

    private var dragAnimationView: some View {
        ZStack {
            Circle()
                .frame(height: 20)
                .opacity(0.5)

            Circle()
                .frame(height: 80)
                .foregroundColor(.accentColor)
                .offset(dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            dragOffset = gesture.translation
                        }
                        .onEnded { _ in
                            withAnimation(springAnimation) {
                                dragOffset = .zero
                            }
                        }
                )
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            stopAnimation()
            print("Show DRAG animation")
        }
        .zIndex(1)
    }

    private var tapScaleBackground: some View {
        Color.clear
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(springAnimation) {
                    animateScale.toggle()
                }
            }
    }

    private var tapMoveBackground: some View {
        Color.clear
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(springAnimation) {
                    animateMove.toggle()
                }
            }
    }

    private var tapRotationBackground: some View {
        Color.clear
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(springAnimation) {
                    animateRotation.toggle()
                }
            }
    }

    private var controlPanel: some View {
        VStack {
            Spacer()

            SpringAnimationsControlPanel(
                response: $animationResponse,
                damping: $animationDampingFraction,
                blend: $animationBlendDuration,
                selectedAnimationType: $selectedAnimationType,
                animationTypes: animationTypes
            )
        }
    }
}

struct SpringAnimationsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SpringAnimationsView()
        }
    }
}
