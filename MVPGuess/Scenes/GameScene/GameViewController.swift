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
}

// MARK: - GameViewController Class
final class GameViewController: UIViewController {
    
    var presenter: IGamePresenter?
    
    private let questionLabel = UILabel()
    private let buttons: [UIButton] = [UIButton(), UIButton(), UIButton()]
    private let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupButtons()
        presenter?.loadNewQuestion()
    }
}

// MARK: - IGameViewController Conformance
extension GameViewController: IGameViewController {
    
    func render(viewModel: GameViewModel) {
        questionLabel.text = viewModel.questionText
        
        for (index, option) in viewModel.options.enumerated() {
            let button = buttons[index]
            button.setImage(UIImage(named: option.imageName), for: .normal)
            button.tag = option.id
        }
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
        
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 30),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func setupButtons() {
        for (index, button) in buttons.enumerated() {
            button.tag = index
            button.backgroundColor = .white
            button.clipsToBounds = true
            button.layer.cornerRadius = 8
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
            button.imageView?.contentMode = .scaleAspectFit
            button.translatesAutoresizingMaskIntoConstraints = false
            
            button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
            stackView.addArrangedSubview(button)
            
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 250),
                button.heightAnchor.constraint(equalToConstant: 100)
            ])
        }
    }
}
