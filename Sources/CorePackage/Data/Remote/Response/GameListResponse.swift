//
//  GameListResponse.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import Foundation

public struct GameListResponse: Decodable {
    public let count: Int
    public var next: String?
    public var previous: String?
    public var results: [GameResponse]
}

public struct GameResponse: Decodable {
    public let id: Int
    public let name: String
    public let releaseDate: Date
    public let image: String
    public let rating: Float
    public let maxRating: Int
    public let genres: [Genre]
    public let platforms: [Platforms]
    public var isFavorites: Bool
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case releaseDate = "released"
        case image = "background_image"
        case rating
        case maxRating = "rating_top"
        case genres
        case platforms = "parent_platforms"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let dateString = try container.decode(String.self, forKey: .releaseDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)!
        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        releaseDate = date
        image = try container.decode(String.self, forKey: .image)
        rating = try container.decode(Float.self, forKey: .rating)
        maxRating = try container.decode(Int.self, forKey: .maxRating)
        genres = try container.decode([Genre].self, forKey: .genres)
        platforms = try container.decode([Platforms].self, forKey: .platforms)
        isFavorites = false
    }
}
