//
//  PhotoView.swift
//  ThinkingInSwiftUIExerciseCode
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 2022/3/14.
//

import SwiftUI

struct PhotoView: View {
  @ObservedObject var image: Remote<UIImage>
  var aspectradio: CGFloat

  init(_ url: URL, aspectradio: CGFloat) {
    image = Remote(url: url, transform: { UIImage(data: $0) })
    self.aspectradio = aspectradio
  }

  var imageOrPlaceholder: Image {
    image.value.map(Image.init) ?? Image(systemName: "photo")
  }

  var body: some View {
    imageOrPlaceholder
      .resizable()
      .foregroundColor(.secondary)
      .aspectRatio(aspectradio, contentMode: .fit)
      .padding()
      .onAppear {
        image.load()
      }
  }
}

/*
struct PhotoView: View {
  var url: URL, radio: CGFloat
  @State var image: UIImage?

  var imageOrPlaceholder: Image {
    image.map(Image.init) ?? Image(systemName: "photo")
  }

  var body: some View {
    ProgressView()
      .progressViewStyle(.circular)
    imageOrPlaceholder
      .resizable()
      .foregroundColor(.secondary)
      .aspectRatio(radio, contentMode: .fit)
      .padding()
      .onAppear {
        DispatchQueue.main.async {
          if let data = try? Data(contentsOf: url) {
            image = UIImage(data: data)
          }
        }
      }
  }
}
*/
