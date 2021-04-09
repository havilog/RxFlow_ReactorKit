//
//  AppStepper.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import Foundation

import RxFlow
import RxRelay

struct AppStepper: Stepper {
    let steps: PublishRelay<Step> = .init()
    
    var initialStep: Step {
        return SampleStep.loginIsRequired
    }
}
