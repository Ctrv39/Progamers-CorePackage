//
//  LocaleDataSource.swift
//  Core
//
//  Created by Victor . on 18/11/21.
//

import Foundation
import RxSwift
import CoreData

public protocol LocaleDataSourceProtocol: class {
    func getAllFavorites() -> Observable<[Game]>
    func insertFavorites(game: Game) -> Observable<Bool>
    func removeFavorites(id: Int) -> Observable<Bool>
    func checkIsFavorites(id: Int) -> Observable<Bool>
}

public final class LocaleDataSource: NSObject {
    private var apiKey = "6a62324d4cce48d193f5e0834619d670"

    private override init() { }

    public static let sharedInstance: LocaleDataSource =  LocaleDataSource()

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GameFavorites")
        container.loadPersistentStores { _, error in
            guard error == nil else {
                fatalError("Unresolved error \(error!)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = false
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        return container
    }()

    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        taskContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return taskContext
    }
}

extension LocaleDataSource: LocaleDataSourceProtocol {
    public func getAllFavorites() -> Observable<[Game]> {
        return Observable<[Game]>.create { observer in
            let taskContext = self.newTaskContext()
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
                do {
                    let results = try taskContext.fetch(fetchRequest)
                    var games: [Game] = []
                    for result in results {
                        let genresData = (result.value(forKeyPath: "genres") as? String)!.data(using: .utf8)!
                        let platformsData = (result.value(forKeyPath: "platforms") as? String)!.data(using: .utf8)!
                        let decoder = JSONDecoder()
                        let genres = try decoder.decode([Genre].self, from: genresData)
                        let platforms = try decoder.decode([Platforms].self, from: platformsData)
                        let gameEntity =
                            GameEntity(id: result.value(forKeyPath: "id") as? Int,
                                        name: result.value(forKeyPath: "name") as? String,
                                        releaseDate: result.value(forKeyPath: "releaseDate") as? Date,
                                        image: result.value(forKeyPath: "image") as? String,
                                        rating: result.value(forKeyPath: "rating") as? Float,
                                        maxRating: result.value(forKeyPath: "maxRating") as? Int,
                                        genres: genres,
                                        platforms: platforms,
                                        isFavorites: result.value(forKeyPath: "isFavorites") as? Bool)
                        let game = GameMapper.mapGameEntitytoGameModel(gameEntity: gameEntity)
                        games.append(game)
                    }
                    observer.onNext(games)
                    observer.onCompleted()
                } catch let error as NSError {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }

    public func insertFavorites(game: Game) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            let taskContext = self.newTaskContext()
            taskContext.performAndWait {
                if let entity = NSEntityDescription.entity(forEntityName: "Favorites", in: taskContext) {
                    let favorite = NSManagedObject(entity: entity, insertInto: taskContext)
                    let encoder = JSONEncoder()
                    if let genres = try? encoder.encode(game.genres),
                        let platforms = try? encoder.encode(game.platforms) {
                        if let jsonStringGenres = String(data: genres, encoding: .utf8),
                           let jsonStringPlatforms = String(data: platforms, encoding: .utf8) {
                            favorite.setValue(game.id, forKeyPath: "id")
                            favorite.setValue(game.name, forKeyPath: "name")
                            favorite.setValue(game.releaseDate, forKeyPath: "releaseDate")
                            favorite.setValue(game.image, forKeyPath: "image")
                            favorite.setValue(game.rating, forKeyPath: "rating")
                            favorite.setValue(game.maxRating, forKeyPath: "maxRating")
                            favorite.setValue(jsonStringGenres, forKeyPath: "genres")
                            favorite.setValue(jsonStringPlatforms, forKeyPath: "platforms")
                            favorite.setValue(true, forKeyPath: "isFavorites")
                        }
                    }
                    do {
                        try taskContext.save()
                        observer.onNext(true)
                        observer.onCompleted()
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                        observer.onError(error)
                    }
                }
            }
            return Disposables.create()
        }
    }

    public func removeFavorites(id: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            let taskContext = self.newTaskContext()
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favorites")
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "id == \(id)")
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                batchDeleteRequest.resultType = .resultTypeCount
                if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
                    if batchDeleteResult.result != nil {
                        observer.onNext(true)
                        observer.onCompleted()
                    } else {
                        observer.onNext(false)
                        observer.onCompleted()
                    }
                } else {
                    observer.onNext(false)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }

    public func checkIsFavorites(id: Int) -> Observable<Bool> {
        return Observable<Bool>.create { observer in
            let taskContext = self.newTaskContext()
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorites")
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "id == \(id)")
                do {
                    if try taskContext.fetch(fetchRequest).first != nil {
                        observer.onNext(true)
                        observer.onCompleted()
                    } else {
                        observer.onNext(false)
                        observer.onCompleted()
                    }
                } catch let error as NSError {
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
