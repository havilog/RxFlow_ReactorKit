//
//  MiddleReactor.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/12.
//

import RxFlow
import RxCocoa
import ReactorKit

final class MiddleReactor: Reactor, Stepper {
    
    // MARK: Stepper
    
    var steps: PublishRelay<Step> = .init() 
    
    // MARK: Events
    enum Action {
        case detailButtonDidTap
        case twoFlowButtonDidTap
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
extension MiddleReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .detailButtonDidTap:
            steps.accept(SampleStep.middleDetailIsRequired)
            return .empty()
            
        case .twoFlowButtonDidTap:
            steps.accept(SampleStep.settingAndAlertIsRequired(message: "This is from middle twoFlowButton"))
            return .empty()
        }
    }
}

// MARK: Reduce
extension MiddleReactor {
//    func reduce(state: State, mutation: Mutation) -> State {
//        var newState = state
        
        //        switch mutation {
        //        case :
        //        }
        
//        return newState
//    }
}

// MARK: Method
private extension MiddleReactor {
} 
