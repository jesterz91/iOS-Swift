//
//  Symbol.swift
//  FruitMart
//
//  Created by lee on 2021/05/05.
//

import SwiftUI

struct Symbol: View {

    private let systemName: String
    private let imageScale: Image.Scale
    private let color: Color?

    init(_ systemName: String, imageScale: Image.Scale = .medium, color: Color? = nil) {
        self.systemName = systemName
        self.imageScale = imageScale
        self.color = color
    }

    var body: some View {
        Image(systemName: systemName)
            .imageScale(imageScale)
            .foregroundColor(color)
    }
}

struct Symbol_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Symbol("heart.fill")
                .previewLayout(.sizeThatFits)
            Symbol("heart.fill", imageScale: .large, color: .red)
                .previewLayout(.sizeThatFits)
        }
    }
}
