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
        
    }
}
