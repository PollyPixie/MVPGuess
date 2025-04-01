//
//  SceneDelegate.swift
//  MVPGuess
//
//  Created by Полина Соколова on 27.03.25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = scene as? UIWindowScene else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let rootVC = GameAssembly.assemble()
        let navigationController = UINavigationController(rootViewController: rootVC)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}

