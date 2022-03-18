//
//  TableView.swift
//  ThinkingInSwiftUIExerciseCode
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 2022/3/16.
//

import SwiftUI

struct TableView: View {
  var cells = [
    [Text(""), Text("Monday").bold(), Text("Tuesday").bold(),
     Text("Wednesday").bold()],
    [Text("Berlin").bold(), Text("Cloudy"), Text("Mostly\nSunny"), Text("Sunny")],
    [Text("London").bold(), Text("Heavy Rain"), Text("Cloudy"), Text("Sunny")],
  ]

  var body: some View {
    Table(cells: cells)
      .font(Font.system(.body, design: .serif))
//      .border(Color.black)
  }
}

struct TableView_Previews: PreviewProvider {
  static var previews: some View {
    TableView()
  }
}

// MARK: -

struct Table<Cell: View>: View {
  var cells: [[Cell]]
  let padding: CGFloat = 5
  @State private var columnWidths: [Int: CGFloat] = [:]

  @Namespace var namespace
  @State var selectedIndex: Int? = nil

  var body: some View {
    VStack {
      ForEach(cells.indices, id: \.self) { row in
        HStack(alignment: .top) {
          ForEach(cells[row].indices, id: \.self) { column in
            cellFor(row: row, column: column)
          }
        }
        .background(row % 2 != 0 ? Color(uiColor: .secondarySystemBackground) : Color(uiColor: .systemBackground))
      }
    }
    .onPreferenceChange(WidthPreference.self) {
      self.columnWidths = $0
    }
  }

  func cellFor(row: Int, column: Int) -> some View {
    cells[row][column]
      .widthPreference(column: column)
      .frame(width: columnWidths[column], alignment: .leading)
      .padding(padding)
      .background(
        Group {
          if let selectedIndex = selectedIndex {
            Rectangle()
              .fill(Color.clear)
              .border(Color.blue, width: 2)
              .matchedGeometryEffect(id: selectedIndex, in: namespace, isSource: false)
          }
        }
      )
      .matchedGeometryEffect(id: row * self.cells[row].count + column, in: namespace)
      .onTapGesture {
        withAnimation {
          self.selectedIndex = row * self.cells[row].count + column
        }
      }
  }
}

// MARK: -

struct WidthPreference: PreferenceKey {
  static let defaultValue: [Int: CGFloat] = [:]

  static func reduce(value: inout Value, nextValue: () -> Value) {
    value.merge(nextValue(), uniquingKeysWith: max)
  }
}

extension View {
  func widthPreference(column: Int) -> some View {
    background(
      GeometryReader { proxy in
        Color.clear.preference(key: WidthPreference.self, value: [column: proxy.size.width])
      }
    )
  }
}
