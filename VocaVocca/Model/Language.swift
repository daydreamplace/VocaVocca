//
//  Language.swift
//  VocaVocca
//
//  Created by mun on 1/9/25.
//

enum Language: Int {
    case english = 0
    case chinese // 중국어(번체)
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
}
