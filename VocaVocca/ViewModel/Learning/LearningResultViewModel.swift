//
//  LearningResultViewModel.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import Foundation

class LearningResultViewModel {
    let correctCount: Int
    let inCorrectCount: Int
    
    init(learningResult: LearningResult) {
        self.correctCount = learningResult.correctCount
        self.inCorrectCount = learningResult.IncorrectCount
    }
}
