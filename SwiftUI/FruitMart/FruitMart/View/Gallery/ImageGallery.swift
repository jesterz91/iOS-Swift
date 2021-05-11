//
//  ImageGallery.swift
//  FruitMart
//
//  Created by lee on 2021/05/12.
//

import SwiftUI

struct ImageGallery: View {
    
    @State private var productImages: [String] = Store().products.map { $0.imageName }

    @State private var spacing: CGFloat = 20

    @State private var scale: CGFloat = 0.020

    @State private var angle: CGFloat = 5
    
    @GestureState private var translation: CGSize = .zero
    
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                backgroudCards
                frontCard
            }
            Spacer()
            controller
        }
        .edgesIgnoringSafeArea(.top)
    }
    
    private var backgroudCards: some View {
        ForEach(productImages.dropFirst().reversed(), id: \.self) {
            self.backgroudCard(image: $0)
        }
    }

    private var frontCard: some View {
        let dragGesture = DragGesture()
            .updating($translation) { (value, state, _) in
                state = value.translation
            }
        return FruitCard(productImages[0])
            .offset(translation)
            .shadow(radius: 4, x: 2, y: 2)
            .onLongPressGesture {
                self.productImages.append(self.productImages.removeFirst())
            }
            .gesture(dragGesture)
    }

    private var controller: some View {
        let titles = ["간격", "크기", "각도"]
        let values = [$spacing, $scale, $angle]
        let ranges: [ClosedRange<CGFloat>] = [1.0...40.0, 0...0.05, -90.0...90.90]
        
        return VStack {
            ForEach(titles.indices) { i in
                HStack {
                    Text(titles[i])
                        .font(.system(size: 17))
                        .frame(width: 80)
                    Slider(value: values[i], in: ranges[i])
                }
            }
        }
    }
    
    private func backgroudCard(image: String) -> some View {
        let index = productImages.firstIndex(of: image)!
        let response = computedResponse(index: index)
        let animation = Animation.spring(response: response, dampingFraction: 0.68)
        
        return FruitCard(image)
            .shadow(color: .primaryShadow, radius: 2, x: 2, y: 2)
            .offset(computedPosition(index: index))
            .scaleEffect(computedScale(index: index))
            .rotation3DEffect(computeAngle(index: index), axis: (0,0,1))
            .transition(AnyTransition.scale.animation(animation))
            .animation(animation)
    }

    private func computedPosition(index: Int) -> CGSize {
        let x = translation.width
        let y = translation.height - CGFloat(index) * spacing
        return CGSize(width: x, height: y)
    }

    private func computedScale(index: Int) -> CGFloat {
        let cardScale = 1.0 - CGFloat(index) * (0.05 - scale)
        return max(cardScale, 0.1)
    }

    private func computedResponse(index: Int) -> Double {
        return max(Double(index) * 0.04, 0.2)
    }

    private func computeAngle(index: Int) -> Angle {
        let degrees = Double(index) * Double(angle)
        return Angle(degrees: degrees)
    }
}

struct ImageGallery_Previews: PreviewProvider {
    static var previews: some View {
        ImageGallery()
    }
}
