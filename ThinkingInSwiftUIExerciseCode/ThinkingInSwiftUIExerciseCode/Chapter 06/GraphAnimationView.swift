//
//  ShapeAnimation.swift
//  ThinkingInSwiftUIExerciseCode
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 2022/3/17.
//

import SwiftUI

let sampleData: [CGFloat] = [0.1, 0.7, 0.3, 0.6, 0.45, 1.1]

struct GraphAnimationView: View {
  @State var visible = false
  let graph = LineGraph(dataPoints: sampleData)

  var body: some View {
    VStack {
      ZStack {
        graph
          .trim(from: 0, to: visible ? 1 : 0)
          .stroke(Color.red, lineWidth: 2)
        Circle()
          .fill(.red)
          .frame(width: 10, height: 10)
          .position(on: graph, at: visible ? 1 : 0)
      }
      .aspectRatio(16 / 9, contentMode: .fit)
      .border(Color.gray, width: 1)
      .padding()

      Button {
        withAnimation(Animation.easeInOut(duration: 2)) {
          self.visible.toggle()
        }
      } label: {
        Text("Animate")
      }
    }
  }
}

// MARK: -

struct LineGraph: Shape {
  var dataPoints: [CGFloat]

  func path(in rect: CGRect) -> Path {
    Path { p in
      guard dataPoints.count > 1 else { return }
      let start = dataPoints[0]
      p.move(to: CGPoint(x: 0, y: (1 - start) * rect.height))
      for (index, point) in dataPoints.enumerated() {
        let x = rect.width * CGFloat(index) / CGFloat(dataPoints.count - 1)
        let y = (1 - point) * rect.height
        p.addLine(to: CGPoint(x: x, y: y))
      }
    }
  }
}

// MARK: -

extension View {
  func position<S: Shape>(on shape: S, at amount: CGFloat) -> some View {
    GeometryReader { proxy in
      self
        .modifier(PositionOnShapEffect(path: shape.path(in: CGRect(origin: .zero, size: proxy.size)), at: amount))
        .frame(width: proxy.size.width, height: proxy.size.height, alignment: .topLeading)
    }
  }
}

// MARK: -

struct PositionOnShapEffect: GeometryEffect {
  var path: Path
  var at: CGFloat

  var animatableData: CGFloat {
    get { at }
    set { at = newValue }
  }

  func effectValue(size: CGSize) -> ProjectionTransform {
    let trimmed = path.trimmedPath(from: 0, to: at == 0 ? 0.00001 : at)
    let point = trimmed.currentPoint ?? .zero
    return ProjectionTransform(.init(translationX: point.x - size.width / 2, y: point.y - size.height / 2))
  }
}
