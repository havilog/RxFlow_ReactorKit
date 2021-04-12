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

extension SettingReactor {
    //    func mutate(action: Action) -> Observable<Mutation> {
    //        switch action {
    //        case :
    //        }
    //    }
}

// MARK: Reduce

extension SettingReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        //        var newState = state
        
        //        switch mutation {
        //        case :
        //        }
        
        //        return newState
    }
}

// MARK: Method

private extension SettingReactor {
} 
