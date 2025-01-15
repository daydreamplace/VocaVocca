//
//  FlashcardViewModel.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import Foundation
import RxSwift

class FlashcardViewModel {
    
    let isCoachMarkDisabled = BehaviorSubject(value: false) // 사용자가 코치마크를 비활성화했는지 여부
    let currentVoca: BehaviorSubject<VocaData?> // 현재 단어
    let currentIndex = BehaviorSubject(value: 0) // 현재 카드의 인덱스
    let totalVocaCount: BehaviorSubject<Int> // 전체 단어 수
    let learningResult = PublishSubject<LearningResult>()
    
    private let allVocaData: [VocaData] // 전체 단어 데이터
    private var currentIndexValue = 0 // 인덱스 변경을 위한 변수
    private var correctWords = [VocaData]() // 맞춘 단어 목록
    private var incorrectWords = [VocaData]() // 틀린 단어 목록
    
    private let disposeBag = DisposeBag()
    
    init(data: VocaBookData) {
        allVocaData = data.words?.allObjects as? [VocaData] ?? []
        totalVocaCount = BehaviorSubject(value: allVocaData.count)
        currentVoca = BehaviorSubject(value: allVocaData.first)
        checkIfCoachMarkShouldBeDisabled()
    }
    
    // 코치마크가 비활성화되었는지 확인
    private func checkIfCoachMarkShouldBeDisabled() {
        if UserDefaultsManager().isCoachMarkDisabled() {
            isCoachMarkDisabled.onNext(true)
        } else {
            isCoachMarkDisabled.onNext(false)
        }
    }
    
    // 맞은 단어 표시
    func markWordAsCorrect() {
        correctWords.append(allVocaData[currentIndexValue])
        moveToNextVoca()
    }
    
    // 틀린 단어 표시
    func markWordsAsIncorrect() {
        incorrectWords.append(allVocaData[currentIndexValue])
        moveToNextVoca()
    }
    
    // 다음 단어로 이동
    private func moveToNextVoca() {
        // 마지막 단어인지 확인
        if currentIndexValue + 1 == allVocaData.count {
            saveAllResults() // 결과 저장
            let reslut = LearningResult(correctCount: correctWords.count, IncorrectCount: incorrectWords.count)
            learningResult.onNext(reslut)
        } else {
            currentIndexValue += 1
            currentIndex.onNext(currentIndexValue)
            currentVoca.onNext(allVocaData[currentIndexValue])
        }
    }
    
    // 학습 결과 저장
    func saveAllResults() {
        correctWords.forEach {
            saveWordResult(voca: $0, isCorrected: true)
        }
        
        incorrectWords.forEach {
            saveWordResult(voca: $0, isCorrected: false)
        }
    }
    
    // 단어 하나씩 저장
    private func saveWordResult(voca: VocaData, isCorrected: Bool) {
        let todayDate = Date()

        if let recordwords = voca.recordwords,
           let recordDate = recordwords.date {
            // 단어에 저장된 기록이 있으면 update
            CoreDataManager.shared.updateRecordData(
                record: recordwords,
                isCorrected: isCorrected,
                date: todayDate
            )
                .subscribe(onCompleted: {})
                .disposed(by: disposeBag)
        } else {
            // 단어에 저장된 기록이 없으면 create
            CoreDataManager.shared.createRecordData(
                voca: voca,
                isCorrected: isCorrected,
                date: todayDate
            )
                .subscribe(onCompleted: {})
                .disposed(by: disposeBag)
        }
    }
}
