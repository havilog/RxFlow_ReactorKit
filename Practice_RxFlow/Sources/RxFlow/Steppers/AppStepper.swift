//
//  AppStepper.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import Foundation

import RxFlow
import RxCocoa
import RxSwift

struct AppStepper: Stepper {
    let steps: PublishRelay<Step> = .init()
    private let provider: ServiceProviderType
    private let disposeBag: DisposeBag = .init()
    
//    var initialStep: Step {
//        return SampleStep.loginIsRequired
//    }
    
    init(provider: ServiceProviderType) {
        self.provider = provider
    }
    
    func readyToEmitSteps() {
        provider.loginService.didLoginObservable
            .map { $0 ? SampleStep.loginIsCompleted : SampleStep.loginIsRequired }
            .bind(to: steps)
            .disposed(by: disposeBag)
    }
}
