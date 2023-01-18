//
//  HomeProtocol.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 1/9/2022.
//

import UIKit

protocol FilterToHomeViewProtocol {
    func onFilterItemsChanged(year: UInt?, sortIndex: Int?)
}

protocol PresenterToHomeViewProtocol {
    var presenter: ViewToHomePresenterProtocol! { get set }
    func startLoading()
    func stopLoading()
    func update(company: CompanyEntity?, launchResponseEntity: LaunchResponseEntity)
    func showAlertError()
}

protocol ViewToHomePresenterProtocol {
    var view: PresenterToHomeViewProtocol! { get set }
    var interactor: PresenterToHomeInteractorProtocol! { get set }
    var router: PresenterToHomeRouterProtocol! { get set }
    func viewDidLoad()
    func getCompanyInformationAndItsLaunches(page: Int, year: UInt?, sortIndex: Int?, isToShowFullScreenLoader: Bool)
    func presentFilterPopupView(from view: UIViewController, selectedYear: UInt?, sortingIndex: Int?, delegate: FilterToHomeViewProtocol)
}

protocol PresenterToHomeInteractorProtocol {
    var presenter: InteractorToHomePresenterProtocol! { get set }
    func getCompanyInformationAndItsLaunches(page: Int, year: UInt?, sortIndex: Int?)
}

protocol InteractorToHomePresenterProtocol {
    func fetchingCompanyInformationAndItsLaunchesSuccessResponse(company: CompanyEntity?, launchResponseEntity: LaunchResponseEntity)
    func fetchingCompanyInformationAndItsLaunchesFailureResponse()
}

protocol PresenterToHomeRouterProtocol {
    var view: HomeView! { get set }
    var interactor: HomeInteractor!  { get set }
    func createModule() -> UIViewController
    func presentFilterPopupView(from view: UIViewController, selectedYear: UInt?, sortingIndex: Int?, delegate: FilterToHomeViewProtocol)
}
