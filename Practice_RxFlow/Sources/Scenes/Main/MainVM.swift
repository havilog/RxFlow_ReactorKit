//
//  MainVM.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import Foundation

import RxFlow
import RxCocoa

struct MainVM: ViewModelType, Stepper {
    var steps: PublishRelay<Step> = .init()
    
    private let services: ServiceProviderType
    
    init(with services: ServiceProviderType) {
        self.services = services
    }
}
