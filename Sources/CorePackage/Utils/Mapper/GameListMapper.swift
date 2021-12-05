//
//  GameListMapper.swift
//  Core
//
//  Created by Victor . on 18/11/21.
//

import Foundation


public final class GameListMapper {
    public static func mapGameListResposeToGameListModel(input gameList: GameListResponse) -> GameList {
        let game = gameList.results.map { gameResponse in
            return Game(id: gameResponse.id,
                        name: gameResponse.name,
                        releaseDate: gameResponse.releaseDate,
                        image: gameResponse.image,
                        rating: gameResponse.rating,
                        maxRating: gameResponse.maxRating,
                        genres: gameResponse.genres,
                        platforms: gameResponse.platforms)
        }
        return GameList(count: gameList.count ,
                        next: gameList.next ?? "" ,
                        previous: gameList.previous ?? "" ,
                        results: game)
    }
}
