//
//  MiddleFlow.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/09.
//

import UIKit

import RxFlow

final class MiddleFlow: Flow {
    
    // MARK: Property
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController = UINavigationController()
    private let stepper: MiddleStepper
    private let provider: ServiceProviderType
    
    // MARK: Init
    
    init(
        with services: ServiceProviderType,
        stepper: MiddleStepper
    ) {
        self.provider = services
        self.stepper = stepper
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: Navigate
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asSampleStep else { return .none }
        
        switch step {
        case .middleIsRequired:
            return coordinateToMiddle()
        
        default:
            return .none
        }
    }
}

// MARK: Method

private extension MiddleFlow {
    
    // TODO: Fix
    func coordinateToMiddle() -> FlowContributors {
        let vm = MiddleReactor(provider: provider)
        let vc = MiddleVC(with: vm)
        self.rootViewController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNext: vc))
    }
}
