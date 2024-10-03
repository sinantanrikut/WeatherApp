//
//  ErrorResponse.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import Foundation

struct ErrorResponse: Error {
    let errorMessage: String?
    let errorCode: Int?
    let errorType: ErrorType
}
