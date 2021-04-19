//
//  HomeFlow.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/09.
//

import UIKit

import RxFlow
import RxRelay

struct HomeStepper: Stepper {
    let steps: PublishRelay<Step> = .init()
    
    /// do something before home is being presented
    var initialStep: Step {
        return SampleStep.homeIsRequired
    }
}

final class HomeFlow: Flow {
    
    // MARK: Property
    
    var root: Presentable {
        return self.rootViewController
    }
    
    let stepper: HomeStepper
    private let provider: ServiceProviderType
    private let rootViewController = UINavigationController()
    
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
