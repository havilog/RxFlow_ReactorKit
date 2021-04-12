//
//  HomeFlow.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import UIKit

import RxFlow

final class MainFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let services: ServiceProviderType
    let rootViewController: UITabBarController = .init()
    
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
            
        case .mainTabBarIsRequired, .userIsLoggedIn:
            return coordinateToMainTabBar()
        
        default:
            return .none
        }
    }
    
    private func coordinateToMainTabBar() -> FlowContributors {

        let homeStepper: HomeStepper = .init()
        let middleStepper: MiddleStepper = .init()
        let settingStepper: SettingStepper = .init()
        
        let homeFlow: HomeFlow = .init(with: self.services, stepper: homeStepper)
        let middleFlow: MiddleFlow = .init(with: self.services, stepper: middleStepper)
        let settingFlow: SettingFlow = .init(with: self.services, stepper: settingStepper)
        
        Flows.use(
            homeFlow, middleFlow, settingFlow, 
            when: .created
        ) { [unowned self] (root1: UINavigationController, root2: UINavigationController, root3: UINavigationController) in
            
            let homeImage: UIImage? = UIImage(named: "home")
            let middleImage: UIImage? = UIImage(named: "middle")
            let settingImage: UIImage? = UIImage(named: "setting")
            
            let homeItem: UITabBarItem = .init(title: "Home", image: homeImage, selectedImage: nil)
            let middleItem: UITabBarItem = .init(title: "Middle", image: middleImage, selectedImage: nil)
            let settingItem: UITabBarItem = .init(title: "Setting", image: settingImage, selectedImage: nil)
            
            root1.tabBarItem = homeItem
            root2.tabBarItem = middleItem
            root3.tabBarItem = settingItem
            
            self.rootViewController.setViewControllers([root1, root2, root3], animated: true)
        }
        
        return .multiple(flowContributors: [
            // CompositeStepper(steppers: [OneStepper(withSingleStep: DemoStep.moviesAreRequired), wishlistStepper]
            .contribute(withNextPresentable: homeFlow, 
                        withNextStepper: homeStepper),
            // OneStepper(withSingleStep: DemoStep.moviesAreRequired) 
            .contribute(withNextPresentable: middleFlow, 
                        withNextStepper: middleStepper),
            .contribute(withNextPresentable: settingFlow, 
                        withNextStepper: settingStepper)
        ])
    }
}
