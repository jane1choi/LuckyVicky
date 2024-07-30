//
//  NetworkProvider.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/30/24.
//

import Combine
import CombineMoya
import Moya

protocol Requestable {
    associatedtype API: TargetType
    
    func request(_ endpoint: API) -> AnyPublisher<Response, MoyaError>
}

extension Requestable {
    func request(_ endpoint: API) -> AnyPublisher<Response, MoyaError> {
        self.request(endpoint)
    }
}

final class NetworkProvider<API: TargetType>: Requestable {
    
    private let provider: MoyaProvider<API>
    
    init(plugins: [PluginType] = []) {
        let session = MoyaProvider<API>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 10
        
        self.provider = MoyaProvider(session: session, plugins: plugins)
    }
    
    func request(_ api: API) -> AnyPublisher<Response, MoyaError> {
        return provider.requestPublisher(api)
    }
}
