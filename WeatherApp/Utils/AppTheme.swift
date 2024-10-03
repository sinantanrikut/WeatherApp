//
//  AppTheme.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import SwiftUI


class AppTheme: ObservableObject {
    private var navBarLargeTitleColor: Color = .white
    private var navBarInlineTitleColor: Color = .white
    private(set) var accentColor: Color = .secondary
    private var backgroundColor: Color = .red
    
    @Published var isTabBarHidden = false
    
    func changeTheme(with color: Color) {
        navBarLargeTitleColor = color
        navBarInlineTitleColor = color
        accentColor = color
        updateNavigationBarColor()
    }
    
    func resetToDefaults() {
        navBarLargeTitleColor = .white
        navBarInlineTitleColor = .white
        accentColor = .white
        updateNavigationBarColor()
    }
    
    func updateNavigationBarColor() {
        UINavigationBar.appearance().scrollEdgeAppearance = {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            // Navigation bar background rengi
            appearance.backgroundColor = UIColor(backgroundColor)
            // Navigation bar yazı renkleri
            appearance.largeTitleTextAttributes = [.foregroundColor: UIColor(navBarLargeTitleColor)]
            appearance.titleTextAttributes = [.foregroundColor: UIColor(navBarInlineTitleColor)]
            // Geri butonu rengini ayarla
            appearance.buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(.white)]
            let chevronImage = UIImage(systemName: "chevron.left")?.withTintColor(UIColor(.white), renderingMode: .alwaysOriginal)
            appearance.setBackIndicatorImage(chevronImage, transitionMaskImage: chevronImage)

            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().standardAppearance = appearance
            return appearance
        }()
    }
}
