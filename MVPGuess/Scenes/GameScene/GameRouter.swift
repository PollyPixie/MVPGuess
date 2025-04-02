//
//  GameRouter.swift
//  MVPGuess
//
//  Created by Полина Соколова on 02.04.25.
//

import UIKit

// MARK: - GameRouterDelegate Protocol
protocol GameRouterDelegate: AnyObject {
    func continueGame()
}

// MARK: - GameRouter Class
final class GameRouter {
    weak var delegate: GameRouterDelegate?

    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func showResultAlert(isCorrect: Bool, score: Int) {
        let title = isCorrect ? "Правильно!" : "Неправильно"
        let message = "Текущий счёт: \(score)"

        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "Продолжить", style: .default) { [weak self] _ in
            self?.delegate?.continueGame()
        })

        viewController?.present(alert, animated: true)
    }
}

