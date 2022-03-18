//
//  CollapsibleView.swift
//  ThinkingInSwiftUIExerciseCode
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 2022/3/16.
//

import SwiftUI

struct CollapsibleView: View {
  let colors: [(Color, CGFloat)] = [(.init(white: 0.3), 50), (.init(white: 0.8), 30), (.init(white: 0.5), 75)]
  @State var expanded = true

  var body: some View {
    VStack {
      HStack {
        Collapsible(data: colors, expanded: expanded) { item in
          Rectangle()
            .fill(item.0)
            .frame(width: item.1, height: item.1)
        }
        .border(Color.black)
      }
      Button {
        withAnimation {
          expanded.toggle()
        }
      } label: {
        Text(expanded ? "Collapse" : "Expand")
      }
    }
  }
}

struct CollapsibleView_Previews: PreviewProvider {
  static var previews: some View {
    CollapsibleView()
  }
}

// MARK: -

struct Collapsible<Element, Content: View>: View {
  var data: [Element]
  var expanded = false
  var content: (Element) -> Content
  var collapsibledWidth: CGFloat = 10
  var spacing: CGFloat? = 8
  var alignment: VerticalAlignment = .center

  func child(at index: Int) -> some View {
    let showExpanded = expanded || index == data.endIndex - 1
    return content(data[index])
      .frame(width: showExpanded ? nil : collapsibledWidth,
             alignment: Alignment(horizontal: .leading, vertical: alignment))
  }

  var body: some View {
    HStack(alignment: alignment, spacing: expanded ? spacing : 0) {
      ForEach(data.indices, id: \.self) {
        child(at: $0)
      }
    }
  }
}
