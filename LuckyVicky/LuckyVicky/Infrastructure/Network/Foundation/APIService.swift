//
//  APIService.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/30/24.
//

import Foundation

import Combine
import Moya

class APIService<API: BaseAPI>: Requestable {

    let provider = NetworkProvider<API>()
    var cancelable = Set<AnyCancellable>()
    
    func mapAPIResponse<T: Decodable>(api: API) -> AnyPublisher<T, NetworkError> {
        return provider.request(api)
            .tryMap { response in
                guard let data = try? JSONDecoder().decode(T.self, from: response.data)
                else {
                    throw NetworkError.parsingFailed
                }
                return data
            }
            .mapError { error in
                if let moyaError = error as? MoyaError {
                    // TODO: 에러 핸들링
                    print(moyaError.response?.statusCode ?? 500)
                    return NetworkError.invalidURL // 수정 필요
                } else {
                    return NetworkError.serverError
                }
            }
            .eraseToAnyPublisher()
    }
}
