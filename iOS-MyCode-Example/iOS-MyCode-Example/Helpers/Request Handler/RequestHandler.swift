//
//  RequestHandler.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 2/9/2022.
//

import Foundation

final class RequestHandler: RequestHandlerProtocol {
    
    static let shared: RequestHandler = .init()
    
    func call<Model: Decodable>(_ route: HTTPRequestRouter) async throws -> Model{
        
        let (data, _) = try await URLSession.shared.data(for: route.asURLRequest())
        return try JSONDecoder().decode(Model.self, from: data)
        
    }
    
}
