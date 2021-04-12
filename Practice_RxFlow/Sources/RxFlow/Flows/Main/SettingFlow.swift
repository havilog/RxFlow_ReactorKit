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
    private let services: ServiceProviderType
    
    // MARK: Init
    
    init(
        with services: ServiceProviderType,
        stepper: SettingStepper
    ) {
        self.services = services
        self.stepper = stepper
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    // MARK: Navigate
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? SampleStep else { return .none }
        
        switch step {
        case .settingIsRequired:
            return coordinateToSetting()
        
        default:
            return .none
        }
    }
}

// MARK: Method

private extension SettingFlow {
    
    // TODO: Fix
    func coordinateToSetting() -> FlowContributors {
        let vm = MainVM(with: services)
        let vc = MainVC(with: vm)
        self.rootViewController.setViewControllers([vc], animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: vc,
                                                 withNextStepper: vm))
    }
}
