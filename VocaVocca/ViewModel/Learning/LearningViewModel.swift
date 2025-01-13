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
    
    init () {
        fetchVocaBookFromCoreData()
    }
    
    private func fetchVocaBookFromCoreData () {
        CoreDataManager.shared.fetchVocaBookData()
            .subscribe(onNext: { [weak self] vocaBookData in
                self?.vocaBookSubject.onNext(vocaBookData)
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
            CoreDataManager.shared.createVocaBookData(title: "토익"),
            CoreDataManager.shared.createVocaBookData(title: "중국어 기초"),
            CoreDataManager.shared.createVocaBookData(title: "일본어 공부")
        )
    }
}
