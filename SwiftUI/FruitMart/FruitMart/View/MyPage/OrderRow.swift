//
//  OrderRow.swift
//  FruitMart
//
//  Created by lee on 2021/05/12.
//

import SwiftUI

struct OrderRow: View {
    
    let order: Order
    
    var body: some View {
        HStack {
            ResizedImage(order.product.imageName)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                Text(order.product.name)
                    .font(.headline)
                    .fontWeight(.medium)
                
                Text("₩\(order.price)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .frame(height: 100)
    }
}
