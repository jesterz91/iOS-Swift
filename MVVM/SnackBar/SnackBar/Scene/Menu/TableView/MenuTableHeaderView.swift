//
//  MenuHeaderView.swift
//  SnackBar
//
//  Created by lee on 2021/04/23.
//

import UIKit

final class MenuTableHeaderView: BaseView {

    private let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = "튀김 전문점"
        view.font = .systemFont(ofSize: 20)
        return view
    }()
    
    override func configure() {
        backgroundColor = .systemTeal
        addSubview(label)
    }
    
    override func makeConstraint() {
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

#if DEBUG
import SwiftUI

struct MenuTableHeaderView_Previews: PreviewProvider {

    static var previews: some View {
        return ViewRepresentable(target: MenuTableHeaderView())
            .previewLayout(.fixed(width: 375, height: 50))
    }
}
#endif
