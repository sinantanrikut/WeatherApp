//
//  BaseService.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import Foundation
import Combine

class BaseService {
    
    let serviceProvider = ServiceProvider.shared
    let apiManager = APIManager.shared
    
    var handleCompletion: ((Subscribers.Completion<Error>) -> Void) {
        apiManager.handleCompletion
    }
    
    
}
