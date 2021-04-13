//
//  SettingFlow.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/09.
//

import UIKit

import RxFlow

final class SettingFlow: Flow {
    
    // MARK: Property
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController = UINavigationController()
    let stepper: SettingStepper
    private let provider: ServiceProviderType
    
    // MARK: Init
    
    init(
        with services: ServiceProviderType,
        stepper: SettingStepper
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
        case .settingIsRequired:
            return coordinateToSetting()
        
        case .loginIsRequired:
            return .end(forwardToParentFlowWithStep: SampleStep.loginIsRequired)
            
        case let .alert(message):
            return navigateToAlertScreen(message: message)
        
        default:
            return .none
        }
    }
}

// MARK: Method

private extension SettingFlow {
    
    func coordinateToSetting() -> FlowContributors {
        let reactor = SettingReactor(provider: provider)
        let vc = SettingVC(with: reactor)
        self.rootViewController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc,
                                                 withNextStepper: reactor))
    }
    
    func coordinateToLogin() -> FlowContributors {
        let reactor = LoginReactor(provider: provider)
        let vc = LoginVC(with: reactor)
        self.rootViewController.setViewControllers([vc], animated: true)
        
        return .one(flowContributor: .contribute(withNextPresentable: vc,
                                                 withNextStepper: reactor))
    }
    
    func navigateToAlertScreen(message: String) -> FlowContributors {
        let alert = UIAlertController(title: "Demo", message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Cancel", style: .cancel))
        rootViewController.present(alert, animated: true)
        return .none
    }
}
