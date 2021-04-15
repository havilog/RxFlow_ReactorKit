//
//  HomeDetailStepper.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/13.
//

import Foundation
import RxFlow
import RxCocoa
import ReactorKit

final class HomeDetailReactor: Reactor, Stepper {
    
    // MARK: Stepper
    
    var steps: PublishRelay<Step> = .init()
    
    // MARK: Events
    
    enum Action {
        case toMiddleDidTap
    }
    
    enum Mutation {}
    
    struct State {}
    
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

extension HomeDetailReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .toMiddleDidTap:
            steps.accept(SampleStep.middleIsRequiredAgain)
            return .empty()
        }
    }
}

// MARK: Reduce

extension HomeDetailReactor {
    //    func reduce(state: State, mutation: Mutation) -> State {
    //        var newState = state
    //        switch mutation {
    //        case :
    //        }
    //        return newState
    //    }
}

// MARK: Method

private extension HomeDetailReactor {
} 
