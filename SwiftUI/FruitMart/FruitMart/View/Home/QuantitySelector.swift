//
//  QuantitySelector.swift
//  FruitMart
//
//  Created by lee on 2021/05/04.
//

import SwiftUI

struct QuantitySelector: View {

    @Binding var quantity: Int

    var range: ClosedRange<Int> = 1...20

    private let softFeedBack = UIImpactFeedbackGenerator(style: .soft)

    private let rigidFeedBack = UIImpactFeedbackGenerator(style: .rigid)

    var body: some View {

        HStack {
            Button(action: {
                self.changeQuantity(-1)
            }, label: {
                Image(systemName: "minus.circle.fill")
                    .imageScale(.large)
                    .padding()
            })

            Text("\(quantity)")
                .bold()
                .font(.system(.title, design: .monospaced))
                .frame(minWidth: 40, maxWidth: 40)

            Button(action: {
                self.changeQuantity(1)
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .imageScale(.large)
                    .padding()
            })
        }
    }

    private func changeQuantity(_ num: Int) {
        if range ~= quantity + num {
            quantity += num
            softFeedBack.prepare()
            softFeedBack.impactOccurred(intensity: 0.8)
        } else {
            rigidFeedBack.prepare()
            rigidFeedBack.impactOccurred()
        }
    }
}

struct QuantitySelector_Previews: PreviewProvider {

    static var previews: some View {
        Group {
            QuantitySelector(quantity: .constant(1))
            QuantitySelector(quantity: .constant(10))
            QuantitySelector(quantity: .constant(20))
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
