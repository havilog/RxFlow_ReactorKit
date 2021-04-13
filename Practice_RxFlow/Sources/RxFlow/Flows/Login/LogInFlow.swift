//
//  LogInFlow.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import UIKit

import RxFlow

final class LoginFlow: Flow {

    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController: UINavigationController = .init()
    private let provider: ServiceProviderType
    
    init(with services: ServiceProviderType) {
        self.provider = services
    }
    
    deinit {
        print("\(type(of: self)): \(#function)")
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step.asSampleStep else { return .none }
        
        switch step {
        case .loginIsRequired:
            return coordinateToLogin()
            
        /// Login Flow를 dissmiss 시키고 AppFlow로 이동해 mainTabBarIsRequired Step을 호출한다.
        case .loginIsCompleted:
            return .end(forwardToParentFlowWithStep: SampleStep.mainTabBarIsRequired)
            
        default:
            return .none
        }
    }
    
    private func coordinateToLogin() -> FlowContributors {
        let reactor = LoginReactor(provider: provider)
        let vc = LoginVC(with: reactor)
        self.rootViewController.pushViewController(vc, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: vc,
                                                 withNextStepper: reactor))
    }
}
