//
//  BadgeView.swift
//  ThinkingInSwiftUIExerciseCode
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 2022/3/16.
//

import SwiftUI

struct BadgeView: View {
  var body: some View {
    Text("Hello")
      .padding(10)
      .background(Color.gray)
      .badge(count: 5)
  }
}

struct BadgeView_Previews: PreviewProvider {
  static var previews: some View {
    BadgeView()
  }
}

extension View {
  func badge(count: Int) -> some View {
    overlay(
      ZStack {
        if count != 0 {
          Circle()
            .fill(.red)
          Text("\(count)")
            .foregroundColor(.white)
            .font(.caption)
        }
      }
      .offset(x: 12, y: -12)
      .frame(width: 24, height: 24),
      alignment: .topTrailing)
  }
}
