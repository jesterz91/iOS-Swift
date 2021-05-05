//
//  ShirinkButtonStyle.swift
//  FruitMart
//
//  Created by lee on 2021/05/05.
//

import SwiftUI

struct ShirinkButtonStyle: ButtonStyle {

    private var minScale: CGFloat = 0.9
    private var minOpacity: Double = 0.6

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? minScale : 1)
            .opacity(configuration.isPressed ? minOpacity : 1)
    }
}
