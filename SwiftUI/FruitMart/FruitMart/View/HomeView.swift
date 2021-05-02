//
//  ContentView.swift
//  FruitMart
//
//  Created by lee on 2021/05/02.
//

import SwiftUI

struct HomeView: View {

    private let products: [Product] = Store.products

    var body: some View {

        VStack {
            ProductRow(product: products[0])
            ProductRow(product: products[1])
            ProductRow(product: products[2])
        }
        .padding(.horizontal, 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
