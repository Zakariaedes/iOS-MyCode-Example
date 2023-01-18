//
//  HomeView.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 1/9/2022.
//

import UIKit
import SwiftMessages

final class HomeView: RootViewController, PresenterToHomeViewProtocol {
    
    private var mainView: HomeUIView!
    
    var presenter: ViewToHomePresenterProtocol!
    
    private var company: CompanyEntity = .init()
    private var launchResponseEntity: LaunchResponseEntity = .init()
    
    private var selectedYear: UInt?
    private var sortingIndex: Int?
    
    private enum LaunchesTableViewSection: Int {
        case companyInfo = 0
        case launches = 1
    }
    
    private let filterButton: UIButton = {
        let button: UIButton = .init()
        button.setImage(.init(named: "icon_filter"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView = .init(frame: view.frame)
        view = mainView
        
        configureNavigationBar()
        configureLaunchesTableView()
        
        presenter.viewDidLoad()
        
    }
    
    private func configureNavigationBar() {
        
        navigationItem.title = "app_name".localized
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: filterButton)
        
        filterButton.addTarget(self, action: #selector(onTapFilterButton(_:)), for: .touchUpInside)
        
    }
    
    private func configureLaunchesTableView() {
        mainView.launchesTableView.dataSource = self
        mainView.launchesTableView.delegate = self
        mainView.launchesTableView.register(HomeCompanyTableViewCell.self, forCellReuseIdentifier: HomeCompanyTableViewCell.reuseIdentifier)
        mainView.launchesTableView.register(HomeLaunchesTableViewCell.self, forCellReuseIdentifier: HomeLaunchesTableViewCell.reuseIdentifier)
    }
    
    func startLoading() {
        showLoader()
    }
    
    func stopLoading() {
        hideLoader()
    }
    
    func showAlertError() {
        
        var config = SwiftMessages.Config()
        config.presentationStyle = .bottom
        config.duration = .forever
        
        let alertView: MessageView = .viewFromNib(layout: .messageView)
        alertView.configureTheme(.error)
        alertView.configureDropShadow()
        alertView.configureContent(
            title: "home_screen.alert_error_view.title".localized,
            body: "home_screen.alert_error_view.description".localized,
            iconText: "⚠️"
        )
        (alertView.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        alertView.button?.setTitle("home_screen.alert_error_view.retry".localized, for: .normal)
        
        alertView.buttonTapHandler = { [weak self] _ in
            
            guard let self = self else {
                return
            }
            
            var page: Int = self.launchResponseEntity.currentPage
            var isToShowFullScreenLoader: Bool = true
            
            //MAKING SURE NOT CALLING THE NEXT PAGE INSTEAD OF THE CURRENT ONE
            if page > 1 {
                page = self.launchResponseEntity.currentPage - 1
                isToShowFullScreenLoader = false
            }
                
            self.presenter.getCompanyInformationAndItsLaunches(page: page, year: self.selectedYear, sortIndex: self.sortingIndex, isToShowFullScreenLoader: isToShowFullScreenLoader)
                
            SwiftMessages.hide()
                
        }
        
        SwiftMessages.show(config: config, view: alertView)
    }
    
    func update(company: CompanyEntity?, launchResponseEntity: LaunchResponseEntity) {
        //MAKING SURE THAT WE DO NOT UPDATE THE COMPANY ENTITY WHEN GETTING THE PAGINATION DATA
        if let company = company {
            self.company = company
        }
        self.launchResponseEntity.replace(with: launchResponseEntity)
        mainView.launchesTableView.reloadData()
    }
    
    private func openLinkInTheBrowser(using links: LaunchLinksEntity){
        
        let alertView: UIAlertController = .init(title: "home_screen.link_alert.title".localized, message: nil, preferredStyle: .alert)
        
        var wikipediaURL: URL?
        var webcastURL: URL?
        
        if let wikipediaStringURL = links.wikipediaLink,
            let url = URL(string: wikipediaStringURL) {
            wikipediaURL = url
            alertView.addAction(
                .init(
                    title: "home_screen.link_alert.wikipedia".localized,
                    style: .default,
                    handler: { _ in
                        UIApplication.shared.open(url)
                    }
                )
            )
        }
        
        if let webcastStringURL = links.webcastLink,
            let url = URL(string: webcastStringURL) {
            webcastURL = url
            alertView.addAction(
                .init(
                    title: "home_screen.link_alert.webcast".localized,
                    style: .default,
                    handler: { _ in
                        UIApplication.shared.open(url)
                    }
                )
            )
        }
        
        if wikipediaURL == nil, webcastURL == nil{
            alertView.title = "home_screen.link_alert.sources_are_not_available".localized
            alertView.addAction(.init(title: "home_screen.link_alert.ok".localized, style: .cancel, handler: nil))
        }
        
        present(alertView, animated: true)
        
    }
    
    @objc
    private func onTapFilterButton(_ button: UIButton) {
        presenter.presentFilterPopupView(from: self, selectedYear: selectedYear, sortingIndex: sortingIndex, delegate: self)
    }
    
}

extension HomeView: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return company.getFullDescription() == nil ? 0 : 2
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionView: UIView = {
            let view: UIView = .init()
            view.backgroundColor = .gray
            return view
        }()
        
        let label: UILabel = {
            let label: UILabel = .init()
            label.textColor = .white
            label.font = .systemFont(ofSize: 20.0)
            label.text = (section == 0 ? "home_screen.company" : "home_screen.launches").localized.uppercased()
            return label
        }()
        
        sectionView.addSubview(label)
        
        label.snp.makeConstraints {
            let space: CGFloat = 3.0
            $0.top.leading.equalToSuperview().offset(space)
            $0.bottom.trailing.equalToSuperview().offset(-space)
        }
        
        return sectionView
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == LaunchesTableViewSection.companyInfo.rawValue ? 1 : launchResponseEntity.launches.isEmpty ? 1 : launchResponseEntity.launches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == LaunchesTableViewSection.companyInfo.rawValue {
            
            let cell: HomeCompanyTableViewCell = tableView.dequeueReusableCell(withIdentifier: HomeCompanyTableViewCell.reuseIdentifier, for: indexPath) as! HomeCompanyTableViewCell
            cell.set(description: company.getFullDescription() ?? "")
            return cell
            
        } else if launchResponseEntity.launches.isEmpty {
            
            let cell: HomeCompanyTableViewCell = tableView.dequeueReusableCell(withIdentifier: HomeCompanyTableViewCell.reuseIdentifier, for: indexPath) as! HomeCompanyTableViewCell
            cell.set(description: "home_screen.no_launches_found".localized)
            return cell
            
        }
        
        let cell: HomeLaunchesTableViewCell = tableView.dequeueReusableCell(withIdentifier: HomeLaunchesTableViewCell.reuseIdentifier, for: indexPath) as! HomeLaunchesTableViewCell
        cell.updateCellWith(launch: launchResponseEntity.launches[indexPath.row])
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.section == LaunchesTableViewSection.launches.rawValue {
            
            if launchResponseEntity.currentPage == launchResponseEntity.totalPages {
                tableView.tableFooterView = nil
                return
            }
            
            if indexPath.row == launchResponseEntity.launches.count - 1,
               launchResponseEntity.currentPage < launchResponseEntity.totalPages,
               tableView.footerView(forSection: indexPath.section) == nil {
                
                tableView.showLoadingFooterView()
                presenter.getCompanyInformationAndItsLaunches(page: launchResponseEntity.getNextPage(), year: selectedYear, sortIndex: sortingIndex, isToShowFullScreenLoader: false)
                
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == LaunchesTableViewSection.companyInfo.rawValue { return }
        openLinkInTheBrowser(using: launchResponseEntity.launches[indexPath.row].links)
    }
    
}

extension HomeView: FilterToHomeViewProtocol {
    
    func onFilterItemsChanged(year: UInt?, sortIndex: Int?) {
        //CHECKING IF NOTHING HAS CHANGED IN THE FILTER POPUP, SO THERE IS NO NEED TO CALL THE API
        if selectedYear == year, sortingIndex == sortIndex{
            return
        }
        selectedYear = year
        sortingIndex = sortIndex
        launchResponseEntity.launches.removeAll()
        launchResponseEntity.setCurrentPage(with: 0)
        presenter.getCompanyInformationAndItsLaunches(page: launchResponseEntity.getNextPage(), year: year, sortIndex: sortIndex, isToShowFullScreenLoader: true)
    }
    
}
