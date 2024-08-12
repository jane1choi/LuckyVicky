//
//  NetworkProvider.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/30/24.
//

import Foundation

import Combine
import CombineMoya
import Moya

protocol Requestable {
    associatedtype API: BaseAPI
    
    func request<T: Decodable>(_ api: API) -> AnyPublisher<T, NetworkError>
}

final class NetworkProvider<API: BaseAPI>: Requestable {
    private let provider: MoyaProvider<API>
    
    init(
        plugins: [PluginType] = [],
        isStub: Bool = false,
        sampleStatusCode: Int = 200,
        customEndpointClosure: ((API) -> Endpoint)? = nil
    ) {
        let session = MoyaProvider<API>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 30
        
        if isStub {
            let endPointClosure = { (target: API) -> Endpoint in
                let sampleResponseClosure: () -> EndpointSampleResponse = {
                    EndpointSampleResponse.networkResponse(sampleStatusCode, target.sampleData)
                }
                return Endpoint(
                    url: URL(target: target).absoluteString,
                    sampleResponseClosure: sampleResponseClosure,
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers
                )
            }
            self.provider = MoyaProvider(endpointClosure: customEndpointClosure ?? endPointClosure, 
                                         stubClosure: MoyaProvider.immediatelyStub)
        } else {
            self.provider = MoyaProvider(session: session, plugins: plugins)
        }
    }
    
    func request<T: Decodable>(_ api: API) -> AnyPublisher<T, NetworkError> {
        return provider.requestPublisher(api)
            .tryMap { response in
                guard let data = try? JSONDecoder().decode(T.self, from: response.data)
                else {
                    throw NetworkError.parsingFailed
                }
                return data
            }
            .mapError { error in
                if let moyaError = error as? MoyaError,
                   let statusCode = moyaError.response?.statusCode {
                    if statusCode >= 429 {
                        return NetworkError.serverError
                    } else {
                        return NetworkError.invalidURL
                    }
                } else {
                    return NetworkError.serverError
                }
            }
            .eraseToAnyPublisher()
    }
}
