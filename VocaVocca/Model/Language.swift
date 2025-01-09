//
//  Language.swift
//  VocaVocca
//
//  Created by mun on 1/9/25.
//

enum Language {
    case english
    case chinese
    case japanese
    case german
    case spanish

    var title: String {
        switch self {
        case .english: return "EN"
        case .chinese: return "CH"
        case .japanese: return "JA"
        case .german: return "GE"
        case .spanish: return "SP"
        }
    }
}
