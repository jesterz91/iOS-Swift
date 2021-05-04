//
//  ContentView.swift
//  FruitMart
//
//  Created by lee on 2021/05/02.
//

import SwiftUI

struct HomeView: View {

    @EnvironmentObject private var store: Store

    var body: some View {
        NavigationView {
            List(store.products) { product in
                NavigationLink(destination: ProductDetailView(product: product)) {
                    ProductRow(product: product)
                }
            }.navigationBarTitle("과일마트")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: HomeView())
    }
}
