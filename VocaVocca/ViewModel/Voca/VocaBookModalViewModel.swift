//
//  VocaBookModalViewModel.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import Foundation
import RxSwift
import RxCocoa

enum Mode {
    case create
    case edit
}

struct VocaBook {
    let title: String
    let language: Language
}

class VocaBookModalViewModel {
    
    private let coreDataManager = CoreDataManager.shared
    private let disposeBag = DisposeBag()
    
    // MARK: - Input
    
    let vocaBookTitle = BehaviorRelay<String>(value: "")
    let selectedLanguage = BehaviorRelay<Language?>(value: nil)
    
    // MARK: - Output
    
    let isSaveEnabled: Observable<Bool>
    let title: Observable<String>
    let buttonTitle: Observable<String>
    
    // mode
    private let mode: Mode
    
    // init
    init(mode: Mode, initVocaBook: VocaBook? = nil) {
        self.mode = mode
        
        // 수정 모드에서 단어장 이름 초기화
        if let initVocaBook = initVocaBook, mode == .edit {
            vocaBookTitle.accept(initVocaBook.title)
            selectedLanguage.accept(initVocaBook.language)
        }
        
        // 저장 버튼 활성화 여부 결정?
        isSaveEnabled = Observable
            .combineLatest(vocaBookTitle.asObservable(), selectedLanguage.asObservable())
            .map { $0.isEmpty && $1 != nil}
        
        // 버튼, 텍스트
        title = Observable.just(mode == .create ? "단어장 만들기": "단어장 수정하기")
        buttonTitle = Observable.just(mode == .create ? "추가하기": "수정하기")
    }
    
    // selected language
    func selectedLanguage(_ language: Language) {
        selectedLanguage.accept(language)
    }
    
    // save edit
    func handleSaveOrEdit() {
        guard let language = selectedLanguage.value, !vocaBookTitle.value.isEmpty else { return }
        
        if mode == .create {
            // Core Data 단어장 추가
            coreDataManager.createVocaBookData(title: vocaBookTitle.value)
                .subscribe(
                    onCompleted: {
                        print("단어장을 추가: \(self.vocaBookTitle.value)")
                    },
                    onError: { error in
                        print("단어장 추가 실패: \(error)")
                    }
                ).disposed(by: disposeBag)
        } else {
            // Core Data 단어장 수정
            coreDataManager.fetchVocaBookData()
                .flatMap { books -> Observable<VocaBookData?> in
                    let bookToEdit = books.first { $0.title == self.vocaBookTitle.value }
                    return Observable.just(bookToEdit)
                }
                .compactMap { $0 }
                .flatMap { bookToEdit -> Observable<Void> in
                    return self.coreDataManager.updateVocaBookData(vocaBook: bookToEdit, newTitle: self.vocaBookTitle.value)
                        .andThen(Observable.just(()))
                }
                .subscribe(
                    onNext: { _ in
                        print("단어장을 수정: \(self.vocaBookTitle.value)")
                    },
                    onError: { error in
                        print("단어장 수정 실패: \(error)")
                    },
                    onCompleted: {
                        print("단어장 수정 완료")
                    }
                ).disposed(by: disposeBag)
        }
    }
}
