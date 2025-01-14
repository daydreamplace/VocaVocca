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
    
    let correctWords: Observable<[(String, String)]>
    let incorrectWords: Observable<[(String, String)]>
    
    init(correctWords: Observable<[(String, String)]>, incorrectWords: Observable<[(String, String)]>) {
        self.correctWords = correctWords
        self.incorrectWords = incorrectWords
    }
}
