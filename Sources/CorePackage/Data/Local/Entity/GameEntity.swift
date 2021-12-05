//
//  GameEntity.swift
//  Core
//
//  Created by Victor . on 18/11/21.
//

import Foundation


public struct GameEntity {
    public let id: Int?
    public let name: String?
    public let releaseDate: Date?
    public let image: String?
    public let rating: Float?
    public let maxRating: Int?
    public let genres: [Genre]?
    public let platforms: [Platforms]?
    public var isFavorites: Bool?
}
