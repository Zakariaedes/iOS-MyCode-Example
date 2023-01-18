//
//  RequestHandlerProtocol.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 18/01/2023.
//

import Foundation

protocol RequestHandlerProtocol {
    func call<Model: Decodable>(_ route: HTTPRequestRouter) async throws -> Model
}
