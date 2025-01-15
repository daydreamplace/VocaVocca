//
//  Language.swift
//  VocaVocca
//
//  Created by mun on 1/9/25.
//
import UIKit

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

     var color: UIColor {
         switch self {
         case .english: return UIColor.customDarkBrown
         case .chinese: return #colorLiteral(red: 0.5567010309, green: 0.09993243847, blue: 0.3203412696, alpha: 1)
         case .japanese: return #colorLiteral(red: 0.2067442318, green: 0.1499480374, blue: 0.5567010309, alpha: 1)
         case .german: return #colorLiteral(red: 0.6030927835, green: 0.3187921189, blue: 0.4248369067, alpha: 1)
         case .spanish: return #colorLiteral(red: 0.4092615847, green: 0.2955686631, blue: 0.5360824742, alpha: 1)
         }
     }
}
