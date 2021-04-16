//
//  MainReactor.swift
//  Counter
//
//  Created by lee on 2021/04/16.
//

import Foundation

import ReactorKit

final class MainReactor: Reactor {

    enum Action {
        case increase
        case decrease
    }

    enum Mutation {
        case increaseValue
        case decreaseValue
        case setLoading(isLoading: Bool)
    }

    struct State {
        var value: Int = 0
        var isLoading: Bool = false
    }

    let initialState: State = State()

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .increase:
            return Observable.concat([
                Observable.just(Mutation.setLoading(isLoading: true)),
                Observable.just(Mutation.increaseValue).delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(isLoading: false))
            ])
        case .decrease:
            return Observable.concat([
                Observable.just(Mutation.setLoading(isLoading: true)),
                Observable.just(Mutation.decreaseValue).delay(.seconds(1), scheduler: MainScheduler.instance),
                Observable.just(Mutation.setLoading(isLoading: false))
            ])
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .increaseValue:
            newState.value += 1
        case .decreaseValue:
            newState.value -= 1
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
}
