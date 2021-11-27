//
//  GameConfig.swift
//  CutTheShape
//
//  Created by L Daniel De San Pedro on 25/11/21.
//

import Foundation

// MARK: - Config
struct GameConfig: Codable {
    let dificulties: [DificultyConfig]
}

// MARK: - Dificulty
struct DificultyConfig: Codable {
    let dificulty: Dificulty
    let timeCountdown: Int
    let shape: Shape
}

enum Dificulty: String, Codable {
    case easy
    case medium
    case hard
    case unknown
    init(from decoder: Decoder) throws {
        let container: SingleValueDecodingContainer = try decoder.singleValueContainer()
        let type: String = try container.decode(String.self)
        self = Dificulty(rawValue: type) ?? .unknown
    }
}

enum Shape: String, Codable {
  case square
  case triangle
  case circle
  case unknown
  init(from decoder: Decoder) throws {
    let container: SingleValueDecodingContainer = try decoder.singleValueContainer()
    let type: String = try container.decode(String.self)
    self = Shape(rawValue: type) ?? .unknown
  }
}
