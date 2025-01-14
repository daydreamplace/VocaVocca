//
//  LearningViewModel.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import RxSwift
import RxCocoa

enum SelectionError {
    case noSelect
    case noVoca
    
    var text: String {
        switch self {
        case .noSelect:
            return "단어장을 선택해주세요."
        case .noVoca:
            return "단어장에 단어가 없습니다."
        }
    }
}

class LearningViewModel {
    
    private let disposeBag = DisposeBag()
    
    let vocaBookSubject = BehaviorSubject(value: [VocaBookData]())
    var selectedVocaBook: VocaBookData?
    let vocaBookSelectionError = BehaviorSubject(value: SelectionError.noSelect)
    let navigateToFlashCard = PublishSubject<VocaBookData>()
    var data = [VocaBookData]()
    
    init () {
        fetchVocaBookFromCoreData()
    }
    
    // 보카북 상태 확인
    func handleVocaBookSelection() {
        // 선택된 보카북이 없으면 noSelect 방출
        guard let selectedBook = selectedVocaBook else {
            vocaBookSelectionError.onNext(SelectionError.noSelect)
            return
        }
        // 단어가 있는지 확인
        if hasWordsInVocaBook() {
            navigateToFlashCard.onNext(selectedBook)
        } else {
            vocaBookSelectionError.onNext(SelectionError.noVoca)

        }
    }
    
    // 단어장에 단어가 있는지 확인
    func hasWordsInVocaBook() -> Bool {
        guard let selectedBook = selectedVocaBook else { return false }
        return selectedBook.words?.count ?? 0 > 0
    }
    
    private func fetchVocaBookFromCoreData () {
        CoreDataManager.shared.fetchVocaBookData()
            .subscribe(onNext: { [weak self] vocaBookData in
                self?.vocaBookSubject.onNext(vocaBookData)
                self?.data = vocaBookData
            }, onError: { error in
                self.vocaBookSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    
    // MARK: - 테스트 데이터 생성
    
    func addTestVocaBooks() {
        createTestVocaBookData()
            .andThen(fetchVocaBookFromCoreDataCompletable())
            .andThen(addTestVocaData())
            .subscribe(onCompleted: {
                print("테스트 단어장 및 단어 생성 완료")
            })
            .disposed(by: disposeBag)
    }
    
    // 테스트 단어장 생성
    private func createTestVocaBookData() -> Completable {
        return CoreDataManager.shared.createVocaBookData(title: "테스트 단어장")
    }
    
    // 테스트 단어 추가
    private func addTestVocaData() -> Completable {
        guard let firstBook = data.randomElement() else {
            return Completable.error(NSError(domain: "단어장을 찾을 수 없습니다.", code: -1, userInfo: nil))
        }
        
        return Completable.zip(
            CoreDataManager.shared.createVocaData(word: "apple", meaning: "사과", language: Language.english.koreanTitle, book: firstBook),
            CoreDataManager.shared.createVocaData(word: "banana", meaning: "바나나", language: Language.english.koreanTitle, book: firstBook),
            CoreDataManager.shared.createVocaData(word: "cat", meaning: "고양이", language: Language.english.koreanTitle, book: firstBook),
            CoreDataManager.shared.createVocaData(word: "dog", meaning: "개", language: Language.english.koreanTitle, book: firstBook)
        )
    }
    
    // Core Data 동기화
    private func fetchVocaBookFromCoreDataCompletable() -> Completable {
        return Completable.create { [weak self] completable in
            self?.fetchVocaBookFromCoreData()
            completable(.completed)
            return Disposables.create()
        }
    }
}
