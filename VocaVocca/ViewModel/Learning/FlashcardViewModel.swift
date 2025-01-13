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
    let isLastVoca: BehaviorSubject<Bool> // 마지막 단어인지 여부
    
    private let allVocaData: [VocaData] // 전체 단어 데이터
    private var currentIndexValue = 0 // 인덱스 변경을 위한 변수
    private var correctWords = [VocaData]() // 맞춘 단어 목록
    private var incorrectWords = [VocaData]() // 틀린 단어 목록
    
    init(data: VocaBookData) {
        allVocaData = data.words?.allObjects as? [VocaData] ?? []
        totalVocaCount = BehaviorSubject(value: allVocaData.count)
        currentVoca = BehaviorSubject(value: allVocaData.first)
        isLastVoca = BehaviorSubject(value: currentIndexValue == allVocaData.count ? true : false)
        checkIfCoachMarkShouldBeDisabled()
    }
    
    private func checkIfCoachMarkShouldBeDisabled() {
        if UserDefaultsManager().isCoachMarkDisabled() {
            isCoachMarkDisabled.onNext(true)
        } else {
            isCoachMarkDisabled.onNext(false)
        }
    }
    
    func markWordAsCorrect() {
        moveToNextVoca()
        correctWords.append(allVocaData[currentIndexValue - 1])
    }
    
    func markWordsAsIncorrect() {
        moveToNextVoca()
        incorrectWords.append(allVocaData[currentIndexValue - 1])
    }
    
    private func moveToNextVoca() {
        currentIndexValue += 1
        currentIndex.onNext(currentIndexValue)
        currentVoca.onNext(allVocaData[currentIndexValue])
        isLastVoca.onNext(currentIndexValue + 1 == allVocaData.count)
    }
    
    // 정답 결과 저장
    func saveResults() {
        print("correctWords")
        print(correctWords)
        print("incorrectWords")
        print(incorrectWords)
        correctWords.forEach {
            CoreDataManager.shared.createRecordData(voca: $0, isCorrected: true, date: Date())
        }
        
        incorrectWords.forEach {
            CoreDataManager.shared.createRecordData(voca: $0, isCorrected: false, date: Date())
        }
    }
}
