//
//  OrderListView.swift
//  FruitMart
//
//  Created by lee on 2021/05/12.
//

import SwiftUI

struct OrderListView: View {

    @EnvironmentObject var store: Store

    var body: some View {
        ZStack {
            if store.orders.isEmpty {
                emptyOrders
            } else {
                orderList
            }
        }
        .navigationBarTitle("주문 목록")
        .navigationBarItems(trailing: editButton)
    }

    var emptyOrders: some View {
        VStack(spacing: 25) {
            Image("box")
                .renderingMode(.template)
                .foregroundColor(.gray.opacity(0.4))
            
            Text("주문 내역이 없습니다.")
                .font(.headline)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
    
    var orderList: some View {
        List {
            ForEach(store.orders) {
                OrderRow(order: $0)
            }
            .onDelete(perform: store.deleteOrder(at:))
            .onMove(perform: store.moveOrder(from:to:))
        }
    }

    var editButton: some View {
        store.orders.isEmpty
            ? AnyView(EmptyView())
            : AnyView(EditButton())
    }
}
