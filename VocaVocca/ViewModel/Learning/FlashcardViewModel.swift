//
//  FlashcardViewModel.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import Foundation
import RxSwift

class FlashcardViewModel {

    var manager = UserDefaultsManager()
    var subject = PublishSubject<Bool>()

    func isCoachMarkDisabled() {
        if manager.isCoachMarkDisabled() {
            subject.onNext(true)
        } else {
            subject.onNext(false)
        }
    }

}
