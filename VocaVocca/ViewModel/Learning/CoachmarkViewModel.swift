//
//  CoachmarkViewModel.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import Foundation
import RxSwift
import RxRelay

class CoachmarkViewModel {
    
    var manager = UserDefaultsManager()
    var isSelected = BehaviorRelay<Bool>(value: false)
    var value = false
    
    func setCoachMarkDisabled() {
        manager.setCoachMarkDisabled()
    }
    
    func toggleSelection() {
        if value {
            isSelected.accept(false)
        } else {
            isSelected.accept(true)
        }
        value.toggle()
    }
}
