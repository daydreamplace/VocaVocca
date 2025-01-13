//
//  VocaModalViewModel.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import Foundation
import RxSwift
import RxCocoa


// TODO: - 삭제
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
    
    var testData = [VocaBookData]()
    
    // Initialization
    init() {
        // 저장 버튼 활성화 여부 결정
        isSaveEnabled = Observable
            .combineLatest(word.asObservable(), meaning.asObservable(), selectedVocaBook.asObservable())
            .map { !$0.isEmpty && !$1.isEmpty && $2 != nil }
        
        // 화면 타이틀과 버튼 텍스트 설정
        title = Observable.just("새로운 단어 만들기")
        buttonTitle = Observable.just("추가하기")
        
        // 단어 입력 시 meaning 플레이스홀더 업데이트
        bindMeaningToPlaceholder()
    }
    
    private func bindMeaningToPlaceholder() {
        word
            .distinctUntilChanged()
            .debounce(.milliseconds(300), scheduler: MainScheduler.instance) // 입력 간 딜레이
            .flatMapLatest { [weak self] word -> Observable<String> in
                guard let self = self, !word.isEmpty else {
                    return Observable.just("") // 빈 값 처리
                }
                return self.fetchTranslation(for: word)
            }
            .observe(on: MainScheduler.instance)
            .bind(to: meaning)
            .disposed(by: disposeBag)
    }
    
    // 네트워크 매니저
    func fetchTranslation(for word: String) -> Observable<String> {
        return networkManager
            .fetch(customURLComponents: .translation(text: word, lang: .english))
            .asObservable()
            .map { (response: TranslationResponse) in
                response.translations.first?.translatedText ?? "번역 실패"
            }
            .catchAndReturn("번역 실패")
    }
    
    // CoreData 단어 업데이트
    func testVocaBook () -> Completable {
        coreDataManager.createVocaBookData(title: "토익")
    }
    
    func fetchVocaBookFromCoreData () {
        testVocaBook()
            .subscribe(onCompleted: {
                print("444")
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
        coreDataManager.fetchVocaBookData()
            .subscribe(onNext: { [weak self] vocaBookData in
                self?.testData = vocaBookData
                print("222", vocaBookData)
            }, onError: { error in
                print(error)
            }).disposed(by: disposeBag)
    }
    
    func handleSave() {
        //        guard let vocaBook = selectedVocaBook.value, !word.value.isEmpty, !meaning.value.isEmpty else {
        //            print("입력값이 부족합니다.")
        //            return
        //        }
        
        print("111", testData)
        guard let vocaBooktestData = testData.first else { return }
        
        print("단어 추가: \(word.value), 뜻: \(meaning.value), 단어장: \(vocaBooktestData)")
        coreDataManager.createVocaData(word: word.value, meaning: meaning.value, language: "EN", book: vocaBooktestData)
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
