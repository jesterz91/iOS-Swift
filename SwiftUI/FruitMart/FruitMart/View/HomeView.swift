//
//  ContentView.swift
//  FruitMart
//
//  Created by lee on 2021/05/02.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var store: Store

    @State private var showingFavoriteImage: Bool = true

    var body: some View {
        NavigationView {
            VStack {
                if showFavorite {
                    favoriteProducts
                }
                darkerDivider
                productList
            }
        }
    }

    private var favoriteProducts: some View {
        FavoriteProductScrollView(showingImage: $showingFavoriteImage)
            .padding(.vertical, 8)
    }

    private var darkerDivider: some View {
        Color.primary
            .opacity(0.3)
            .frame(maxWidth: .infinity, maxHeight: 1)
    }

    private var productList: some View {
        List(store.products) { product in
            NavigationLink(destination: ProductDetailView(product: product)) {
                ProductRow(product: product)
            }
        }.navigationBarTitle("과일마트")
    }

    private var showFavorite: Bool {
        !store.products.filter({ $0.isFavorite }).isEmpty
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: HomeView())
    }
}
