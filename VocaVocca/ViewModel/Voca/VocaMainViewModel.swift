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
    
    let vocaBookSubject = BehaviorSubject(value: [VocaData]())
    
    init() {
//        fetchVocaBookId()
        fetchVocaBook()
    }
    
    // MARK: - 단어장 ID 조회
    
    private func fetchVocaBookId() {
        if let uuidString = manager.getVocaBookID(),
           let uuid = UUID(uuidString: uuidString) {
            currentVocaBookId = uuid
        }
    }
    
    // MARK: - 단어 조회
    
    private func fetchVocaBook() {
        coreData.fetchVocaBookData()
            .subscribe(onNext: { [weak self] vocaBookData in
                
                //TODO: 단어선택화면 구현시 수정 예정
                let voca = vocaBookData.first!
                
                if let wordsSet = voca.words as? Set<VocaData> {
                    let array = Array(wordsSet)
                    
                    self?.vocaBookSubject.onNext(array)
                    
                    
                }
                
            },onError: { error in
                self.vocaBookSubject.onError(error)
            }).disposed(by: disposeBag)
    }
}
