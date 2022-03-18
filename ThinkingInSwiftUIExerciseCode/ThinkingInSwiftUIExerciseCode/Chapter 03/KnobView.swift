//
//  KnobView.swift
//  ThinkingInSwiftUIExerciseCode
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 2022/3/16.
//

import SwiftUI

struct KnobView: View {
  @State var value: Double = 0.5
  @State var knobSize: CGFloat = 0.1
  @State var useDefaultColor: Bool = true
  @State var hue: Double = 0

  var body: some View {
    VStack {
      Knob(value: $value)
        .frame(width: 100, height: 100)
        .knobPointerSize(knobSize)
        .knobColor(useDefaultColor ? nil : Color(hue: hue, saturation: 1, brightness: 1))
      HStack { 
        Text("Value")
        Slider(value: $value, in: 0...1)
      }
      HStack {
        Text("Knob Size")
        Slider(value: $knobSize, in: 0...0.4)
      }
      HStack {
        Text("Color")
        Slider(value: $hue, in: 0...1)
      }
      Toggle(isOn: $useDefaultColor) {
        Text("Default Color")
      }
      Button {
        withAnimation {
          self.value = self.value == 0 ? 1 : 0
        }
      } label: {
        Text("Toggle")
      }
    }
  }
}

// MARK: -

extension View {
  func knobPointerSize(_ size: CGFloat) -> some View {
    environment(\.knobPointerSize, size)
  }

  func knobColor(_ color: Color?) -> some View {
    environment(\.knobColor, color)
  }
}

// MARK: -

struct Knob: View {
  @Binding var value: Double
  var pointerSize: CGFloat? = nil
  @Environment(\.knobPointerSize) var envPointerSize
  @Environment(\.knobColor) var envColor
  @Environment(\.colorScheme) var colorScheme

  private var fillColor: Color {
    envColor ?? (colorScheme == .dark ? Color.white : Color.black)
  }

  var body: some View {
    KnobShape(pointerSize: pointerSize ?? envPointerSize)
      .fill(fillColor)
      .rotationEffect(Angle(degrees: value * 330))
      .onTapGesture {
        withAnimation {
          self.value = self.value < 0.5 ? 1 : 0
        }
      }
  }
}

struct KnobShape: Shape {
  var pointerSize: CGFloat = 0.1
  var pointerWidth: CGFloat = 0.1

  func path(in rect: CGRect) -> Path {
    let pointerHeight = rect.height * pointerSize
    let pointerWidth = rect.width * pointerWidth
    let circleRect = rect.insetBy(dx: pointerHeight, dy: pointerHeight)
    return Path { p in
      p.addEllipse(in: circleRect)
      p.addRect(CGRect(x: rect.midX - pointerWidth / 2,
                       y: 0,
                       width: pointerWidth,
                       height: pointerHeight + 2))
    }
  }
}

// MARK: -

private struct PointerSizeKey: EnvironmentKey {
  static let defaultValue: CGFloat = 0.1
}

private struct ColorKey: EnvironmentKey {
  static let defaultValue: Color? = nil
}

extension EnvironmentValues {
  var knobPointerSize: CGFloat {
    get { self[PointerSizeKey.self] }
    set { self[PointerSizeKey.self] = newValue }
  }

  var knobColor: Color? {
    get { self[ColorKey.self] }
    set { self[ColorKey.self] = newValue }
  }
}
