//
//  HomePresenter.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 1/9/2022.
//

import UIKit

final class HomePresenter: ViewToHomePresenterProtocol, InteractorToHomePresenterProtocol {
    
    var view: PresenterToHomeViewProtocol!
    var interactor: PresenterToHomeInteractorProtocol!
    var router: PresenterToHomeRouterProtocol!
    
    required init(view: PresenterToHomeViewProtocol, interactor: PresenterToHomeInteractorProtocol, router: PresenterToHomeRouterProtocol){
        
        self.view       = view
        self.interactor = interactor
        self.router     = router
        
    }
    
    func viewDidLoad() {
        view.startLoading()
        interactor.getCompanyInformationAndItsLaunches(page: 1, year: nil, sortIndex: nil)
    }
    
    func getCompanyInformationAndItsLaunches(page: Int, year: UInt?, sortIndex: Int?, isToShowFullScreenLoader: Bool = false) {
        if isToShowFullScreenLoader{
            view.startLoading()
        }
        interactor.getCompanyInformationAndItsLaunches(page: page, year: year, sortIndex: sortIndex)
    }
    
    func presentFilterPopupView(from view: UIViewController, selectedYear: UInt?, sortingIndex: Int?, delegate: FilterToHomeViewProtocol) {
        router.presentFilterPopupView(from: view, selectedYear: selectedYear, sortingIndex: sortingIndex, delegate: delegate)
    }
    
    func fetchingCompanyInformationAndItsLaunchesSuccessResponse(company: CompanyEntity?, launchResponseEntity: LaunchResponseEntity) {
        view.stopLoading()
        view.update(company: company, launchResponseEntity: launchResponseEntity)
    }
    
    func fetchingCompanyInformationAndItsLaunchesFailureResponse() {
        view.stopLoading()
        view.showAlertError()
    }
    
}
