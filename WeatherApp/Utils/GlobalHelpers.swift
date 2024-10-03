//
//  GlobalHelpers.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import Foundation

func printError(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    if items.count == 1, items.first is String {
        print("🍎\(items.first as! String)")
    } else {
        print("🍎\(items)")
    }
}

func printSuccess(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    if items.count == 1, items.first is String {
        print("🍏\(items.first as! String)")
    } else {
        print("🍏\(items)")
    }
}

func printInfo(_ items: Any..., separator: String = " ", terminator: String = "\n") {
    if items.count == 1, items.first is String {
        print("ℹ️\(items.first as! String)")
    } else {
        print("ℹ️\(items)")
    }
}
