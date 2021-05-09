//
//  Theme.swift
//  DarkMode
//
//  Created by lee on 2021/05/09.
//

import SwiftUI

struct Theme {

    static func backgroundColor(for scheme: ColorScheme) -> Color {
        let lightColor: Color = .white
        let darkColor: Color = .init(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))

        switch scheme {
        case .light:
            return lightColor
        case .dark:
            return darkColor
        @unknown default:
            return lightColor
        }
    }

    static func buttonColor(for scheme: ColorScheme) -> Color {
        switch scheme {
        case .dark:
            return .init(#colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1))
        default:
            return .blue
        }
    }
}
