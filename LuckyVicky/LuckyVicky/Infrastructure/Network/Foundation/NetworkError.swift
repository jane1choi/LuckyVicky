//
//  NetworkError.swift
//  LuckyVicky
//
//  Created by EUNJU on 7/30/24.
//

/// 네트워크 통신에서 공통적으로 발생하는 에러
enum NetworkError: Error {
    case invalidURL
    case unauthorized
    case parsingFailed
    case serverError
}
