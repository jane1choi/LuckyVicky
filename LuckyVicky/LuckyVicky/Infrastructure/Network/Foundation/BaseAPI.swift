//
//  BaseAPI.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/30/24.
//

import Foundation

import Moya

protocol BaseAPI: TargetType {
    var urlPath: String { get }
    var parameters: [String: Any]? { get }
}

extension BaseAPI {
    
    var baseURL: URL {
        return URL(string: NetworkEnvironment.baseURL)!
    }
    
    var path: String {
        return urlPath
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return NetworkEnvironment.HTTPHeaderFields.default
        }
    }
    
    var task: Task {
        if let parameters = parameters {
            if method == .post {
                return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
            } else {
                return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            }
        }
        return .requestPlain
    }
}
