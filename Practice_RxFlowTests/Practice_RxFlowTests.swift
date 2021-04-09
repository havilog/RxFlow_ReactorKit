//
//  Practice_RxFlowTests.swift
//  Practice_RxFlowTests
//
//  Created by 한상진 on 2021/04/09.
//

import XCTest

@testable import Practice_RxFlow

import RxSwift
import RxNimble
import RxTest
import RxBlocking

class Practice_RxFlowTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let observableToTest = Observable.of(10, 20, 30)
        
        do {
            let result = try observableToTest.toBlocking().first()
            
            XCTAssertEqual(result, 10)
        } catch {
            
        }
    }
    
    func test2() throws {
        let scheduler = ConcurrentDispatchQueueScheduler(qos: .background)
        let observableToTest = Observable
            .of(10, 20, 30)
            .map { $0 * 2 }
            .subscribe(on: scheduler)
            
        do {
            let result = try observableToTest.observe(on: MainScheduler.instance).toBlocking().toArray()
            
            XCTAssertEqual(result, [20, 40, 60])
        } catch {
            XCTFail(error.localizedDescription)
        }
        
    }
    
    func test3() throws {
        let scheduler = TestScheduler(initialClock: 0)
        
        let xs = scheduler.createHotObservable([
            .next(210, "1"),
            .next(230, "2"),
            .next(300, "3"),
            .completed(400)
        ])
        
        let res = scheduler.start { xs.map { $0 } }
//        let res = scheduler.start(created: 100,
//                                  subscribed: 220, 
//                                  disposed: 500, 
//                                  create: { xs.map { $0 } })
        
        let correctMsg = Recorded.events(
            .next(210, "1"),
            .next(230, "2"),
            .next(300, "3"),
            .completed(400)
        )
        
        XCTAssertEqual(res.events, correctMsg)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
