//
//  Language.swift
//  VocaVocca
//
//  Created by mun on 1/9/25.
//

enum Language: String, CaseIterable {
    case english = "EN"
    case chinese = "ZH"
    case japanese = "JA"
    case german = "DE"
    case spanish = "ES"
    
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
}
