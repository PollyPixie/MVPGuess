//
//  GamePresenter.swift
//  MVPGuess
//
//  Created by Полина Соколова on 31.03.25.
//

import Foundation

// MARK: - IGamePresenter Protocol
protocol IGamePresenter {
    func loadNewQuestion()
    func checkAnswer(selectedId: Int)
    func getScore() -> Int
}

// MARK: - GamePresenter Class
final class GamePresenter {
    
    private weak var view: IGameViewController?
    private let characterManager: ICharacterManager
    
    private var currentOptions: [Character] = []
    private var correctCharacter: Character?
    
    private var score = 0
    
    init(view: IGameViewController, characterManager: ICharacterManager ) {
        self.view = view
        self.characterManager = characterManager
    }
}

// MARK: - IGamePresenter Conformance
extension GamePresenter: IGamePresenter {
    
    func loadNewQuestion() {
        currentOptions = characterManager.getRandomCharacters(count: 3)
        correctCharacter = currentOptions.randomElement()
        
        let question = "Кто это: \(correctCharacter?.name ?? "???")"
        let options = currentOptions.map {
            OptionViewModel(id: $0.id, imageName: $0.imageName)
        }
        let viewModel = GameViewModel(questionText: question, options: options)
        view?.render(viewModel: viewModel)
    }
    
    func checkAnswer(selectedId: Int) {
        let isCorrect = selectedId == correctCharacter?.id
        if isCorrect {
            score += 1
        } else {
            score = max(score - 1, 0)
        }
        view?.showResult(isCorrect: isCorrect, score: score)
    }
    
    func getScore() -> Int {
        score
    }
}
