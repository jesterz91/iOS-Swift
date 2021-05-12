//
//  MyPage.swift
//  FruitMart
//
//  Created by lee on 2021/05/12.
//

import SwiftUI

struct MyPage: View {
    var body: some View {
        NavigationView {
            Form {
                orderInfoSection
            }
            .navigationBarTitle("마이페이지")
        }
    }
    
    var orderInfoSection: some View {
        Section(header: Text("주문정보").fontWeight(.medium)) {
            NavigationLink(
                destination: OrderListView()) {
                    Text("주몬 목록")
                }
            .frame(height: 44)
        }
    }
}

struct MyPage_Previews: PreviewProvider {
    static var previews: some View {
        MyPage()
    }
}
