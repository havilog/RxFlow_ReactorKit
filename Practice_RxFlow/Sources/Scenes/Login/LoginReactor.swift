//
//  LoginVM.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import Foundation

import RxFlow
import RxCocoa
import ReactorKit

final class LoginReactor: Reactor, Stepper {
    var steps: PublishRelay<Step> = .init()
    
    // MARK: Events
    
    enum Action {
        case buttonDidTap
    }
    
    enum Mutation {
    }
    
    struct State {
        
    }
    
    // MARK: Properties
    
    let initialState: State
    let provider: ServiceProviderType
    
    init(with provider: ServiceProviderType) {
        self.provider = provider
        initialState = State()
    }
}

// MARK: Mutation

extension LoginReactor {
//    func mutate(action: Action) -> Observable<Mutation> {
//        switch action {
//        case :
//        }
//    }
}

// MARK: Reduce

extension LoginReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        //        switch mutation {
        //        case :
        //        }
        
        return newState
    }
}

// MARK: Method

private extension LoginReactor {
} 
