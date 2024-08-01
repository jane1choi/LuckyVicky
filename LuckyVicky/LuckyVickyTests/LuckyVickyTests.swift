//
//  LuckyVickyTests.swift
//  LuckyVickyTests
//
//  Created by EUNJU on 8/1/24.
//

import XCTest

import Combine
@testable import LuckyVicky

final class LuckyVickyTests: XCTestCase {
    var sut: GptAPIService!
    var networkProvider: NetworkProvider<GptAPI>!
    var cancellables: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        networkProvider = NetworkProvider(isStub: true)
        sut = GptAPIService(provider: networkProvider)
        cancellables = []
    }

    override func tearDownWithError() throws {
        sut = nil
        networkProvider = nil
        cancellables = nil
    }
    
    func test_createChat_success() {
        let expectation = XCTestExpectation()
        
        let JSONData = GptAPI
            .createChat(systemContent: Config.wonyoungSystemContent,
                        userContent: "갑자기 비가 너무 많이 와")
            .sampleData
        let expectedResult = try? JSONDecoder().decode(GptResponseDTO.self, from: JSONData)
    
        sut.createChat(systemContent: Config.wonyoungSystemContent, userContent: "갑자기 비가 많이 와")
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Failed with error: \(error)")
                }
            }, receiveValue: { response in
                XCTAssertEqual(expectedResult?.choices[0].message.content, response.choices[0].message.content)
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 2.0)
    }
}
