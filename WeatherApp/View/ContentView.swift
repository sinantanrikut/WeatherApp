//
//  ContentView.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var locationManager: LocationManager
    @EnvironmentObject private var loginViewModel: LoginViewModel
//    @EnvironmentObject private var viewModel: UserViewModel
//    @EnvironmentObject private var appTheme: AppTheme
    
    var body: some View {
        NavigationView {
            AuthenticationView()
                .navigationBarBackButtonHidden()
                .navigationBarTitleDisplayMode(.inline)
        }
    
    }
}


#Preview {
    ContentView()
}
