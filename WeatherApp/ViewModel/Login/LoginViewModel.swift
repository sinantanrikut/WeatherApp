//
//  LoginViewModel.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import Foundation
import FirebaseAuth

final class LoginViewModel: BaseViewModel {
    
    private let service = UserService()
    @Published var isLogin: Bool = false
    @Published var isRegisterTrue: Bool = false

    private var timer: Timer?
    
    override init() {
        super.init()
        SessionManager.shared.loginViewModel = self
    }
    
    func login(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.handleErrorToast(with: false, message: error.localizedDescription )
                self.isLogin = false
            } else {
                self.isLogin = true
                printSuccess("Response: \(String(describing: result))")
            }
        }
     
    }
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.handleErrorToast(with: false, message: error.localizedDescription )
                self.isRegisterTrue = false
            } else {
                self.isRegisterTrue = true
                printSuccess("Response: \(String(describing: result))")
            }
        }
    }
    
    
}
