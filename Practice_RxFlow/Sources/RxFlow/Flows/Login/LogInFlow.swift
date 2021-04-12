//
//  LogInFlow.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import UIKit

import RxFlow

final class LoginFlow: Flow {
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let provider: ServiceProviderType
    
    init(with services: ServiceProviderType) {
        self.provider = services
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SampleStep else { return .none }
        
        switch step {
        case .loginIsRequired:
            return coordinateToLogin()
            
        case .mainTabBarIsRequired, .userIsLoggedIn:
            return .end(forwardToParentFlowWithStep: SampleStep.mainTabBarIsRequired)
            
        default:
            return .none
        }
    }
    
    private func coordinateToLogin() -> FlowContributors {
        let vm = LoginReactor(with: provider)
        let vc = LoginVC(with: vm)
        self.rootViewController.setViewControllers([vc], animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: vc,
                                                 withNextStepper: vm))
    }
}
