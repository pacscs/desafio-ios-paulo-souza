//
//  SceneDelegate.swift
//  desafio-ios-paulo-souza
//
//  Created by Paulo Alfredo Coraini de Souza on 12/03/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        let vc = MainViewController()
        vc.title = "Marvel Heroes"
        let nav = UINavigationController(rootViewController: vc)
        window.rootViewController = nav
        window.makeKeyAndVisible()
        self.window = window
    }
    
}
