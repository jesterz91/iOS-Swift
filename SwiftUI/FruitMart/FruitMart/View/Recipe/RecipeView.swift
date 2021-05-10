//
//  RecipeView.swift
//  FruitMart
//
//  Created by lee on 2021/05/11.
//

import SwiftUI

struct RecipeView: View {

    @State private var currentIndex = 0

    private let recipes: [Recipe] = Recipe.samples()

    var body: some View {
        VStack {
            title
            Spacer()
            recipePicker
            Spacer()
            recipeName
            recipeIndicator
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal)
        .padding(.bottom, 30)
        .padding(.top, 80)
        .background(backgroundGradient)
        .edgesIgnoringSafeArea(.top)
    }

    var title: some View {
        VStack {
            Text("과일을 활용한 \n 신나는 요리")
                .font(.system(size: 42))
                .fontWeight(.thin)
                .foregroundColor(.white)
                .padding(.vertical)
            
            Text("토마토와 함께하는 금주의 레시피")
                .font(.headline)
                .fontWeight(.thin)
                .foregroundColor(.white)
        }
    }

    var recipePicker: some View {
        HStack {
            Button(action: { self.changeIndex(-1) }, label: {
                Text("<")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            })

            Spacer()

            ResizedImage(recipes[currentIndex].imageName, contentMode: .fit)
                .padding(.horizontal)

            Spacer()

            Button(action: { self.changeIndex(1) }, label: {
                Text(">")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            })
        }
    }

    var recipeName: some View {
        Text(recipes[currentIndex].name)
            .font(.headline)
            .fontWeight(.medium)
            .foregroundColor(.white)
            .animation(nil)
    }

    var recipeIndicator: some View {
        GeometryReader {
            Rectangle()
                .fill(Color.white.opacity(0.4))
                .frame(width: $0.size.width)
                .overlay(self.currentIndicator(proxy: $0), alignment: .leading)
        }
        .frame(height: 2)
        .padding(.top)
        .padding(.bottom, 32)
        .animation(.easeInOut(duration: 0.6))
    }

    var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color(hex: "#f56161"), Color(hex: "#fc9c79")]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    private func changeIndex(_ num: Int) {
        withAnimation(.easeInOut(duration: 0.4)) {
            currentIndex = (currentIndex + recipes.count + num) % recipes.count
        }
    }

    private func currentIndicator(proxy: GeometryProxy) -> some View {
        let width = proxy.size.width / CGFloat(recipes.count)
        return Color(hex: "#fffa77")
            .frame(width: width)
            .offset(x: width * CGFloat(currentIndex), y: 0)
    }
}

struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}
