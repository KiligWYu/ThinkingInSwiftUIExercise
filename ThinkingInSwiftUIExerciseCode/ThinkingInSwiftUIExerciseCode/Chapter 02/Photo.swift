//
//  Photo.swift
//  ThinkingInSwiftUIExerciseCode
//
//  Created by 𝕶𝖎𝖑𝖎𝖌 on 2022/3/14.
//

import Foundation
import UIKit

struct Photo: Codable {
  let id: String
  let author: String
  let width: CGFloat
  let height: CGFloat
  let url: URL
  let downloadURL: URL

  private enum CodingKeys: String, CodingKey {
    case id
    case author
    case width
    case height
    case url
    case downloadURL = "download_url"
  }
}

extension Photo: Identifiable {}
