//
//  MainVM.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/08.
//

import Foundation

import RxFlow
import RxCocoa
import ReactorKit

final class HomeReactor: Reactor, Stepper {
    var steps: PublishRelay<Step> = .init()
    
    // MARK: Events
    
    enum Action {
    }
    
    enum Mutation {
    }
    
    struct State {
        
    }
    
    // MARK: Properties
    
    let initialState: State
    let provider: ServiceProviderType
    
    init(with provider: ServiceProviderType) {
        initialState = State()
        self.provider = provider
        
    }
}

// MARK: Mutation

extension HomeReactor {
//    func mutate(action: Action) -> Observable<Mutation> {
//        switch action {
//        case :
//        }
//    }
}

// MARK: Reduce

extension HomeReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        //        switch mutation {
        //        case :
        //        }
        
        return newState
    }
}

// MARK: Method

private extension HomeReactor {
} 
