//
//  MockRequestHandler.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 18/01/2023.
//

import Foundation

final class MockRequestHandler: RequestHandlerProtocol {
    
    static let shared: MockRequestHandler = .init()
    
    func call<Model: Decodable>(_ route: HTTPRequestRouter) async throws -> Model{
        
        var fileName: String = ""
        
        switch route {
        case .getCompanyInfo:
            fileName = "company"
        case .getLaunches(page: _, year: _, sortIndex: _):
            fileName = "launches-query"
        case .getRocket(id: _):
            fileName = "rocket"
        }
        
        let fileURL: URL = Bundle.main.url(forResource: fileName, withExtension: "json")!
        
        let (data, _) = try await URLSession.shared.data(from: fileURL)
        return try JSONDecoder().decode(Model.self, from: data)
        
    }
    
}

