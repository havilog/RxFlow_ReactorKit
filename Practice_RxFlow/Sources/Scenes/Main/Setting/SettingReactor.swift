//
//  SettingReactor.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/12.
//

import RxFlow
import RxCocoa
import ReactorKit

final class SettingReactor: Reactor, Stepper {
    
    // MARK: Stepper
    
    var steps: PublishRelay<Step> = .init() 
    
    // MARK: Events
    
    enum Action {
        case logoutButtonDidTap
    }
    
    enum Mutation {
        case coordinateToLogin
    }
    
    struct State {
        var step: Step? = nil
    }
    
    // MARK: Properties
    
    let initialState: State
    let provider: ServiceProviderType
    
    // MARK: Initializers
    
    init(provider: ServiceProviderType) {
        initialState = State()
        self.provider = provider
    }
}

// MARK: Mutation

extension SettingReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .logoutButtonDidTap:
            provider.loginService.setUserLogout()
            return .just(.coordinateToLogin)
        }
    }
}

// MARK: Reduce

extension SettingReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = initialState
        
        switch mutation {
        case .coordinateToLogin:
            newState.step = SampleStep.loginIsRequired
        }
        
        return newState
    }
}

// MARK: Method

private extension SettingReactor {
} 
