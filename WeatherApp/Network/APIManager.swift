//
//  APIManager.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//

import Foundation
import Combine
import SwiftUI

final class APIManager {
    
    public static let shared = APIManager()
    
    private var showLoading = true
    
    private init() {}
   
    public func fetchData<T: Decodable>(url: URL, pathVariables: [String]? = nil, body: Encodable? = nil, showLoading: Bool = true, bodyParameters: [String: String]? = nil, method: HttpMethod) -> AnyPublisher<T, Error> {
        // Loading indicator
        self.showLoading = showLoading
        
        // URL Components
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let pathVariables = pathVariables, !pathVariables.isEmpty {
            let path = components?.path ?? ""
            components?.path = String(format: path, arguments: pathVariables)
        }
        guard let finalUrl = components?.url else {
            return Fail<T, Error>(error: NetworkError.invalidUrl).eraseToAnyPublisher()
        }
        
        // Request
        var request = URLRequest(url: finalUrl)
        let session = URLSession.shared
        request.httpMethod = method.rawValue
   
        // x-www-form-urlencoded body
        if let bodyParameters {
            let bodyData = bodyParameters.compactMap { key, value in
                return "\(key)=\(value)"
            }.joined(separator: "&")
            
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = bodyData.data(using: .utf8)
            printSuccess("Request body: \(String(data: request.httpBody ?? Data(), encoding: .utf8) ?? "")")
        } else {
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        // Body
        if let body {
            request.httpBody = try? JSONEncoder().encode(body)
            printSuccess("Request body: ", body)
        }
        
        printSuccess("Request headers: ", request.allHTTPHeaderFields ?? ["":""])
        printSuccess("Request URL: ", finalUrl)
        
        return session.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap(tryMapHandler)
            .receive(on: DispatchQueue.main)
            .decode(type: T.self, decoder: JSONDecoder())
            .handleEvents(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(_):
                    break
                }
            })
            .eraseToAnyPublisher()
    }
    
    enum NetworkError: Error {
        case invalidUrl
        case requestFailed
        case invalidResponse
        // diğer hatalar
    }
    
    func sendData<T: Decodable>(url: URL, formData: [String: Any], filePathKey: String) -> AnyPublisher<T, Error> {
        var request = URLRequest(url: url)
        let session = URLSession.shared
        
        let bodyBoundary = "--------------------------\(UUID().uuidString)"
        
        // method
        request.httpMethod = HttpMethod.post.rawValue
        
        // headers
        request.addValue("multipart/form-data; boundary=\(bodyBoundary)", forHTTPHeaderField: "Content-Type")
        // body
        let imageData = formData["image"] as? Data
        let requestData = createRequestBody(formData: formData, imageData: imageData, boundary: bodyBoundary, attachmentKey: filePathKey, fileName: "\(filePathKey).jpg")
        request.httpBody = requestData
        
        printInfo("Request body: ", request.httpBody ?? "")
        
        // dataTask
        return session.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
//            .tryMap { data, response in
//                // Check response status here (e.g., 200 OK) and handle any errors.
//                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode != 200 {
//                    throw URLError(.badServerResponse)
//                }
//                return data
//            }
            .tryMap(tryMapHandler)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // Handle any network-related or decoding errors here.
                    print("Error: \(error)")
                }
            })
            .eraseToAnyPublisher()
    }
    
    private func createRequestBody(formData: [String: Any], imageData: Data?, boundary: String, attachmentKey: String, fileName: String) -> Data {
        let lineBreak = "\r\n"
        var requestBody = Data()
        
        for (key, value) in formData {
            requestBody.appendString("--\(boundary + lineBreak)")
            
            if let stringValue = value as? String {
                requestBody.appendString("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                requestBody.appendString("\(stringValue)\(lineBreak)")
            } else if key == "image", let imageData = imageData {
                requestBody.appendString("Content-Disposition: form-data; name=\"\(attachmentKey)\"; filename=\"\(fileName)\"\(lineBreak)")
                requestBody.appendString("Content-Type: image/jpeg \(lineBreak + lineBreak)")
                requestBody.append(imageData)
                requestBody.appendString("\(lineBreak)")
            }
        }
        
        requestBody.appendString("--\(boundary)--\(lineBreak)")
        
        return requestBody
    }
    
  
    
    public lazy var handleCompletion: ((Subscribers.Completion<Error>) -> Void) = { [weak self] completion in
        switch completion {
        case .finished:
            printSuccess("Finished!")
        case .failure(let error):
            printError(error.localizedDescription)
            guard let self else { return }
        }
    }
    
    private lazy var tryMapHandler: (URLSession.DataTaskPublisher.Output) throws -> Data = { output in
        guard let response = output.response as? HTTPURLResponse else {
            throw ErrorResponse(errorMessage: "Server Hatası", errorCode: 500, errorType: .serverError)
        }
        
        let stringData = String(data: output.data, encoding: .utf8)
        printSuccess("Response: \(stringData ?? "")")
        
        if response.statusCode == 555 {
            SessionManager.shared.endSession()
            throw ErrorResponse(errorMessage: stringData, errorCode: response.statusCode, errorType: .missingData)
        }
        
        guard response.statusCode >= 200 && response.statusCode < 300 else {
            throw ErrorResponse(errorMessage: stringData, errorCode: response.statusCode, errorType: .missingData)
        }
       return output.data
    }

}
