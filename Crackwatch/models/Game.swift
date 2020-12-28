//
//  Game.swift
//  Crackwatch
//
//  Created by Kenneth James Uy on 11/13/20.
//

import Foundation

class Game: Codable {
  
  var id: String
  var title: String
  var releaseDate: String?
  var protections: [String]
  var imageUrl: String
  var imagePosterUrl: String
  var groups: [String]
  var crackDate: String?
  
  private enum CodingKeys: String, CodingKey {
    case id = "_id"
    case title
    case releaseDate
    case protections
    case imageUrl = "image"
    case imagePosterUrl = "imagePoster"
    case groups
    case crackDate
  }
}
