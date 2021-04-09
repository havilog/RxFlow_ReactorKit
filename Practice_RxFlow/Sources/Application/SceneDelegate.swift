//
//  SceneDelegate.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import UIKit

import RxFlow

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: FlowCoordinator = .init()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene) 
        self.window = window
        
        let provider: ServiceProviderType = ServiceProvider()
        let appFlow = AppFlow(with: window, and: provider)
        
        coordinator.coordinate(flow: appFlow, with: AppStepper())
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

