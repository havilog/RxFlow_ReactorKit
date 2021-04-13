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
    let stepper: MiddleStepper
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
            
        case .middleIsRequiredAgain:
            return coordinateToMiddleFirst()
        
        case .middleDetailIsRequired:
            return presentMiddleDetail()
        
        default:
            return .none
        }
    }
}

// MARK: Method

private extension MiddleFlow {
    
    func coordinateToMiddle() -> FlowContributors {
        let reactor = MiddleReactor(provider: provider)
        let vc = MiddleVC(with: reactor)
        self.rootViewController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, 
                                                 withNextStepper: reactor))
    }
    
    func coordinateToMiddleFirst() -> FlowContributors {
        
        if let vc = self.rootViewController.viewControllers.first as? MiddleVC,
           let reactor = vc.reactor{
            return .one(flowContributor: .contribute(withNextPresentable: vc, 
                                                     withNextStepper: reactor))
        } else {
            return coordinateToMiddle()
        }
    }
    
    func presentMiddleDetail() -> FlowContributors {
        let vc = MiddleDetailVC()
        self.rootViewController.visibleViewController?.present(vc, animated: true)
        return .none
    }
}
