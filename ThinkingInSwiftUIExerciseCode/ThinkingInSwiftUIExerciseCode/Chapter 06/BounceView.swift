//
//  BounceView.swift
//  ThinkingInSwiftUIExerciseCode
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 2022/3/17.
//

import SwiftUI

struct BounceAnimationView: View {
  @State private var taps: Int = 0

  var body: some View {
    Button("Tap Me") {
      withAnimation(.linear(duration: 0.9)) {
        self.taps += 1
      }
    }.bounce(times: taps * 3)
  }
}

// MARK: -

struct Bounce: Animatable, ViewModifier {
  var times: CGFloat = 0
  var amplitude: CGFloat = 30
  var animatableData: CGFloat {
    get { times }
    set { times = newValue }
  }

  func body(content: Content) -> some View {
    content.offset(y: -abs(sin(times * .pi)) * amplitude)
  }
}

extension View {
  func bounce(times: Int) -> some View {
    modifier(Bounce(times: CGFloat(times)))
  }
}
