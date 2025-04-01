//
//  GameViewController.swift
//  MVPGuess
//
//  Created by Полина Соколова on 31.03.25.
//

import UIKit

// MARK: - IGameViewController Protocol
protocol IGameViewController: AnyObject {
    func render(viewModel: GameViewModel)
    func showResult(isCorrect: Bool, score: Int)
}

// MARK: - GameViewController Class
final class GameViewController: UIViewController {
    
    var presenter: IGamePresenter?
    
    private let questionLabel = UILabel()
    private var optionButtons: [UIButton] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        presenter?.loadNewQuestion()
    }
}

// MARK: - IGameViewController Conformance
extension GameViewController: IGameViewController {
    
    func render(viewModel: GameViewModel) {
        questionLabel.text = viewModel.questionText
        
        optionButtons.forEach { $0.removeFromSuperview() }
        optionButtons = []
        
        for option in viewModel.options {
            let button = UIButton(type: .system)
            
            button.backgroundColor = .white
            button.clipsToBounds = true
            button.layer.cornerRadius = 8
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
            
            if let image = UIImage(named: option.imageName) {
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                imageView.translatesAutoresizingMaskIntoConstraints = false
                button.addSubview(imageView)
                
                NSLayoutConstraint.activate([
                    imageView.topAnchor.constraint(equalTo: button.topAnchor, constant: 0),
                    imageView.bottomAnchor.constraint(equalTo: button.bottomAnchor, constant: -2),
                    imageView.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 2),
                    imageView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 0)
                ])
            } else {
                button.setTitle("Нет изображения", for: .normal)
            }
            
            button.tag = option.id
            button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(button)
            optionButtons.append(button)
        }
        
        layoutButtons()
    }
    
    func showResult(isCorrect: Bool, score: Int) {
        let title = isCorrect ? "Правильно!" : "Неправильно"
        let message = "Текущий счёт: \(score)"
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        alert.addAction(
            UIAlertAction(title: "Продолжить", style: .default) { [weak self] _ in
                self?.presenter?.loadNewQuestion()
            }
        )
        
        present(alert, animated: true)
    }
}

// MARK: - Actions
private extension GameViewController {

    @objc func optionTapped(_ sender: UIButton) {
        presenter?.checkAnswer(selectedId: sender.tag)
    }
}

// MARK: - Setup UI
private extension GameViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        
        questionLabel.textAlignment = .center
        questionLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        view.addSubview(questionLabel)
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func layoutButtons() {
        for (index, button) in optionButtons.enumerated() {
            if index == 0 {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 50)
                ])
            } else {
                NSLayoutConstraint.activate([
                    button.topAnchor.constraint(equalTo: optionButtons[index - 1].bottomAnchor, constant: 50)
                ])
            }
            
            NSLayoutConstraint.activate([
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                button.widthAnchor.constraint(equalToConstant: 250),
                button.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
    }
}
