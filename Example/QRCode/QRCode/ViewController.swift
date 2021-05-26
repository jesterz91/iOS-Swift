//
//  ContentView.swift
//  QRCode
//
//  Created by lee on 2021/05/26.
//

import SwiftUI

final class ViewController: UIViewController {
    
    private let qrcodeView: QRCodeView = {
        let view = QRCodeView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        makeConstraint()
    }
    
    private func configure() {
        view.addSubview(qrcodeView)
        qrcodeView.generate("https://google.com")
    }

    private func makeConstraint() {
        NSLayoutConstraint.activate([
            qrcodeView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            qrcodeView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            qrcodeView.widthAnchor.constraint(equalToConstant: 375),
            qrcodeView.heightAnchor.constraint(equalToConstant: 375)
        ])
    }
}


#if DEBUG
import SwiftUI

struct ViewController_Previews: PreviewProvider {
    static var previews: some View {
         Group {
            ViewControllerRepresentable(target: ViewController())
                .previewDevice(.iPhone12)

            ViewControllerRepresentable(target: ViewController())
                .previewDevice(.iPhone8)
        }
    }
}
#endif
