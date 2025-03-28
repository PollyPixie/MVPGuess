//
//  CharacterManager.swift
//  MVPGuess
//
//  Created by Полина Соколова on 28.03.25.
//

import Foundation

final class CharacterManager {
    
    private let characters: [Character] = [
        Character(id: 1, name: "Кот Матроскин", imageName: "Cat"),
        Character(id: 2, name: "Шарик", imageName: "Dog"),
        Character(id: 3, name: "Дядя Федор", imageName: "Fedor"),
        Character(id: 4, name: "Гена", imageName: "Gena"),
        Character(id: 5, name: "Чебурашка", imageName: "Cheburashka"),
        Character(id: 6, name: "Пятачек", imageName: "Pig"),
        Character(id: 7, name: "Винни-Пух", imageName: "ViniPuh"),
    ]
    
    func getRandomCharacters(count: Int) -> [Character] {
        characters.shuffled().prefix(count).map { $0 }
    }
}
