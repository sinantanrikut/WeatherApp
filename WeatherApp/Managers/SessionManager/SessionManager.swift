//
//  SessionManager.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import Foundation

final class SessionManager {
    
    static let shared = SessionManager()
    
    weak var loginViewModel: LoginViewModel?
    
    private init() {}
    
    func endSession() {
        //loginViewModel?.logout()
    }
    
}
