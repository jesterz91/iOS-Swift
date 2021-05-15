//
//  MyPage.swift
//  FruitMart
//
//  Created by lee on 2021/05/12.
//

import SwiftUI

struct MyPage: View {

    @EnvironmentObject var store: Store

    @State private var pickedImage: Image = Image(systemName: "person.crop.circle")

    @State private var nickNamke: String = ""
    
    @State private var isPickerPresented: Bool = false

    private let pickerDataSources: [CGFloat] = [140, 150, 160]

    var body: some View {
        NavigationView {
            VStack {
                profileImage
                nicknameTextField
                Form {
                    orderInfoSection
                    appSettingSection
                }
            }
            .navigationBarTitle("마이페이지")
        }
        .sheet(isPresented: $isPickerPresented) {
            ImagePickerView(pickedImage: self.$pickedImage)
        }
    }

    var userInfo: some View {
        VStack {
            profileImage
        }
        .frame(maxWidth: .infinity, minHeight: 200)
        .background(Color.background)
    }

    var nicknameTextField: some View {
        TextField("낙네임", text: $nickNamke)
            .font(.system(size: 25, weight: .medium))
            .textContentType(.nickname)
            .multilineTextAlignment(.center)
            .autocapitalization(.none)
    }

    var profileImage: some View {
        pickedImage
            .resizable()
            .scaledToFill()
            .clipShape(Circle())
            .frame(width: 100, height: 100)
            .overlay(pickImageButton.offset(x: 8, y: 0), alignment: .bottomTrailing)
    }

    var pickImageButton: some View {
        Button(action: {
            isPickerPresented = true
        }) {
            Circle()
                .fill(Color.white)
                .frame(width: 32, height: 32)
                .shadow(color: .primaryShadow, radius: 2, x: 2, y: 2)
                .overlay(Image("pencil").foregroundColor(.black))
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

    var appSettingSection: some View {
        Section(header: Text("앱 설정").fontWeight(.medium)) {
            Toggle("즐겨찾는 상품 표시", isOn: $store.appSetting.showFavoriteList)
                .frame(height: 44)

            productHeightPicker
        }
    }

    var productHeightPicker: some View {
        VStack(alignment: .leading) {
            Text("상품 이미지 높이 조절")

            Picker("", selection: $store.appSetting.productRowHeight) {
                ForEach(pickerDataSources, id: \.self) {
                    Text(String(format: "%.0f", $0)).tag($0)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .frame(height: 72)
    }
}

struct MyPage_Previews: PreviewProvider {
    static var previews: some View {
        MyPage()
    }
}
