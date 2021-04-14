//
//  MiddleDetailReactor.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/14.
//

import RxFlow
import RxCocoa
import ReactorKit

final class MiddleDetailReactor: Reactor, Stepper {
    
    // MARK: Stepper
    
    var steps: PublishRelay<Step> = .init()
    
    // MARK: Events
    
    enum Action {
        case dismissButtonDidTap
    }
    
    enum Mutation {
        
    }
    
    struct State {
        
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

extension MiddleDetailReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .dismissButtonDidTap:
            steps.accept(SampleStep.dismiss)
            return .empty()
        }
    }
}

// MARK: Reduce

extension MiddleDetailReactor {
    //    func reduce(state: State, mutation: Mutation) -> State {
    //        var newState = state
    //        switch mutation {
    //        case :
    //        }
    //        return newState
    //    }
}

// MARK: Method

private extension MiddleDetailReactor {
} 
