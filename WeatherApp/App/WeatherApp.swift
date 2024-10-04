//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import SwiftUI
import FirebaseCore
import UserNotifications
import FirebaseMessaging

class AppDelegate: NSObject, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        FirebaseApp.configure()

        // FCM için bildirim izinlerini isteme
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { granted, error in
            print("Permission granted: \(granted)")
        }
        
        application.registerForRemoteNotifications()
        
        Messaging.messaging().delegate = self

        return true
    }
    
    // FCM token alındığında
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM Token: \(fcmToken ?? "")")
        // Token'i sunucuya göndermek için burayı kullanabilirsiniz
    }
    
    // Push bildirimi alındığında
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Received push notification: \(userInfo)")
        
        // Bildirim içeriğini göstermek için bir yerel bildirim oluştur
        if let aps = userInfo["aps"] as? [String: AnyObject] {
            let content = UNMutableNotificationContent()
            content.title = aps["alert"]?["title"] as? String ?? "Yeni Bildirim"
            content.body = aps["alert"]?["body"] as? String ?? "Detay yok."
            content.sound = .default
            
            // Bildirimi hemen göster
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error adding notification: \(error.localizedDescription)")
                }
            }
        }
        
        completionHandler(.newData)
    }
    
    // Foreground'da bildirim alındığında
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Bildirim gösterimini ayarlama
        completionHandler([.alert, .sound])
    }
}

// Başlangıç noktası
@main
struct WeatherApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    @StateObject private var loginViewModel = LoginViewModel()
    @StateObject var locationManager = LocationManager()
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
                    .environmentObject(locationManager)
            }
        }
    }
}
