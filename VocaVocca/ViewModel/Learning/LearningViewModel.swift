//
//  LearningViewModel.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import RxSwift
import RxCocoa

class LearningViewModel {
    
    private let disposeBag = DisposeBag()
    
    let vocaBookSubject = BehaviorSubject(value: [VocaBookData]())
    let selectedVocaBook = BehaviorSubject<VocaBookData?>(value: nil)
    
    var data = [VocaBookData]()
    var index = 0
    
    init () {
        fetchVocaBookFromCoreData()
    }
    
    private func fetchVocaBookFromCoreData () {
        CoreDataManager.shared.fetchVocaBookData()
            .subscribe(onNext: { [weak self] vocaBookData in
                self?.vocaBookSubject.onNext(vocaBookData)
                self?.data = vocaBookData
                print(vocaBookData)
            }, onError: { error in
                self.vocaBookSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    
    // MARK: - 테스트 데이터 생성
    
    func addTestVocaBooks() {
        createTestVocaBookData()
            .subscribe(onCompleted: { [weak self] in
                self?.fetchVocaBookFromCoreData()
            })
            .disposed(by: disposeBag)
    }
    
    private func createTestVocaBookData() -> Completable {
        
        return Completable.zip(
            CoreDataManager.shared.createVocaBookData(title: "단어장"),
            CoreDataManager.shared.createVocaData(word: "hssss", meaning: "텍스트", language: Language.english.koreanTitle, book: data.last!),
            CoreDataManager.shared.createVocaData(word: "hssss", meaning: "테스트", language: Language.english.koreanTitle, book: data.last!),
            CoreDataManager.shared.createVocaData(word: "tdfas", meaning: "테스트2", language: Language.english.koreanTitle, book: data.last!),
            CoreDataManager.shared.createVocaData(word: "asfda", meaning: "테스트3", language: Language.english.koreanTitle, book: data.last!),
            CoreDataManager.shared.createVocaData(word: "asdf", meaning: "테스트4", language: Language.english.koreanTitle, book: data.last!)
        )
    }
    
    func changeIndex(_ index: Int) {
        self.index = index
    }
    
    func getData() -> VocaBookData {
        return data.first!
    }
}
