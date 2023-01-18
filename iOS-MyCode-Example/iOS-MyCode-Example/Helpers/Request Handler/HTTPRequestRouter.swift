//
//  HTTPRequestRouter.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 2/9/2022.
//

import Foundation

enum HTTPRequestRouter {
    case getCompanyInfo
    case getLaunches(page: Int, year: UInt?, sortIndex: Int?)
    case getRocket(id: String)
}

extension HTTPRequestRouter: HTTPRequestConfig{
    
    var baseURL: String {
        return EnvironmentHandler.shared.baseURL
    }
    
    var path: String {
        switch self{
        case .getCompanyInfo:
            return "company"
        case .getLaunches:
            return "launches/query"
        case .getRocket(let id):
            return "rockets/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self{
        case .getCompanyInfo, .getRocket:
            return .get
        case .getLaunches:
            return .post
        }
    }
    
    var parameters: [String : Any]? {
        switch self{
        case .getCompanyInfo, .getRocket:
            return nil
        case .getLaunches(let page, let year, let sortIndex):
            
            var queryParams: [String: Any] = [:]
            var optionsParams: [String: Any] = [
                "limit": 10,
                "page" : page
            ]
            
            if let year = year {
                queryParams["date_utc"] = ["$regex": "^\(year).*"]
                queryParams["success"]  = true
            }
            
            if let sortIndex = sortIndex, sortIndex > -1 {
                optionsParams["sort"] = ["date_unix": sortIndex == 0 ? 1 : -1]
            }
            
            return [
                "query": queryParams,
                "options": optionsParams
            ]
            
        }
    }
    
    var headers: [String: String] {
        return [
            "Content-type": "application/json"
        ]
    }
    
    func asURLRequest() -> URLRequest {
        
        var urlRequest: URLRequest = .init(url: .init(string: baseURL + path)!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.timeoutInterval = 30.0
        
        if method == .post{
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: parameters ?? [])
        }
        
        return urlRequest
        
    }
    
}
