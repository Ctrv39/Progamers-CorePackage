//
//  GameMapper.swift
//  ProgamersExpert
//
//  Created by Viktor . on 05/11/21.
//

import Foundation

public final class GameMapper {
    public static func mapGameEntitytoGameModel(gameEntity: GameEntity) -> Game {
        return Game(id: gameEntity.id ?? -1,
                    name: gameEntity.name ?? "",
                    releaseDate: gameEntity.releaseDate ?? Date(),
                    image: gameEntity.image ?? "",
                    rating: gameEntity.rating ?? 0.0,
                    maxRating: gameEntity.maxRating ?? 0,
                    genres: gameEntity.genres ?? [],
                    platforms: gameEntity.platforms ?? [],
                    isFavorites: gameEntity.isFavorites ?? false)
    }
}
