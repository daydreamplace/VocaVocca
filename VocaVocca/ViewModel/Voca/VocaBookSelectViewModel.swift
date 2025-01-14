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
   
    init(selectedVocaBook: PublishSubject<VocaBookData>) {
        self.selectedVocaBook = selectedVocaBook
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
        print("단어장 변경 ")
        print(vocaBookData)
    }
}
