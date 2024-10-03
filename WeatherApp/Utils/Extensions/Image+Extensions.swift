//
//  Image+Extensions.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import SwiftUI

extension Image {
    
    static func custom(_ name: ImageName, color: IconScheme? = nil) -> Image {
        if let color {
            return Image(name.rawValue + "_" + color.rawValue)
        }
        return Image(name.rawValue)
    }
    
    enum IconScheme: String {
        case light
        case dark
    }
    
    enum ImageName: String {
        case logo

    }
    
}
