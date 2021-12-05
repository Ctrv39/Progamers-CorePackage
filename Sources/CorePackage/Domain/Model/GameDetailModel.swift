//
//  GameDetailModel.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import SwiftUI

@available(macOS 10.15, *)
public struct GameDetail {
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

    public func getRatingColor() -> Color {
        switch self.rating {
        case 4.0...:
            return Color("Green")
        case 2.5..<4.0:
            return Color("Yellow")
        default:
            return Color("Red")

        }
    }

    public static func getDummyData() -> GameDetail {
        return GameDetail(itemId: -1,
                          name: "", releaseDate: "",
                          image: "", rating: 0.0,
                          maxRating: 0, genres: [],
                          platforms: [], description: "",
                          website: "", esrb: nil, isFavorites: false)
    }
}
