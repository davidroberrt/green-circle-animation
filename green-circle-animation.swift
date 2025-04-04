ximport SwiftUI

struct AnimatedCircle: Shape {
    @State var rotation: Double = 0

    func path(in rect: CGRect) -> Path {
        var path = Path()
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2

        path.addArc(center: center, radius: radius, startAngle: .degrees(rotation), endAngle: .degrees(rotation + 270), clockwise: true)

        return path
    }

    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
}

struct ContentView: View {
    @State private var isAnimating = false

    var body: some View {
        AnimatedCircle()
            .stroke(AngularGradient(gradient: Gradient(colors: [.green.opacity(0.8), .green.opacity(0.2)]), center: .center), style: StrokeStyle(lineWidth: 10, lineCap: .round))
            .frame(width: 100, height: 100)
            .rotationEffect(.degrees(isAnimating ? 360 : 0))
            .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false), value: isAnimating)
            .onAppear {
                isAnimating = true
            }
    }
}
