//
//  AppStepper.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import Foundation

import RxFlow
import RxSwift
import RxRelay

final class AppStepper: Stepper {
    let steps: PublishRelay<Step> = .init()
    private var disposeBag = DisposeBag()
    
    init() {}
    
    var initialStep: Step {
        return SampleStep.loginIsRequired
    }
}
