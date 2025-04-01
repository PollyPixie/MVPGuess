//
//  GameViewModel.swift
//  MVPGuess
//
//  Created by Полина Соколова on 31.03.25.
//
import Foundation

struct OptionViewModel {
    let id: Int
    let imageName: String
}

struct GameViewModel {
    let questionText: String
    let options: [OptionViewModel]
}

