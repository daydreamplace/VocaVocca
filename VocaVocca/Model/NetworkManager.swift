//
//  NetworkManager.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import Foundation
import RxSwift

class NetworkManager {

    static let shared = NetworkManager()
    private init() {}

    func fetch<T: Decodable>(customURLComponents: CustomURLComponents) -> Single<T> {
        return Single.create { [weak self] single in

            guard let self = self,
                  let url = self.createURL(customURLComponents) else {
                single(.failure(NetworkError.invalidURL)) // URL 에러 전달
                return Disposables.create()
            }

            let session = URLSession(configuration: .default)
            // 네트워크 요청
            session.dataTask(with: URLRequest(url: url)) { data, response, error in
                if let error = error {
                    single(.failure(error)) // 에러 전달
                    return
                }

                guard let data = data else {
                    single(.failure(NetworkError.noData)) // 데이터 에러 전달
                    return
                }

                guard let response = response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode) else {
                    single(.failure(NetworkError.dataFetchFail)) // 데이터패치 에러 전달
                    return
                }

                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    single(.success(decodedData)) // 성공 이벤트 전달
                } catch {
                    single(.failure(NetworkError.decodingFail)) // 디코딩 에러 전달
                }
            }.resume()

            return Disposables.create()
        }
    }

    // URL 생성 메서드
    private func createURL(_ customURLComponents: CustomURLComponents) -> URL? {

        var urlComponents = URLComponents()
        var queryItems = [URLQueryItem]()

        urlComponents.scheme = customURLComponents.scheme
        urlComponents.host = customURLComponents.host
        urlComponents.path = customURLComponents.path

        customURLComponents.querys.forEach { key, value in
            queryItems.append(URLQueryItem(name: key, value: value))
        }

        urlComponents.queryItems = queryItems

        //URL 생성
        guard let url = urlComponents.url else {
            return nil
        }

        return url
    }
}

extension NetworkManager {
    // 네트워크 에러
    enum NetworkError: Error {
        case invalidURL
        case noData
        case dataFetchFail
        case decodingFail
    }

    // URLComponents
    enum CustomURLComponents {
        case translation(text: String, lang: Language)

        var scheme: String {
            return "https"
        }
        var host: String {
            return "api-free.deepl.com"
        }
        var path: String {
            return "/v2/translate"
        }
        var querys: [String: String] {
            switch self {
            case .translation(let text, let lang):
                return [
                    "text": text,
                    "source_lang": lang.title,
                    "target_lang": "KO",
                    "auth_key": Bundle.main.infoDictionary?["APIKey"] as? String ?? ""
                ]
            }
        }
    }
}
