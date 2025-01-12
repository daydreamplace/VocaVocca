//
//  UserDefaultsManager.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit

class UserDefaultsManager: NSObject {

    private let key = "isCoachMarkEnabled"

    // 코치마크를 비활성화로 설정
    func setCoachMarkDisabled() {
        UserDefaults.standard.set(true, forKey: key)
    }

    // 코치마크가 활성화 되어 있는지 확인
    func isCoachMarkDisabled() -> Bool {
        return UserDefaults.standard.bool(forKey: key)
    }
}
