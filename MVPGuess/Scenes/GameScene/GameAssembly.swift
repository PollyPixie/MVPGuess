//
//  GameAssembly.swift
//  MVPGuess
//
//  Created by Полина Соколова on 31.03.25.
//

import UIKit

final class GameAssembly {
    
    static func assemble() -> UIViewController {
        let viewController = GameViewController()
        let presenter = GamePresenter(
            view: viewController,
            characterManager: CharacterManager()
        )
        viewController.presenter = presenter
        return viewController
    }
}

