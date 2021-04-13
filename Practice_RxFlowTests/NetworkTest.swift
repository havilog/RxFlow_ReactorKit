//
//  HomeReactorTest.swift
//  Practice_RxFlowTests
//
//  Created by 한상진 on 2021/04/13.
//

import XCTest

@testable import Practice_RxFlow

import RxSwift
import RxNimble
import RxTest
import RxBlocking

class MockURLSessionDataTask: URLSessionDataTask {
    override init() { }
    var resumeDidCall: () -> Void = {}

    override func resume() {
        resumeDidCall()
    }
}

class MockURLSession: URLSessionProtocol {
    var makeRequestFail = false
    init(makeRequestFail: Bool = false) {
        self.makeRequestFail = makeRequestFail
    }
    
    var sessionDataTask: MockURLSessionDataTask?
    
    // dataTask 구현
    func dataTask(
        with request: URLRequest, 
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask {
        // 성공 callBack response
        let successResponse = HTTPURLResponse(url: JokesAPI.randomJokes.url,
                                              statusCode: 200,
                                              httpVersion: "2",
                                              headerFields: nil)
        
        // 실패 callBack response
        let failureResponse = HTTPURLResponse(url: JokesAPI.randomJokes.url,
                                              statusCode: 410,
                                              httpVersion: "2",
                                              headerFields: nil)
        
        let sessionDataTask = MockURLSessionDataTask()
        
        // resume()이 호출되면 completionHandler() 가 호출
        sessionDataTask.resumeDidCall = {
            if self.makeRequestFail {
                completionHandler(nil, failureResponse, nil)
            } else {
                completionHandler(JokesAPI.randomJokes.sampleData, successResponse, nil)
            }
        }
        
        self.sessionDataTask = sessionDataTask
        return sessionDataTask
    }
}

class NetworkTest: XCTestCase {
    
    var sut: NetworkManager!
    
    override func setUpWithError() throws {
        sut = .init(session: MockURLSession())
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func test_fetchRandomJoke_Success() {
        let expectation = XCTestExpectation()
        let response = try? JSONDecoder().decode(JokeReponse.self, from: JokesAPI.randomJokes.sampleData)
        
        sut.fetchRandomJoke { result in
            switch result {
            case let .success(joke):
                XCTAssertEqual(joke.id, response?.value.id)
                
            case .failure:
                XCTFail()
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
    
    func test_fetchRandomJoke_failure() {
        sut = .init(session: MockURLSession(makeRequestFail: true))
        let expectation = XCTestExpectation()
        
        sut.fetchRandomJoke { result in
            switch result {
            case .success:
                XCTFail()
                
            case let .failure(error):
                XCTAssertEqual(error.localizedDescription, "unknownError")
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2)
    }
}
