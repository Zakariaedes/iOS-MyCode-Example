//
//  HTTPRequestConfig.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 2/9/2022.
//

import Foundation

enum HTTPMethod: String {
    case get  = "GET"
    case post = "POST"
}

protocol HTTPRequestConfig {
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var parameters: [String: Any]? { get }
    
    func asURLRequest() throws -> URLRequest
    
}
