//
//  HomeView.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import SwiftUI
import FirebaseAuth

struct HomeView: View {
    @State private var userEmail = ""
    @State private var userId = ""
    
    var body: some View {
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
                .padding()
            
            Text("User ID: \(userId)")
            Text("Email: \(userEmail)")
            
            Spacer()
        }
        .onAppear {
            fetchUserDetails()
        }
    }
    
    // Kullanıcı bilgilerini çekme
    func fetchUserDetails() {
        if let user = Auth.auth().currentUser {
            userEmail = user.email ?? "No Email"
            userId = user.uid
        } else {
            userEmail = "No User Logged In"
            userId = "No User ID"
        }
        
    }
}

#Preview {
    HomeView()
}
