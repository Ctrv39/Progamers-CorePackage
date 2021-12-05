//
//  GameDetailMapper.swift
//  ProgamersExpert
//
//  Created by Viktor . on 31/10/21.
//

import Foundation

public final class GameDetailMapper {
    public static func mapGameDetailResposeToGameDetailModel(input gameDetail: GameDetailResponse) -> GameDetail {
        return GameDetail(itemId: gameDetail.itemId,
                          name: gameDetail.name,
                          releaseDate: gameDetail.releaseDate,
                          image: gameDetail.image,
                          rating: gameDetail.rating,
                          maxRating: gameDetail.maxRating,
                          genres: gameDetail.genres,
                          platforms: gameDetail.platforms,
                          description: gameDetail.description,
                          website: gameDetail.website,
                          esrb: gameDetail.esrb,
                          isFavorites: gameDetail.isFavorites)
    }

    public static func mapGameDetailToGame(input gameDetail: GameDetail) -> Game {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let releaseDate = dateFormatter.date(from: gameDetail.releaseDate) ?? Date()
        return Game(id: gameDetail.itemId,
                    name: gameDetail.name,
                    releaseDate: releaseDate,
                    image: gameDetail.image,
                    rating: gameDetail.rating,
                    maxRating: gameDetail.maxRating,
                    genres: gameDetail.genres,
                    platforms: gameDetail.platforms)
    }
}
