//
//  Font+Extensions.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import SwiftUI

extension Font {
    static func setCustom(fontStyle: Font.TextStyle, fontWeight: CustomFont) -> Font {
        return Font.custom(fontWeight.rawValue, size: fontStyle.size, relativeTo: .caption)
    }
}

extension UIFont {
    static func setCustom(fontStyle: Font.TextStyle, fontWeight: CustomFont) -> UIFont? {
        return UIFont(name: fontWeight.rawValue, size: fontStyle.size)
    }
    
    static func setSystem(fontStyle: Font.TextStyle, fontWeight: Weight) -> UIFont? {
        return systemFont(ofSize: fontStyle.size, weight: fontWeight)
    }
}

extension Font.TextStyle {
    var size: CGFloat {
        switch self {
        case .largeTitle: return 34
        case .title: return 28
        case .title2: return 22
        case .title3: return 20
        case .headline: return 18
        case .body: return 17
        case .callout: return 16
        case .subheadline: return 15
        case .footnote: return 13
        case .caption: return 12
        case .caption2: return 11
        @unknown default:
            return 8
        }
    }
}

enum CustomFont: String {
    case regular = "Raleway-Regular"
    case semibold = "Raleway-SemiBold"
    case medium = "Raleway-Medium"
    case bold = "Raleway-Bold"
    case extrabold = "Raleway-ExtraBold"
}
