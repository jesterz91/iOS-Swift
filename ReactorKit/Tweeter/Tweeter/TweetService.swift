//
//  TweetService.swift
//  Tweeter
//
//  Created by lee on 2021/04/17.
//

import UIKit

import RxSwift

final class TweetService {

    static let maxLength = 140

    private let scheduler = SerialDispatchQueueScheduler(internalSerialQueueName: "tweet")

    private var lastTweetedText: String? = nil

    func tweet(text: String) -> Single<Bool> {

        guard lastTweetedText != text else {
            return Single.error(TweetError.duplicated)
                         .delay(.seconds(1), scheduler: scheduler)
                         .do(onError: { _ in NSLog("Error: \(text)") })
        }

        lastTweetedText = text

        return Single.just(true)
                     .delay(.seconds(1), scheduler: scheduler)
                     .do(onSuccess: { _ in NSLog("Succeeded: \(text)") })
    }
}

enum TweetError: LocalizedError {
    case duplicated

    var errorDescription: String? {
        return "Your tweet is duplicated with the last one."
    }
}
