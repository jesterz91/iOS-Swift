//
//  Reusable.swift
//  SnackBar
//
//  Created by lee on 2021/04/22.
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
