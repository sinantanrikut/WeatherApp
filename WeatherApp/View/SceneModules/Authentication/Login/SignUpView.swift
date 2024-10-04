//
//  SignUpView.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import SwiftUI

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    @EnvironmentObject private var viewModel : LoginViewModel
    @State private var email = ""
    @State private var password = ""

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
                viewModel.signUp(email: email, password: password)
            }, label: {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(5)
            })
            .padding(.top, 20)
  
            Spacer()
        }
        .padding()
        .navigationTitle("Sign Up")
    }

}


#Preview {
    SignUpView()
}
