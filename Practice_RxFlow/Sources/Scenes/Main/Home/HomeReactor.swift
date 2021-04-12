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

final class HomeReactor: Reactor {
    // MARK: Events
    
    enum Action {
        case loadData
        case itemSelected(title: String)
    }
    
    enum Mutation {
        case setMeta(_ meta: MetaData)
        case setMovies(_ movies: [Movie])
        case setError(error: Error)
        
        case coordinateToHomeDetailVC(title: String)
    }
    
    struct State {
        var meta: MetaData?
        var movies: [Movie]?
        var errorResult: Error?
        var step: Step?
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
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .loadData:
            return fetchMovieResult()
            
        case let .itemSelected(title):
            return .just(.coordinateToHomeDetailVC(title: title))
        }
    }
}

// MARK: Reduce

extension HomeReactor {
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = initialState
        newState.meta = state.meta
        newState.movies = state.movies
        
        switch mutation {
        case let .setMeta(meta):
            newState.meta = meta
            
        case let .setMovies(movies):
            newState.movies = movies
            
        case let .setError(error):
            newState.errorResult = error
            
        case let .coordinateToHomeDetailVC(title):
            newState.step = SampleStep.homeItemIsPicked(withID: title)
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
