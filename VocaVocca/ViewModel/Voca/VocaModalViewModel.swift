//
//  VocaModalViewModel.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import Foundation
import RxSwift
import RxCocoa

class VocaModalViewModel {
    
    // MARK: - Input
    
    let selectedVocaBook = PublishSubject<VocaBookData>()
    let word = BehaviorRelay<String>(value: "")
    let meaning = BehaviorRelay<String>(value: "")
    let completeSubject = PublishSubject<Void>()
    
    // MARK: - Output
    
    let isSaveEnabled: Observable<Bool>
    let title: Observable<String>
    let buttonTitle: Observable<String>
    
    private let coreDataManager = CoreDataManager.shared
    private let networkManager = NetworkManager.shared
    private let disposeBag = DisposeBag()
    
    private var thisVocaBook = VocaBookData()
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
    }
    func updateVocaBook(_ vocaBook: VocaBookData) {
        thisVocaBook = vocaBook
    }
    // 네트워크 매니저
    func fetchTranslation(for word: String) {
        networkManager
            .fetch(customURLComponents: .translation(text: word, lang: .english))
            .asObservable()
            .map { (response: TranslationsResponse) in
                print("API Response: \(response)")
                print("Translations: \(response.translations)")
                return response.translations.first?.text ?? "번역 실패"
            }
            .subscribe(onNext: { [weak self] translation in
                print("Translated Text: \(translation)")
                self?.meaning.accept(translation)
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
    func handleSave() {        
        let finalMeaning = meaning.value.isEmpty ? "값이 없어" : meaning.value
        
        print("단어 추가: \(word.value), 뜻: \(finalMeaning), 단어장: \(thisVocaBook)")
        coreDataManager.createVocaData(word: word.value, meaning: finalMeaning, book: thisVocaBook)
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
