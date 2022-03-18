//
//  ContentView.swift
//  ThinkingInSwiftUIExerciseCode
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 2022/3/14.
//

import SwiftUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      List {
        NavigationLink("第 2 章：View 更新", destination: ImageLoadingView())
        NavigationLink("第 3 章：环境 - 可配置的旋钮颜色", destination: KnobView())
        NavigationLink("第 4 章：布局 - 可折叠的 HStack", destination: CollapsibleView())
        NavigationLink("第 4 章：布局 - 角标 View", destination: BadgeView())
        NavigationLink("第 5 章：自定义布局 - 创建表格", destination: TableView())
        NavigationLink("第 6 章：动画 - 反弹动画", destination: BounceAnimationView())
        NavigationLink("第 6 章：动画 - 路径动画", destination: GraphAnimationView())
      }
      .navigationTitle("SwiftUI 编程思想")
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
