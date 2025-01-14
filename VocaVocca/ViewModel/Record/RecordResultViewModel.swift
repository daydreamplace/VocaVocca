//
//  RecordResultViewModel.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import Foundation
import RxSwift
import RxCocoa

final class RecordResultViewModel {
    
    let correctWords: BehaviorRelay<[(String, String)]> = BehaviorRelay(value: [])
    let incorrectWords: BehaviorRelay<[(String, String)]> = BehaviorRelay(value: [])
    
    private let disposeBag = DisposeBag()
    
    init(recordViewModel: RecordViewModel) {
        // RecordViewModel에서 데이터를 가져옴
        recordViewModel.todayCorrectWords
            .map { $0.map { ($0.word ?? "", $0.meaning ?? "") } }
            .bind(to: correctWords)
            .disposed(by: disposeBag)
        
        recordViewModel.todayIncorrectWords
            .map { $0.map { ($0.word ?? "", $0.meaning ?? "") } }
            .bind(to: incorrectWords)
            .disposed(by: disposeBag)
    }
}
