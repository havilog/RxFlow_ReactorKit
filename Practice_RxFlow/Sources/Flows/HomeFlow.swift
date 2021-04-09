//
//  HomeFlow.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import UIKit

import RxFlow

final class HomeFlow: Flow {
    private let services: ServiceProviderType
    
    private lazy var rootViewController: UINavigationController = {
        let viewController = UINavigationController()
        return viewController
    }()
    
    var root: Presentable {
        return self.rootViewController
    }
    
    init(with services: ServiceProviderType) {
        self.services = services
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SampleStep else {
            return .none
        }
        
        switch step {
        case .loginIsRequired:
            return .end(forwardToParentFlowWithStep: SampleStep.loginIsRequired)
            
        case .dashboardIsRequired, .userIsLoggedIn:
            return coordinateToHome()
        }
    }
    
    private func coordinateToHome() -> FlowContributors {
        let vm = MainVM(with: services)
        let vc = MainVC(with: vm)
        self.rootViewController.setViewControllers([vc], animated: false)
        return .one(flowContributor: .contribute(withNext: vc))
    }
}
