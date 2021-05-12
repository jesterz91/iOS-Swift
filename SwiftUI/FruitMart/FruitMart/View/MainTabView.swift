//
//  MainTabView.swift
//  FruitMart
//
//  Created by lee on 2021/05/09.
//

import SwiftUI

struct MainTabView: View {

    private enum Tabs {
        case home, recipe, gallery, myPage
    }

    @State private var selectedTab: Tabs = .home

    var body: some View {
        TabView(selection: $selectedTab) {
            Group {
                home
                recipe
                gallery
                myPage
            }.accentColor(.primary)
        }
        .accentColor(.peach)
        .edgesIgnoringSafeArea(.top)
    }

    var home: some View {
        HomeView()
            .tag(Tabs.home)
            .tabItem(image: "house", text: "홈")
    }

    var recipe: some View {
        RecipeView()
            .tag(Tabs.recipe)
            .tabItem(image: "book", text: "레시피")
    }

    var gallery: some View {
        ImageGallery()
            .tag(Tabs.recipe)
            .tabItem(image: "photo.on.rectangle", text: "갤러리")
    }

    var myPage: some View {
        MyPage()
            .tag(Tabs.recipe)
            .tabItem(image: "person", text: "마이페이지")
    }
}

fileprivate extension View {
    
    func tabItem(image: String, text: String) -> some View {
        self.tabItem {
            Symbol(image, imageScale: .large)
                .font(.system(size: 17, weight: .light))
            Text(text)
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
