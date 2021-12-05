//
//  RemoteDataSource.swift
//  Core
//
//  Created by Victor . on 18/11/21.
//

import Foundation
import RxSwift
import Alamofire

public protocol RemoteDataSourceProtocol: class {
    func getGameList(page: Int) -> Observable<GameListResponse>
    func getGameDetail(for id: Int) -> Observable<GameDetailResponse>
}

public final class RemoteDataSource: NSObject {
    private var apiKey = "6a62324d4cce48d193f5e0834619d670"
    private override init() { }
    public static let sharedInstance: RemoteDataSource =  RemoteDataSource()
}

extension RemoteDataSource: RemoteDataSourceProtocol {
    public func getGameList(page: Int) -> Observable<GameListResponse> {
        return Observable<GameListResponse>.create { observer in
            if let url = URL(string: Endpoints.Gets.list.url) {
                AF.request(url,
                           method: .get,
                           parameters: ["page": page, "key": self.apiKey, "page_size": "10"],
                           encoding: URLEncoding(destination: .queryString))
                    .validate()
                    .responseDecodable(of: GameListResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }

    public func getGameDetail(for id: Int) -> Observable<GameDetailResponse> {
        return Observable<GameDetailResponse>.create { observer in
            if let url = URL(string: Endpoints.Gets.detail.url+"\(id)") {
                AF.request(url,
                           method: .get,
                           parameters: ["key": self.apiKey],
                           encoding: URLEncoding(destination: .queryString))
                    .validate()
                    .responseDecodable(of: GameDetailResponse.self) { response in
                        switch response.result {
                        case .success(let value):
                            observer.onNext(value)
                            observer.onCompleted()
                        case .failure:
                            observer.onError(URLError.invalidResponse)
                        }
                    }
            }
            return Disposables.create()
        }
    }
}

enum URLError: LocalizedError {
    case invalidResponse
    case addressUnreachable(URL)

    var errorDescription: String? {
        switch self {
        case .invalidResponse: return "The server responded with garbage."
        case .addressUnreachable(let url): return "\(url.absoluteString) is unreachable."
        }
    }
}
