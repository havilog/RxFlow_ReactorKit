//
//  LoginVM.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import Foundation

import RxFlow
import ReactorKit

final class LoginReactor: Reactor {
    
    // MARK: Events
    
    enum Action {
        case loginButtonDidTap
    }
    
    enum Mutation {
        case coordinateToMainTabBar
    }
    
    struct State {
        var step: Step = SampleStep.loginIsRequired
    }
    
    // MARK: Properties
    
    let initialState: State
    let provider: ServiceProviderType
    
    init(provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }
}

// MARK: Mutation

extension LoginReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loginButtonDidTap:
            provider.loginService.setUserLogin()
            return .just(.coordinateToMainTabBar)
        }
    }
}

// MARK: Reduce

extension LoginReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case .coordinateToMainTabBar:
            newState.step = SampleStep.loginIsCompleted
        }
        
        return newState
    }
}

// MARK: Method

private extension LoginReactor {
} 
