//
//  LearningResultViewModel.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import Foundation
import RxSwift

class LearningResultViewModel {
    let correctCount: BehaviorSubject<Int>
    let inCorrectCount: BehaviorSubject<Int>
    let correctRate: BehaviorSubject<Int>
    let closeSubject = PublishSubject<Bool>()
    
    init(learningResult: LearningResult) {
        let correctCount = learningResult.correctCount
        let inCorrectCount = learningResult.IncorrectCount
        self.correctCount = BehaviorSubject(value: correctCount)
        self.inCorrectCount = BehaviorSubject(value: inCorrectCount)
        
        let result = Float(correctCount) / Float(correctCount + inCorrectCount) * 100
        correctRate = BehaviorSubject(value: Int(result))
    }
    
    func closeAction() {
        closeSubject.onNext(true)
    }
}
