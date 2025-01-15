//
//  RecordViewModel.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import Foundation
import RxSwift
import RxCocoa

final class RecordViewModel {
    
    private let disposeBag = DisposeBag()
    private let coreDataManager = CoreDataManager.shared
    
    // 오늘 암기한 단어와 틀린 단어를 각각 저장할 BehaviorRelay
    let todayCorrectWords = BehaviorRelay<[VocaData]>(value: [])
    let todayIncorrectWords = BehaviorRelay<[VocaData]>(value: [])
    
    func fetchTodayRecords() {
        coreDataManager.fetchRecordData()
            .subscribe(onNext: { [weak self] records in
                guard let self = self else { return }
                
                // 오늘 날짜 기준으로 필터링
                let today = Calendar.current.startOfDay(for: Date())
                
                let filteredRecords = records.filter { record in
                    guard let recordDate = record.date else { return false }
                    return Calendar.current.isDate(recordDate, inSameDayAs: today)
                }
                
                // 암기한 단어와 틀린 단어로 분리
                let correctWords = filteredRecords
                    .filter { $0.iscorrected }
                    .compactMap { $0.voca }
                
                let incorrectWords = filteredRecords
                    .filter { !$0.iscorrected }
                    .compactMap { $0.voca }
                
                // BehaviorRelay에 데이터 전달
                self.todayCorrectWords.accept(correctWords)
                self.todayIncorrectWords.accept(incorrectWords)
            }, onError: { error in
                print("Error fetching records: \(error)")
            })
            .disposed(by: disposeBag)
    }
}
