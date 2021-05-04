//
//  FavoriteButton.swift
//  FruitMart
//
//  Created by lee on 2021/05/05.
//

import SwiftUI

struct FavoriteButton: View {

    @EnvironmentObject private var store: Store

    let product: Product

    private var imageName: String {
        product.isFavorite ? "heart.fill" : "heart"
    }

    var body: some View {
        Image(systemName: imageName)
            .imageScale(.large)
            .foregroundColor(.peach)
            .frame(width: 32, height: 32)
            .onTapGesture { self.store.toggleFavorite(of: self.product) }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(product: Store().products[0])
    }
}
