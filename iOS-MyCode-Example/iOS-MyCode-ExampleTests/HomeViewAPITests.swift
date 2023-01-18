//
//  HomeViewAPITests.swift
//  iOS-MyCode-ExampleTests
//
//  Created by Zakariae El Aloussi on 18/01/2023.
//

import XCTest
@testable import iOS_MyCode_Example

class HomeViewAPITests: XCTestCase {
    
    func testGettingCompanyInformation() throws {
        
        let expectation: XCTestExpectation = self.expectation(description: "Getting company information")
        
        Task {
            
            do{
        
                let _: CompanyEntity = try await MockRequestHandler.shared.call(.getCompanyInfo)
                expectation.fulfill()
                
            } catch {
                
                XCTFail("⚠️ API - .getCompanyInfo: Response could not be parsed")
                expectation.fulfill()
                
            }
            
        }
        
        waitForExpectations(timeout: 10.0)
        
    }
    
    func testGettingLaunches() throws {
        
        let expectation: XCTestExpectation = self.expectation(description: "Getting launches")
        
        Task {
            
            do{
        
                let _: LaunchResponseEntity = try await MockRequestHandler.shared.call(.getLaunches(page: 1, year: nil, sortIndex: nil))
                expectation.fulfill()
                
            } catch {
                
                XCTFail("⚠️ API - .getLaunches: Response could not be parsed")
                expectation.fulfill()
                
            }
            
        }
        
        waitForExpectations(timeout: 10.0)
        
    }
    
    func testGettingRocketDetails() throws {
        
        let expectation: XCTestExpectation = self.expectation(description: "Getting rocket details")
        
        Task {
            
            do{
        
                let _: RocketEntity = try await MockRequestHandler.shared.call(.getRocket(id: "5e9d0d95eda69955f709d1eb"))
                expectation.fulfill()
                
            } catch {
                
                XCTFail("⚠️ API - .getRocket: Response could not be parsed")
                expectation.fulfill()
                
            }
            
        }
        
        waitForExpectations(timeout: 10.0)
        
    }

}

