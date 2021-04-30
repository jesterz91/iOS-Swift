//
//  Reusable.swift
//  iTunesSearch
//
//  Created by lee on 2021/04/30.
//

import Foundation

protocol Reusable {

    static var identifier: String { get }
}

extension Reusable {

    static var identifier: String {
        return String(describing: Self.self)
    }
}
