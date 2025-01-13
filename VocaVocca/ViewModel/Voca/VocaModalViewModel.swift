//
//  VocaModalViewModel.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import Foundation
import RxSwift
import RxCocoa

struct TranslationResponse: Decodable {
    let translations: [Translation]
    
    struct Translation: Decodable {
        let translatedText: String
    }
}

class VocaModalViewModel {
    
    // MARK: - Input
    
    let selectedVocaBook = BehaviorRelay<VocaBookData?>(value: nil)
    let word = BehaviorRelay<String>(value: "")
    let meaning = BehaviorRelay<String>(value: "")
    
    
    // MARK: - Output
    
    let isSaveEnabled: Observable<Bool>
    let title: Observable<String>
    let buttonTitle: Observable<String>
    
    private let coreDataManager = CoreDataManager.shared
    private let networkManager = NetworkManager.shared
    private let disposeBag = DisposeBag()
    
    // Initialization
    init() {
        // 저장 버튼 활성화 여부 결정
        isSaveEnabled = Observable
            .combineLatest(word.asObservable(), meaning.asObservable(), selectedVocaBook.asObservable())
            .map { !$0.isEmpty && !$1.isEmpty && $2 != nil }
        
        // 화면 타이틀과 버튼 텍스트 설정
        title = Observable.just("새로운 단어 만들기")
        buttonTitle = Observable.just("추가하기")
    }
    
    // 네트워크 매니저
    private func bindMeaningToPlaceholder() {
        word
            .distinctUntilChanged()
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance)
            .flatMapLatest { [weak self] word -> Observable<String> in
                guard let self = self, !word.isEmpty else {
                    return Observable.just("")
                }
                return self.fetchTranslation(for: word)
            }
            .bind(to: meaning)
            .disposed(by: disposeBag)
    }
    
    private func fetchTranslation(for word: String) -> Observable<String> {
        return networkManager
            .fetch(customURLComponents: .translation(text: word, lang: .english))
            .asObservable()
            .map { (response: TranslationResponse) in
                response.translations.first?.translatedText ?? "번역 실패"
            }
            .catchAndReturn("번역 실패")
    }
    
    // CoreData 단어 업데이트
    func handleSave() {
        guard let vocaBook = selectedVocaBook.value, !word.value.isEmpty, !meaning.value.isEmpty else {
            print("입력값이 부족합니다.")
            return
        }
        
        print("단어 추가: \(word.value), 뜻: \(meaning.value), 단어장: \(vocaBook.title ?? "알 수 없음")")
        coreDataManager.createVocaData(word: word.value, meaning: meaning.value, language: "EN", book: vocaBook)
            .subscribe(
                onCompleted: {
                    print("단어가 성공적으로 추가되었습니다.")
                },
                onError: { error in
                    print("단어 추가 실패: \(error)")
                }
            ).disposed(by: disposeBag)
    }
}
