//
//  TweetReactor.swift
//  Tweeter
//
//  Created by lee on 2021/04/17.
//

import Foundation

import ReactorKit
import RxCocoa

final class TweetReactor: Reactor {

    enum Action {
        case updateText(String)
        case submit
    }

    enum Mutation {
        case setLoading(Bool)
        case setText(String)
    }

    struct State {
        var isLoading: Bool = false
        var text: String = ""
        var remainTextCount: Int {
            TweetService.maxLength - text.count
        }
        var isTweetButtonEnable: Bool {
            (1...TweetService.maxLength).contains(text.count)
        }
    }

    let initialState: State = State()

    let tweetService: TweetService

    private let messageRelay = PublishRelay<String>()

    var messageSignal: Signal<String> {
        messageRelay.asSignal()
    }

    init(service: TweetService) {
        tweetService = service
    }

    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateText(let text):
            return Observable.just(Mutation.setText(text))
        case .submit:
            return Observable.concat([
                Observable.just(Mutation.setLoading(true)),
                submitTweet(),
                Observable.just(Mutation.setLoading(false))
            ])
        }
    }

    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setText(let text):
            newState.text = text
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }

    private func submitTweet() -> Observable<Mutation> {
        return tweetService.tweet(text: currentState.text)
            .do(onSuccess: { [weak self] _ in
                self?.messageRelay.accept("successfull")
            }, onError: { [weak self] error in
                self?.messageRelay.accept(error.localizedDescription)
            })
            .catchAndReturn(false)
            .asObservable()
            .flatMap { _ in Observable.empty() }
    }
}
