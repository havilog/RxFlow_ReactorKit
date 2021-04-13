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
    
    // MARK: Stepper
    
    var steps: PublishRelay<Step> = .init()
    
    // MARK: Events
    
    enum Action {
        case loadData
        case itemSelected(title: String)
    }
    
    enum Mutation {
        case setMeta(_ meta: MetaData)
        case setMovies(_ movies: [Movie])
        case setError(error: Error)
    }
    
    struct State {
        var meta: MetaData?
        var movies: [Movie]?
    }
    
    // MARK: Properties
    
    let initialState: State
    private let provider: ServiceProviderType
    
    let errorSubject: PublishSubject<Error> = .init()
    
    init(with provider: ServiceProviderType) {
        initialState = State()
        self.provider = provider
    }
}

// MARK: Mutation

extension HomeReactor {
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadData:
            return fetchMovieResult()
        
        case let .itemSelected(title):
            steps.accept(SampleStep.homeItemIsPicked(withID: title))
            
            return .empty()
        }
    }
}

// MARK: Reduce

extension HomeReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        
        switch mutation {
        case let .setMeta(meta):
            newState.meta = meta
            
        case let .setMovies(movies):
            newState.movies = movies
            
        case let .setError(error):
            errorSubject.onNext(error)
        }
        
        return newState
    }
}

// MARK: Method

private extension HomeReactor {
    func fetchMovieResult() -> Observable<Mutation> {
        let fetchResult = provider.networkService.fetchMovies()
        
        switch fetchResult {
        case let .success(result):
            return .of(.setMeta(result.metaData), .setMovies(result.movie))
            
        case let .failure(error):
            return .just(.setError(error: error))
        }
    }
} 
