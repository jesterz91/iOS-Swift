//
//  ResizedImage.swift
//  FruitMart
//
//  Created by lee on 2021/05/05.
//

import SwiftUI

struct ResizedImage: View {

    private let imageName: String
    private let contentMode: ContentMode
    private let renderingMode: Image.TemplateRenderingMode?
    
    init(
        _ iamgeName: String,
        contentMode: ContentMode = .fill,
        renderingMode: Image.TemplateRenderingMode? = nil
    ) {
        self.imageName = iamgeName
        self.contentMode = contentMode
        self.renderingMode = renderingMode
    }

    var body: some View {
        Image(imageName)
            .renderingMode(renderingMode)
            .resizable()
            .aspectRatio(contentMode: contentMode)
    }
}

struct ResizedImage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ResizedImage("lemon")
                .frame(width: 200, height: 200)
                .previewLayout(.sizeThatFits)

            ResizedImage("cherry", contentMode: .fit, renderingMode: .original)
                .frame(width: 300, height: 200)
                .previewLayout(.sizeThatFits)
        }
    }
}
