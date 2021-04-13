//
//  NavigationTest.swift
//  Practice_RxFlowTests
//
//  Created by 한상진 on 2021/04/13.
//

import XCTest

@testable import Practice_RxFlow

import RxFlow
import RxTest
import RxBlocking

class TestPresenstableFlow: Flow {
    let rootViewController = UIViewController()
    
    var root: Presentable {
        return self.rootViewController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        return .none
    }
}

class NavigationTest: XCTestCase {
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    func test_Login_Success() {
        // Given: a flow
        let testFlow = TestPresenstableFlow()
        let testScheduler = TestScheduler(initialClock: 0)
        let observer = testScheduler.createObserver(Bool.self)
        
        testScheduler.start()
        _ = testFlow.rxVisible
            .asObservable()
            .take(until: self.rx.deallocating)
            .bind(to: observer)
        
        // When: Displaying/Hiding it 3 times
        testFlow.rootViewController.viewDidAppear(false)
        testFlow.rootViewController.viewDidDisappear(false)
        
        testFlow.rootViewController.viewDidAppear(false)
        testFlow.rootViewController.viewDidDisappear(false)
        
        testFlow.rootViewController.viewDidAppear(false)
        testFlow.rootViewController.viewDidDisappear(false)
        
        // Then: rxVisible is emitted 6 times + 1 time false before being visible
        let referenceVisible = [false, true, false, true, false, true, false]
        
        XCTAssertEqual(observer.events.count, 7)
        
        var index = 0
        
        referenceVisible.forEach {
            XCTAssertEqual(observer.events[index].value.element, $0)
            index += 1
        }
    }
}
