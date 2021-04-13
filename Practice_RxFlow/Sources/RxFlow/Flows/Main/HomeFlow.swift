//
//  HomeFlow.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/09.
//

import UIKit

import RxFlow

final class HomeFlow: Flow {
    
    // MARK: Property
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController = UINavigationController()
    private let homeStepper: HomeStepper
    private let provider: ServiceProviderType
    
    // MARK: Init
    
    init(
        with services: ServiceProviderType,
        stepper: HomeStepper
    ) {
        self.provider = services
        self.homeStepper = stepper
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: Navigate
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asSampleStep else { return .none }
        
        switch step {
        case .homeIsRequired:
            return coordinateToHome()
        
        case let .homeItemIsPicked(withID):
            return coordinateToHomeDetail(with: withID)
            
        default:
            return .none
        }
    }
}

// MARK: Method

private extension HomeFlow {
    func coordinateToHome() -> FlowContributors {
        let reactor = HomeReactor(with: provider)
        let vc = HomeVC(with: reactor)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, 
                                                 withNextStepper: reactor))
    }
    
    func coordinateToHomeDetail(with ID: String) -> FlowContributors {
        let vc = HomeDetailVC(with: ID)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNext: vc))
    }
}
