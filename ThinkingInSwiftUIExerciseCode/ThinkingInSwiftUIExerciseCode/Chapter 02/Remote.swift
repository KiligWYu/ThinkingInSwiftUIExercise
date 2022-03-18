//
//  Remote.swift
//  ThinkingInSwiftUIExerciseCode
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 2022/3/14.
//

import Foundation
import Combine

struct LoadingError: Error {}

class Remote<T>: ObservableObject {
  @Published var result: Result<T, Error>? = nil
  var value: T? { try? result?.get() }

  let url: URL, transform: (Data) -> T?

  init(url: URL, transform: @escaping (Data) -> T?) {
    self.url = url
    self.transform = transform
  }

  func load() {
    URLSession.shared.dataTask(with: url) { data, _, _ in
      DispatchQueue.main.async {
        if let data = data, let v = self.transform(data) {
          self.result = .success(v)
        } else {
          self.result = .failure(LoadingError())
        }
      }
    }
    .resume()
  }
}
