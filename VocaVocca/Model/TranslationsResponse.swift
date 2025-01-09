//
//  TranslationsResponse.swift
//  VocaVocca
//
//  Created by mun on 1/9/25.
//

struct TranslationsResponse: Decodable {
    let translations: [Translations]
}

extension TranslationsResponse {
    struct Translations: Decodable {
        let language: String
        let text: String

        enum CodingKeys: String, CodingKey {
            case text
            case language = "detected_source_language"
        }
    }
}
