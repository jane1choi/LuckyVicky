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
    var body: Encodable? { get }
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
        if let parameters {
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
        
        if let body {
            return .requestJSONEncodable(body)
        }
        
        return .requestPlain
    }
}
