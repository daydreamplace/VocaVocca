//
//  VocaModalViewModel.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import Foundation
import RxSwift
import RxCocoa

enum CreateVocaError {
    case noSelect
    case noWord
    case noMeaning
    case noMatch
    
    var text: String {
        switch self {
        case .noSelect:
            return "단어장을 선택해주세요."
        case .noWord:
            return "단어를 입력해주세요."
        case .noMeaning:
            return "뜻을 입력해주세요."
        case .noMatch:
            return "일치하는 단어가 없습니다."
        }
    }
}

class VocaModalViewModel {
    
    // MARK: - Input
    
    let selectedVocaBook = BehaviorRelay<VocaBookData?>(value: nil)
    let word = BehaviorRelay<String>(value: "")
    let meaning = BehaviorRelay<String>(value: "")
    let completeSubject = PublishSubject<Void>()
    let closeSubject: PublishSubject<Void>
    let createVocaError = PublishSubject<CreateVocaError>()
    
    // MARK: - Output
    
    let isSaveEnabled: Observable<Bool>
    let title: Observable<String>
    let buttonTitle: Observable<String>
    
    private let coreDataManager = CoreDataManager.shared
    private let networkManager = NetworkManager.shared
    private let disposeBag = DisposeBag()
    
    var wordValue = ""
    var meaningValue = ""
    var thisVocaBook: VocaBookData?
    var testData = [VocaBookData]()
    
    // Initialization
    init(closeSubject: PublishSubject<Void>) {
        self.closeSubject = closeSubject
        // 저장 버튼 활성화 여부 결정
        isSaveEnabled = Observable
            .combineLatest(word.asObservable(), meaning.asObservable(), selectedVocaBook.asObservable())
            .map { !$0.isEmpty && !$1.isEmpty && $2 != nil }
        
        // 화면 타이틀과 버튼 텍스트 설정
        title = Observable.just("새로운 단어 만들기")
        buttonTitle = Observable.just("추가하기")
    }
    
    func updateVocaBook(_ vocaBook: VocaBookData) {
        thisVocaBook = vocaBook
    }

    
    func save() {
        // 단어장을 선택했는지 확인
        guard let thisVocaBook = thisVocaBook else {
            return
        }
            
        coreDataManager.createVocaData(word: wordValue, meaning: meaningValue, book: thisVocaBook)
            .subscribe(
                onCompleted: {
                    print("단어가 성공적으로 추가되었습니다.")
                },
                onError: { error in
                    print("단어 추가 실패: \(error)")
                }
            ).disposed(by: disposeBag)
        closeSubject.onNext(())
    
    }
    
    // 네트워크 매니저
    func fetchTranslation(for word: String, language: Language) {
        networkManager
            .fetch(customURLComponents: .translation(text: word, lang: language))
            .asObservable()
            .map { (response: TranslationsResponse) -> String in
                print("API Response: \(response)")
                return response.translations.first?.text ?? "번역 실패"
            }
            .subscribe(onNext: { [weak self] (translation: String) in
                if translation == self?.wordValue {
                    self?.createVocaError.onNext(CreateVocaError.noMatch)
                } else {
                    print("Translated Text: \(translation)")
                    self?.meaningValue = translation
                    self?.meaning.accept(translation)
                }

            })
            .disposed(by: disposeBag)
    }
    
    func fetchVocaBookFromCoreData() {
        coreDataManager.fetchVocaBookData()
            .subscribe(onNext: { [weak self] vocaBookData in
                self?.testData = vocaBookData
                print("Fetched vocaBookData: \(vocaBookData)")
            }, onError: { error in
                print("Error: \(error)")
            }).disposed(by: disposeBag)
    }
    
    // CoreData 단어 업데이트
    func checkStatus() {
        guard let thisVocaBook = thisVocaBook else {
            createVocaError.onNext(CreateVocaError.noSelect)
            return
        }
        
        if wordValue == "" {
            createVocaError.onNext(CreateVocaError.noWord)
            return
        }
        
        if meaningValue == "" {
            createVocaError.onNext(CreateVocaError.noMeaning)
            return
        }
        
        save()
    }
}
