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

extension UserDefaultsManager {
    
    // 단어장 ID 저장
    func setVocaBookId(id: String) {
        UserDefaults.standard.set(UUID(uuidString: id),forKey: "chosenVocaBook")
    }
    
    // 저장된 단어장 ID 조회
    func getVocaBookID() -> String? {
        guard let id = UserDefaults.standard.string(forKey: "chosenVocaBook") else { return "" }
        return id
    }
    
}
