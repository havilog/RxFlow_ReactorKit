//
//  SampleStep.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import RxFlow

enum SampleStep: Step {
    // Login
    case loginIsRequired
    case userIsLoggedIn
    
    // Main
    case mainTabBarIsRequired
    
    // Home
    case homeIsRequired
    case homeItemIsPicked(withID: String)
    
    // Middle
    case middleIsRequired
    
    // Setting
    case settingIsRequired
}
