//
//  VocaBookSelectViewModel.swift
//  VocaVocca
//
//  Created by Eden on 1/8/25.
//

import UIKit
import RxSwift
import RxCocoa


class VocaBookSelectViewModel {
    
    private let disposeBag = DisposeBag()
    
    let vocaBookSubject = BehaviorSubject(value: [VocaBookData]())
    
    var selectedVocaBook: PublishSubject<VocaBookData>
    var closeSubject: PublishSubject<Void>
    
    init(selectedVocaBook: PublishSubject<VocaBookData>, closeSubject: PublishSubject<Void>) {
        self.selectedVocaBook = selectedVocaBook
        self.closeSubject = closeSubject
    }
    
    func fetchVocaBookFromCoreData () {
        CoreDataManager.shared.fetchVocaBookData()
            .subscribe(onNext: { [weak self] vocaBookData in
                self?.vocaBookSubject.onNext(vocaBookData)
            }, onError: { error in
                self.vocaBookSubject.onError(error)
            }).disposed(by: disposeBag)
    }
    
    func test (_ vocaBookData: VocaBookData) {
        selectedVocaBook.onNext(vocaBookData)
    }
    
    func deleteVocaBook(_ vocaBook: VocaBookData) {
        CoreDataManager.shared.deleteVocaBookData(vocaBook: vocaBook)
            .subscribe(onCompleted: { [weak self] in
                
                // 삭제 후 데이터 갱신
                self?.fetchVocaBookFromCoreData()
            }, onError: { error in
                print("Error deleting VocaBook: \(error)")
            }).disposed(by: disposeBag)
    }
    
}
