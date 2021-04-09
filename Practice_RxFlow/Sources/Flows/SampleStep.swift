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
    
    // Home
    case dashboardIsRequired
}
