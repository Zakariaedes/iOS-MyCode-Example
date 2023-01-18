//
//  HomeRouter.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 1/9/2022.
//

import UIKit

final class HomeRouter: PresenterToHomeRouterProtocol {
    
    var view: HomeView!
    var interactor: HomeInteractor!
    
    init(view: HomeView, interactor: HomeInteractor) {
        self.view = view
        self.interactor = interactor
    }
    
    func createModule() -> UIViewController {
        
        let presenter: HomePresenter = .init(view: view, interactor: interactor, router: self)
        
        view.presenter = presenter
        interactor.presenter = presenter
        
        view.modalPresentationStyle = .fullScreen
        
        return RootNavigationViewController(rootViewController: view)
        
    }
    
    func presentFilterPopupView(from view: UIViewController, selectedYear: UInt?, sortingIndex: Int?, delegate: FilterToHomeViewProtocol) {
        let filterView: HomeCustomFilterView = .init(selectedYear: selectedYear, sortingIndex: sortingIndex, delegate: delegate)
        filterView.modalPresentationStyle = .overFullScreen
        filterView.modalTransitionStyle = .crossDissolve
        view.present(filterView, animated: true)
    }
    
}
