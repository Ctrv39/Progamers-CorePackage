//
//  GameDetailResponse.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import Foundation

public struct GameDetailResponse: Codable {
    public let itemId: Int
    public let name: String
    public let releaseDate: String
    public let image: String
    public let rating: Float
    public let maxRating: Int
    public let genres: [Genre]
    public let platforms: [Platforms]
    public let description: String
    public let website: String
    public let esrb: ESRB?
    public var isFavorites: Bool = false

    public enum CodingKeys: String, CodingKey {
        case itemId = "id"
        case name
        case releaseDate = "released"
        case image = "background_image"
        case rating
        case maxRating = "rating_top"
        case genres
        case platforms = "parent_platforms"
        case description = "description_raw"
        case website
        case esrb = "esrb_rating"
    }
}
