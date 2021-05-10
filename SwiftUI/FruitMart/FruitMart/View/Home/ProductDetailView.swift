//
//  ProductDetailView.swift
//  FruitMart
//
//  Created by lee on 2021/05/03.
//

import SwiftUI

struct ProductDetailView: View {

    let product: Product

    @State private var quantity: Int = 1

    @State private var showingAlert: Bool = false

    @EnvironmentObject private var store: Store

    @State private var willAppear: Bool = false

    var body: some View {
        VStack(spacing: 0) {
            if willAppear {
                productImage
            }
            orderView
        }
        .edgesIgnoringSafeArea(.top)
        .alert(isPresented: $showingAlert) { confirmAlert }
        .onAppear { self.willAppear = true }
    }

    var confirmAlert: Alert {
        Alert(
            title: Text("주문 확인"),
            message: Text("\(product.name)을(를) \(quantity)개 구매하시겠습니까?"),
            primaryButton: .default(Text("확인"), action: {
                store.placeOrder(product: product, quantity: quantity)
                dump(store.orders)
            }),
            secondaryButton: .cancel(Text("취소"))
        )
    }
}

private extension ProductDetailView {

    var productImage: some View {
        let effect = AnyTransition.scale.combined(with: .opacity)
            .animation(.easeInOut(duration: 0.4).delay(0.05))
        return GeometryReader { _ in
            ResizedImage(product.imageName)
        }
        .transition(effect)
    }

    var orderView: some View {
        GeometryReader {
            VStack(alignment: .leading) {
                productDescription
                Spacer()
                priceInfo
                placeOrderButton
            }
            .padding(32)
            .frame(height: $0.size.height + 10)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: -5)
        }
    }

    var productDescription: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(product.name)
                    .font(.largeTitle)
                    .foregroundColor(.black)

                Spacer()

                FavoriteButton(product: product)
            }

            Text(splitText(product.description))
                .foregroundColor(.secondaryText)
                .fixedSize()
        }
    }

    var priceInfo: some View {
        let price = quantity * product.price
        return HStack {
            (Text("₩") + Text("\(price)").font(.title)).fontWeight(.medium)
            Spacer()
            QuantitySelector(quantity: $quantity)
        }
        .foregroundColor(.black)
    }

    var placeOrderButton: some View {
        Button(action: {
            self.showingAlert = true
        }) {
            Capsule()
                .fill(Color.peach)
                .frame(maxWidth: .infinity, minHeight: 30, maxHeight: 55)
                .overlay(Text("주문하기")
                            .font(.system(size: 20)).fontWeight(.medium)
                            .foregroundColor(Color.white))
        }.buttonStyle(ShirinkButtonStyle())
    }

    func splitText(_ text: String) -> String {
        guard !text.isEmpty else { return text }

        let centerIdx = text.index(text.startIndex, offsetBy: text.count / 2)
        let centerSpaceIdx = text[..<centerIdx].lastIndex(of: " ")
            ?? text[centerIdx...].firstIndex(of: " ")
            ?? text.index(before: text.endIndex)

        let afterSpaceIdx = text.index(after: centerSpaceIdx)

        let lhsString = text[..<afterSpaceIdx].trimmingCharacters(in: .whitespaces)
        let rhsString = text[afterSpaceIdx...].trimmingCharacters(in: .whitespaces)

        return String(lhsString + "\n" + rhsString)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Preview(source: ProductDetailView(product: Store().products[0]))
            Preview(source: ProductDetailView(product: Store().products[1]), devices: [.iPhone11Pro], displayDarkMode: false)
        }
    }
}
