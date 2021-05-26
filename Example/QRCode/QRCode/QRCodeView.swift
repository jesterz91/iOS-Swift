//
//  QRCodeView.swift
//  QRCode
//
//  Created by lee on 2021/05/26.
//

import UIKit

final class QRCodeView: UIView {

    private let barcode: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        makeConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        addSubview(barcode)
    }

    private func makeConstraint() {
        NSLayoutConstraint.activate([
            barcode.topAnchor.constraint(equalTo: topAnchor),
            barcode.bottomAnchor.constraint(equalTo: bottomAnchor),
            barcode.leadingAnchor.constraint(equalTo: leadingAnchor),
            barcode.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    func generate(
        _ code: String,
        foregroundColor: UIColor = .black,
        backgroundColor: UIColor = .white
    ) {
        guard
            let filter = CIFilter(name: "CIQRCodeGenerator"),
            let data = code.data(using: .isoLatin1, allowLossyConversion: false)
        else {
            return
        }

        filter.setValue(data, forKey: "inputMessage")

        guard let ciImage = filter.outputImage else { return }

        let transformed = ciImage.transformed(by: CGAffineTransform(scaleX: 10, y: 10))

        let invertFilter = CIFilter(name: "CIColorInvert")
        invertFilter?.setValue(transformed, forKey: kCIInputImageKey)

        let alphaFilter = CIFilter(name: "CIMaskToAlpha")
        alphaFilter?.setValue(invertFilter?.outputImage, forKey: kCIInputImageKey)

        if let outputImage = alphaFilter?.outputImage  {
            barcode.tintColor = foregroundColor
            barcode.backgroundColor = backgroundColor
            barcode.image = UIImage(ciImage: outputImage, scale: 2.0, orientation: .up)
                .withRenderingMode(.alwaysTemplate)
        }
    }
}


#if DEBUG
import SwiftUI

struct QRCodeView_Previews: PreviewProvider {
    static var previews: some View {
        let view = QRCodeView()
        view.generate("https://naver.com")

        return ViewRepresentable(target: view)
                .previewLayout(.fixed(width: 350, height: 350))
    }
}
#endif
