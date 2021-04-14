//
//  SampleStep.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import RxFlow

enum SampleStep: Step {
    // Global
    case alert(message: String)
    
    // Login
    case loginIsRequired
    case loginIsCompleted
    
    // Main
    case mainTabBarIsRequired
    
    // Home
    case homeIsRequired
    case homeItemIsPicked(withID: String)
    
    // Middle
    case middleIsRequired
    case middleIsRequiredAgain
    case middleDetailIsRequired
    
    // Setting
    case settingIsRequired
    case settingAndAlertIsRequired(message: String)
}
