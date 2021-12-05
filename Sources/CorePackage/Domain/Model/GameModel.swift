//
//  GameModel.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import Foundation

public struct Game: Identifiable {
    public let id: Int
    public let name: String
    public let releaseDate: Date
    public let image: String
    public let rating: Float
    public let maxRating: Int
    public let genres: [Genre]
    public let platforms: [Platforms]
    public var isFavorites: Bool = false

}
