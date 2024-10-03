//
//  ServiceProvider.swift
//  WeatherApp
//
//  Created by Sinan Tanrıkut on 3.10.2024.
//
import Foundation

final class ServiceProvider {
    
    public static let shared = ServiceProvider()
    
    private init() {}
    
    /// Sets and returns full request URL
    /// - Parameter endPoint: EndPoint
    /// - Parameter pathVariables: [String]? Path components to append to URL by "/" seperator.
    /// - Parameter queryParams: [URLQueryItem]? Query parameters.
    /// - Returns: URL
    func getRequestUrl(endPoint: EndPoint, pathVariables: [String]? = nil, queryParams: [URLQueryItem]? = nil,isImageUrl:Bool = false) -> URL {
        #if targetEnvironment(simulator)
        let baseUrl = BaseUrl.test
        #else
        let baseUrl = BaseUrl.test
        #endif
        
        if isImageUrl{
            var url = URL(string: baseUrl.rawValue.replacingOccurrences(of: "api/", with: "") + endPoint.rawValue)!
            if let pathVariables = pathVariables, !pathVariables.isEmpty {
                url = url.appendingPathComponent(pathVariables.joined(separator: "/"))
            }
            return url
        }
        var url = URL(string: baseUrl.rawValue + endPoint.rawValue)!
        
        if let pathVariables = pathVariables, !pathVariables.isEmpty {
            url = url.appendingPathComponent(pathVariables.joined(separator: "/"))
        }
        
        let urlComps = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
        urlComps.queryItems = queryParams
        url = urlComps.url!
        return url
    }
    
    func setEndPoint() {
        
    }
    
}

fileprivate enum BaseUrl: String {
    case test = "test"
    case prod = "prod"
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case delete = "DELETE"

}
