//
//  GameRepository.swift
//  Core
//
//  Created by Victor . on 18/11/21.
//

import Foundation
import RxSwift

public protocol GameRepositoryProtocol {
    func getGameList(page: Int) -> Observable<GameList>
    func checkIsfavorites(id: Int) -> Observable<Bool>
    func getGameDetail(for id: Int) -> Observable<GameDetail>
    func insertFavorites(game: Game) -> Observable<Bool>
    func removeFavorites(id: Int) -> Observable<Bool>
    func getAllFavorites() -> Observable<[Game]>

}

public final class GameRepository: NSObject {
    public typealias GameInstance = (RemoteDataSource, LocaleDataSource) -> GameRepository

    public  let remote: RemoteDataSource
    public  let locale: LocaleDataSource

    private init(remote: RemoteDataSource, locale: LocaleDataSource) {
        self.remote = remote
        self.locale = locale
    }

    public static let sharedInstance: GameInstance = { remoteRepo, localRepo in
        return GameRepository(remote: remoteRepo, locale: localRepo)
    }
}

extension GameRepository: GameRepositoryProtocol {
    public func getGameList(page: Int) -> Observable<GameList> {
        return self.remote.getGameList(page: page)
            .map { GameListMapper.mapGameListResposeToGameListModel(input: $0)}
    }

    public func checkIsfavorites(id: Int) -> Observable<Bool> {
        return self.locale.checkIsFavorites(id: id)
    }

    public func getGameDetail(for id: Int) -> Observable<GameDetail> {
        return self.remote.getGameDetail(for: id)
            .map { GameDetailMapper.mapGameDetailResposeToGameDetailModel(input: $0)}
    }

    public func insertFavorites(game: Game) -> Observable<Bool> {
        return self.locale.insertFavorites(game: game)
    }

    public func removeFavorites(id: Int) -> Observable<Bool> {
        return self.locale.removeFavorites(id: id)
    }

    public func getAllFavorites() -> Observable<[Game]> {
        return self.locale.getAllFavorites()
    }
}

