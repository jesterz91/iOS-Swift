//
//  RestaurantService.swift
//  Restaurants
//
//  Created by lee on 2021/04/25.
//

import Foundation

import RxSwift

protocol RestaurantServiceProtocol {

    func fetchRestaurants() -> Single<[Restaurant]>
}

final class RestaurantService: RestaurantServiceProtocol {
    
    func fetchRestaurants() -> Single<[Restaurant]> {

        return Single.create { observer -> Disposable in

            guard let restaurantsDataAsset = NSDataAsset(name: "Restaurants") else {
                observer(.failure(NSError(domain: "", code: -1, userInfo: nil)))
                return Disposables.create()
            }

            do {
                let restaurants = try JSONDecoder().decode([Restaurant].self, from: restaurantsDataAsset.data)
                observer(.success(restaurants))
            } catch {
                observer(.failure(error))
            }

            return Disposables.create()
            
//            guard let path = Bundle.main.path(forResource: "restaurants", ofType: "json") else {
//                observer(.failure(NSError(domain: "", code: -1, userInfo: nil)))
//                return Disposables.create()
//            }

//            do {
//                let data: Data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                let restaurants: [Restaurant] = try JSONDecoder().decode([Restaurant].self, from: data)
//                observer(.success(restaurants))
//            } catch {
//                observer(.failure(error))
//            }
        }
    }
}
