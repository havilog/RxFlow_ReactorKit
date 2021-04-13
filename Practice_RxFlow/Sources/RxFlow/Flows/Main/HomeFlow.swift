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
    let stepper: HomeStepper
    private let provider: ServiceProviderType
    
    // MARK: Init
    
    init(
        with services: ServiceProviderType,
        stepper: HomeStepper
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
        case .homeIsRequired:
            return coordinateToHome()
        
        case let .homeItemIsPicked(withID):
            return coordinateToHomeDetail(with: withID)
            
        case .middleIsRequiredAgain:
            return .one(flowContributor: .forwardToParentFlow(withStep: SampleStep.middleIsRequiredAgain))
            
            // end로 부르면 HomeFlow자체가 deinit되므로 .one으로 불러야하네
//            return .end(forwardToParentFlowWithStep: SampleStep.middleIsRequired)
        
        default:
            return .none
        }
    }
}

// MARK: Method

private extension HomeFlow {
    func coordinateToHome() -> FlowContributors {
        let reactor = HomeReactor(provider: provider)
        let vc = HomeVC(with: reactor)
        
        // push하면 안됨 (다른 Flow에서 왔을 경우)
        self.rootViewController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, 
                                                 withNextStepper: reactor))
    }
    
    func coordinateToHomeDetail(with ID: String) -> FlowContributors {
        let reactor = HomeDetailReactor(provider: provider)
        let vc = HomeDetailVC(with: reactor, title: ID)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc, 
                                                 withNextStepper: reactor))
    }
}
