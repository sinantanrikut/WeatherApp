//
//  BaseViewModel.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import Combine
import SwiftUI

class BaseViewModel: ObservableObject {
    
    
    // MARK: - Cancellables
    var cancellable: Cancellable?
    var cancellable2: Cancellable?
    
    @Published var isLoggedIn: Bool = false
    @Published var isLoggedTouch: Bool = false
    @Published var isVerified: Bool = false
    @Published var agreedToDocumentProcess: Bool = false
    @Published var isToastShowing = false
    @Published var toastMessage : String = ""
    @Published var isToastSuccess = false
    @Published var isGetemLogin = false

    func handleErrorToast(with isSuccessful: Bool, message: String) {
        toastMessage = message
        isToastSuccess = isSuccessful
        isToastShowing = true
    }

}

