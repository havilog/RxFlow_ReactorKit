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
    private let stepper: SettingStepper
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
        
        default:
            return .none
        }
    }
}

// MARK: Method

private extension SettingFlow {
    
    // TODO: Fix
    func coordinateToSetting() -> FlowContributors {
        let reactor = SettingReactor(provider: provider)
        let vc = SettingVC(with: reactor)
        self.rootViewController.setViewControllers([vc], animated: true)
        return .one(flowContributor: .contribute(withNext: vc))
    }
    
    // TODO: 이렇게 하면 안됨
    func coordinateToLogin() -> FlowContributors {
        let reactor = LoginReactor(provider: provider)
        let vc = LoginVC(with: reactor)
        self.rootViewController.setViewControllers([vc], animated: true)
        
        return .one(flowContributor: .contribute(withNext: vc))
    }
}
