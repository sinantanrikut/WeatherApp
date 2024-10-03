//
//  AuthenticationView.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject private var viewModel: LoginViewModel
    
    var body: some View {
        LoginView().navigationBarBackButtonHidden()
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
            .environmentObject(LoginViewModel())
    }
}
