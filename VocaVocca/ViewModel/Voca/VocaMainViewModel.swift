//
//  VocaMainViewModel.swift
//  VocaVocca
//
//  Created by 안준경 on 1/8/25.
//

import RxSwift
import RxCocoa
import CoreData

class VocaMainViewModel {
    
    private var currentVocaBookId = UUID()
    private let coreData = CoreDataManager.shared
    private let disposeBag = DisposeBag()
    private let manager = UserDefaultsManager()
    private var thisVocaBook = VocaBookData()

    
    let selectedvocaBook = PublishSubject<VocaBookData>()
    let updateSubject = PublishSubject<Void>()
    let vocaSubject = BehaviorSubject(value: [VocaData]())

    init() {
//        fetchVocaBookId()
        fetchVocaBook()
    }
    
    func updateVocaBook(_ vocaBook: VocaBookData) {
        thisVocaBook = vocaBook
    }
    
    func updateVoca() {
        fetchVocaBookId()
    }
    
    // MARK: - 단어장 ID 조회
    
    private func fetchVocaBookId() {
        coreData.fetchVocaBookData()
            .subscribe(onNext: { [weak self] vocaBookData in
                let voca = vocaBookData
                    .filter { [weak self] vocaBook in
                        vocaBook.id == self?.thisVocaBook.id}
                //.compactMap { $0.words }
                
                if let wordsSet = voca.first!.words as? Set<VocaData> {
                    let array = Array(wordsSet)
                    
                    self?.vocaSubject.onNext(array)
                }
            })
    }
    
    // MARK: - 단어 조회
    
    private func fetchVocaBook() {
        coreData.fetchVocaBookData()
            .subscribe(onNext: { [weak self] vocaBookData in
                
                //TODO: 단어선택화면 구현시 수정 예정
                guard let voca = vocaBookData.first else { return }
                
                if let wordsSet = voca.words as? Set<VocaData> {
                    let array = Array(wordsSet)
                    
                    self?.vocaSubject.onNext(array)
                }
                
            },onError: { error in
                self.vocaSubject.onError(error)
            }).disposed(by: disposeBag)
    }
}
