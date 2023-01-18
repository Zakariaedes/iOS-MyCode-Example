//
//  SceneDelegate.swift
//  iOS-MyCode-Example
//
//  Created by Zakariae El Aloussi on 18/01/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene: UIWindowScene = (scene as? UIWindowScene) else { return }
        
        let router: HomeRouter = .init(view: HomeView(), interactor: HomeInteractor())
        
        window = .init(windowScene: windowScene)
        window?.rootViewController = router.createModule()
        window?.makeKeyAndVisible()
        
    }
    
}

