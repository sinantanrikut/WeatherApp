//
//  LoginViewModel.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import Foundation

final class LoginViewModel: BaseViewModel {
    
    private let service = UserService()


    private var timer: Timer?
    
    override init() {
        super.init()
        SessionManager.shared.loginViewModel = self
    }
    
    
    
}
