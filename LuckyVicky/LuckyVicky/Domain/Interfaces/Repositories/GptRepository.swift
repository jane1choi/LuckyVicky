//
//  GptRepository.swift
//  LuckyVicky
//
//  Created by EUNJU on 9/5/24.
//

import Foundation
import Combine

protocol GptRepository {
    func fetchResultData(systemContent: String, userContent: String) -> AnyPublisher<ReplyEntity, NetworkError>
}
