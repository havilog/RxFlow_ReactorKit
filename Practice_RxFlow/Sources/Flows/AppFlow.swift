//
//  AppFlow.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//


import UIKit

import RxFlow

// Flow는 AnyObject를 준수하므로 class로 선언해주어야 한다.
final class AppFlow: Flow {
    private let rootWindow: UIWindow
    private let services: ServiceProviderType
    
    init(
        with window: UIWindow,
        and services: ServiceProviderType
    ) {
        self.rootWindow = window
        self.services = services
    }
    
    var root: Presentable {
        return self.rootWindow
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SampleStep else {
            return FlowContributors.none
        }
        
        switch step {
        case .loginIsRequired:
            return coordinateToLoginVC()
            
        case .userIsLoggedIn, .dashboardIsRequired:
            return coordinateToMainVC()
        }
    }
    
    private func coordinateToLoginVC() -> FlowContributors {
//        if let rootVC = rootWindow.rootViewController {
//            rootVC.dismiss(animated: false)
//        }
        
        let loginFlow = LoginFlow(with: services)
        
        Flows.use(loginFlow, when: .created) { [unowned self] root in
            rootWindow.rootViewController = root
        }
        
        let nextStep = OneStepper(withSingleStep: SampleStep.loginIsRequired)
        
        return .one(flowContributor: .contribute(withNextPresentable: loginFlow, 
                                                 withNextStepper: nextStep))
    }
    
    private func coordinateToMainVC() -> FlowContributors {
        let homeFlow = MainFlow(with: services)
        
        Flows.use(homeFlow, when: .created) { [unowned self] root in
            rootWindow.rootViewController = root
        }
        
        let nextStep = OneStepper(withSingleStep: SampleStep.dashboardIsRequired)
        
        return .one(flowContributor: .contribute(withNextPresentable: homeFlow,
                                                 withNextStepper: nextStep))
    }
    
}
