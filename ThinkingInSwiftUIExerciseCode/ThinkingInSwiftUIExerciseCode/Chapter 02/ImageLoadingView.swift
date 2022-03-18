//
//  ImageLoadingView.swift
//  ThinkingInSwiftUIExerciseCode
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 2022/3/14.
//

import SwiftUI

struct ImageLoadingView: View {
  @ObservedObject var items = Remote<[Photo]>(url: URL(string: "https://picsum.photos/v2/list")!) { data in
    try? JSONDecoder().decode([Photo].self, from: data)
  }

  var body: some View {
    if let photos = items.value {
      List(photos) { photo in
        NavigationLink(photo.author) {
          PhotoView(photo.downloadURL, aspectradio: photo.width / photo.height)
        }
      }
      .navigationBarTitleDisplayMode(.inline)
    } else {
      ProgressView()
        .onAppear { items.load() }
    }
  }
}

struct ImageLoadingView_Previews: PreviewProvider {
  static var previews: some View {
    ImageLoadingView()
  }
}
