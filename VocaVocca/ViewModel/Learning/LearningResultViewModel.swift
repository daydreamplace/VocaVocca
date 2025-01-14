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
    let filledBeanCount: Observable<Int> // 커피콩 개수
    
    init(learningResult: LearningResult) {
        let correctCount = learningResult.correctCount
        let inCorrectCount = learningResult.IncorrectCount
        self.correctCount = BehaviorSubject(value: correctCount)
        self.inCorrectCount = BehaviorSubject(value: inCorrectCount)
        
        let result = Float(correctCount) / Float(correctCount + inCorrectCount) * 100
        correctRate = BehaviorSubject(value: Int(result))
        
        // 커피콩 개수 계산 (10%마다 1개)
        self.filledBeanCount = correctRate
            .map { result in
                return result / 10
            }
    }
    
    func closeAction() {
        closeSubject.onNext(true)
    }
}
