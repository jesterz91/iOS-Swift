//
//  ProductRow.swift
//  FruitMart
//
//  Created by lee on 2021/05/03.
//

import SwiftUI

struct ProductRow: View {

    let product: Product

    @State private var willAppear: Bool = false

    @EnvironmentObject private var store: Store

    var body: some View {
        HStack {
            productImage
            productDescription
        }
        .frame(height: store.appSetting.productRowHeight)
        .background(Color.primary.colorInvert())
        .cornerRadius(6)
        .shadow(color: .primaryShadow, radius: 1, x: 2, y: 2)
        .padding(.vertical, 8)
        .opacity(willAppear ? 1 : 0)
        .animation(.easeInOut(duration: 0.4))
        .onAppear { self.willAppear = true }
        .contextMenu(menuItems: {
            contextMenu
        })
    }
}

private extension ProductRow {

    var productImage: some View {
        Image(product.imageName)
            .resizable()
            .scaledToFill()
            .frame(width: 140)
            .clipped()
    }

    var productDescription: some View {
        VStack(alignment: .leading) {
            Text(product.name)
                .font(.headline)
                .fontWeight(.medium)
                .padding(.bottom, 6)

            Text(product.description)
                .font(.footnote)
                .foregroundColor(.secondaryText)

            Spacer()

            footer
        }
        .padding([.leading, .bottom], 12)
        .padding([.top, .trailing])
    }

    var footer: some View {
        HStack(spacing: 0) {

            Text("₩").font(.footnote)
                + Text("\(product.price)").font(.headline)

            Spacer()

            FavoriteButton(product: product)

            Image(systemName: "cart")
                .foregroundColor(.peach)
                .frame(width: 32, height: 32)
        }
    }

    var contextMenu: some View {
        VStack {
            Button(action: {
                print("Favorite")
            }, label: {
                Text("좋아요")
                Symbol(self.product.isFavorite ? "heart.fill" : "heart")
            })

            Button(action: {
                print("order")
            }, label: {
                Text("구매하기")
                Symbol("cart")
            })
        }
    }
}

struct ProductRow_Previews: PreviewProvider {

    static var previews: some View {

        let product = Product(
            name: "유기농 아보카도",
            imageName: "avocado",
            price: 2900,
            description: "미네랄도 풍부하고, 요리 장식과 소스로도 좋은 아보카도 입니다.",
            isFavorite: false
        )

        Group {
            ForEach(Store().products) {
                ProductRow(product: $0)
            }
            ProductRow(product: product)
                .preferredColorScheme(.dark)
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
