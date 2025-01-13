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
    
    let vocaBookSubject = BehaviorSubject(value: VocaBookData())
    
    init() {
        fetchVocaBookId()
        fetchVocaBook()
    }

    private func fetchVocaBookId() {
        if let uuidString = UserDefaults.standard.string(forKey: "chosenVocaBook"),
           let uuid = UUID(uuidString: uuidString) {
            print("uuid: \(uuid)")
            currentVocaBookId = uuid
        }
    }
    
    private func fetchVocaBook() {
        coreData.fetchVocaBookData()
            .subscribe(onNext: { [weak self] vocaBookData in
                
                guard let uuid = self?.currentVocaBookId else { return }
                
                for data in vocaBookData {
                    if data.id == uuid {
                        self?.vocaBookSubject.onNext(data)
                        
                        return
                    }
                }
                
            },onError: { error in
                self.vocaBookSubject.onError(error)
            }).disposed(by: disposeBag)
    }
}

