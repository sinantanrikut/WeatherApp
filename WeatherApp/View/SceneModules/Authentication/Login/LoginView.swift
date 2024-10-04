//
//  LoginView.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var viewModel : LoginViewModel
    
    @State private var email = ""
    @State private var password = ""
    @State private var showSignup = false
    
    var body: some View {
        VStack {
            TextField("Email", text: $email)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(5)
            
            Button(action: {
                viewModel.login(email: email, password: password)
                
            }, label: {
                Text("Log In")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(5)
            })
            .padding(.top, 20)
            
            Spacer()
            
            HStack {
                Text("Don't have an account?")
                Button(action: {
                    showSignup.toggle()
                }) {
                    Text("Sign Up")
                        .foregroundColor(.blue)
                }
            }
            .padding()
            
        }
        .padding()
        .navigationTitle("Log In")
        .sheet(isPresented: $showSignup) {
            SignUpView()
        }
        .workaroundLink(to:HomeView().navigationBarBackButtonHidden(), isActive: $viewModel.isLogin)
        
    }
}


#Preview {
    LoginView()
}
