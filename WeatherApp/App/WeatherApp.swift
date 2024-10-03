//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    if let _ = FirebaseApp.app() {
      print("Firebase configuration successful")
    } else {
      print("Firebase configuration failed")
    }

    return true
  }
}

@main
struct WeatherApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject private var loginViewModel = LoginViewModel()
//    @StateObject private var appTheme = AppTheme()
//    @StateObject private var userViewModel = UserViewModel()
//    @StateObject private var navigationManager = NavigationManager()
    @State private var showSplash = true
    var body: some Scene {
        WindowGroup {
            if showSplash {
                LaunchScreen()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation() {
                                self.showSplash = false
                            }
                        }
                    }
            } else {
                
                ContentView()
                    .preferredColorScheme(.light)
                    .environmentObject(loginViewModel)
//                    .environmentObject(appTheme)
//                    .environmentObject(userViewModel)
//                    .environmentObject(navigationManager)
//                    .onAppear(perform: appTheme.updateNavigationBarColor)
            }
        }
    }
}
