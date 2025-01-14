//
//  Language.swift
//  VocaVocca
//
//  Created by mun on 1/9/25.
//

enum Language: Int, CaseIterable {
    case english = 0
    case chinese
    case japanese
    case german
    case spanish
    
    var title: String {
        switch self {
        case .english: return "EN"
        case .chinese: return "ZH"
        case .japanese: return "JA"
        case .german: return "DE"
        case .spanish: return "ES"
        }
    }
    
    var koreanTitle: String {
        switch self {
        case .english: return "영어"
        case .chinese: return "중국어"
        case .japanese: return "일본어"
        case .german: return "독일어"
        case .spanish: return "스페인어"
        }
    }
    
    // 한국어 이름과 코드 둘 다 처리
    init?(title: String) {
        for language in Language.allCases {
            if language.title.caseInsensitiveCompare(title) == .orderedSame ||
               language.koreanTitle.caseInsensitiveCompare(title) == .orderedSame {
                self = language
                return
            }
        }
        return nil
    }
}
