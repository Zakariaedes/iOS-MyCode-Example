//
//  HomeInteractor.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 1/9/2022.
//

import Foundation

final class HomeInteractor: PresenterToHomeInteractorProtocol {
    
    var presenter: InteractorToHomePresenterProtocol!
    
    func getCompanyInformationAndItsLaunches(page: Int, year: UInt?, sortIndex: Int?) {
        
        Task {
            
            do{
        
                var companyInfo: CompanyEntity?
                
                if page == 1{
                    companyInfo = try await .fetch()
                }
                
                var launchResponseEntity: LaunchResponseEntity = try await .fetch(page: page, year: year, sortIndex: sortIndex)
                
                for i in 0..<(launchResponseEntity.launches.count > 0 ? launchResponseEntity.launches.count : 1) - 1 {
                    try await launchResponseEntity.launches[i].set(rocket: RocketEntity.fetch(id: launchResponseEntity.launches[i].rocket.id))
                }
                
                await MainActor.run { [weak self, companyInfo, launchResponseEntity] in
                    self?.presenter.fetchingCompanyInformationAndItsLaunchesSuccessResponse(company: companyInfo, launchResponseEntity: launchResponseEntity)
                }
                
            }catch{
                await MainActor.run { [weak self] in
                    self?.presenter.fetchingCompanyInformationAndItsLaunchesFailureResponse()
                }
            }
            
        }
        
    }
    
}
