//
//  HomeView.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    var body: some View {
        TabView {
            WelcomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Anasayfa")
                }
            
            ListView()
                .tabItem {
                    Image(systemName: "building.2.fill")
                    Text("Şehirler")
                }
        }
    }
}

#Preview {
    HomeView()
}
