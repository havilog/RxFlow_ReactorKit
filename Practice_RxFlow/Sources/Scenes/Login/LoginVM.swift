//
//  LoginVM.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import Foundation

import RxFlow
import RxSwift
import RxCocoa

struct LoginVM: ViewModelType, Stepper {
    var steps: PublishRelay<Step> = .init()
    
    struct Input {
        let buttonTapped: Observable<Void>
    }
    
    struct Output {
        let changeText: Driver<String>
    }
    
    private let services: ServiceProviderType
    
    init(with services: ServiceProviderType) {
        self.services = services
    }
    
    func transform(input: Input) -> Output {
        let changeText = input.buttonTapped
            .map { 
                return "test"
            }
            .asDriver(onErrorJustReturn: "")
        
        return Output(changeText: changeText)
    }
}
