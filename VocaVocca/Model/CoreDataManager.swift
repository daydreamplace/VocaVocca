//
//  CoreDataManager.swift
//  VocaVocca
//
//  Created by 강민성 on 1/8/25.
//

import CoreData
import RxSwift

class CoreDataManager {
    
    static let shared = CoreDataManager()
    // NSPersistentContainer: Core Data 스택을 초기화하고 데이터 모델 파일을 관리.
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "VocaVocca") // 데이터 모델 이름.
        container.loadPersistentStores { _, error in
            // 저장소 로드 중 에러 발생 시 앱 종료.
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // NSManagedObjectContext: Core Data에서 데이터를 읽고 쓰기 위해 사용.
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // 변경사항을 저장하는 메서드.
    func saveContext() -> Completable {
        return Completable.create { [weak self] completable in
            guard let self = self else {
                // self가 nil이면 에러 반환.
                completable(.error(NSError(domain: "CoreDataManager", code: -1, userInfo: nil)))
                return Disposables.create()
            }
            // context에 변경사항이 있을 경우 저장.
            if self.context.hasChanges {
                do {
                    try self.context.save()
                    completable(.completed) // 저장 성공 시 완료.
                } catch {
                    completable(.error(error)) // 저장 실패 시 에러 반환.
                }
            } else {
                completable(.completed) // 변경사항이 없으면 완료.
            }
            return Disposables.create()
        }
    }
    
    // MARK: - CRUD for VocaData
    
    // 새로운 VocaData를 생성하는 메서드
    func createVocaData(word: String, meaning: String, language: String) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self = self else {
                completable(.error(NSError(domain: "CoreDataManager", code: -1, userInfo: nil)))
                return Disposables.create()
            }
            // 새로운 VocaData 객체 생성 및 초기화.
            let voca = VocaData(context: self.context)
            voca.id = UUID()
            voca.word = word
            voca.meaning = meaning
            voca.language = language
            completable(.completed)
            return Disposables.create()
        }.concat(self.saveContext()) // 생성 후 변경사항 저장.
    }
    
    // VocaData를 가져오는 메서드.
    func fetchVocaData() -> Observable<[VocaData]> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(NSError(domain: "CoreDataManager", code: -1, userInfo: nil))
                return Disposables.create()
            }
            let request: NSFetchRequest<VocaData> = VocaData.fetchRequest()
            do {
                let data = try self.context.fetch(request)
                observer.onNext(data) // 데이터를 next로 전달.
                observer.onCompleted() // 작업 완료.
            } catch {
                observer.onError(error) // 에러 발생 시 전달.
            }
            return Disposables.create()
        }
    }
    
    // VocaData를 업데이트하는 메서드.
    func updateVocaData(voca: VocaData, newWord: String, newMeaning: String, newLanguage: String) -> Completable {
        return Completable.create { completable in
            // 기존 VocaData 수정.
            voca.word = newWord
            voca.meaning = newMeaning
            voca.language = newLanguage
            completable(.completed)
            return Disposables.create()
        }.concat(self.saveContext()) // 변경사항 저장.
    }
    
    // VocaData를 삭제하는 메서드.
    func deleteVocaData(voca: VocaData) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self = self else {
                completable(.error(NSError(domain: "CoreDataManager", code: -1, userInfo: nil)))
                return Disposables.create()
            }
            self.context.delete(voca) // 데이터 삭제.
            completable(.completed)
            return Disposables.create()
        }.concat(self.saveContext()) // 변경사항 저장.
    }
    
    // MARK: - CRUD for VocaBookData
    
    // 새로운 VocaBookData를 생성하는 메서드.
    func createVocaBookData(title: String, words: [VocaData]) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self = self else {
                completable(.error(NSError(domain: "CoreDataManager", code: -1, userInfo: nil)))
                return Disposables.create()
            }
            // 새로운 VocaBookData 객체 생성 및 초기화.
            let vocaBook = VocaBookData(context: self.context)
            vocaBook.id = UUID()
            vocaBook.title = title
            // words 배열을 Data로 변환하여 저장.
            vocaBook.words = try? NSKeyedArchiver.archivedData(withRootObject: words, requiringSecureCoding: false) as NSObject
            completable(.completed)
            return Disposables.create()
        }.concat(self.saveContext()) // 생성 후 변경사항 저장.
    }
    
    // VocaBookData를 가져오는 메서드.
    func fetchVocaBookData() -> Observable<[VocaBookData]> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(NSError(domain: "CoreDataManager", code: -1, userInfo: nil))
                return Disposables.create()
            }
            let request: NSFetchRequest<VocaBookData> = VocaBookData.fetchRequest()
            do {
                let data = try self.context.fetch(request)
                observer.onNext(data)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    // VocaBookData를 업데이트하는 메서드.
    func updateVocaBookData(vocaBook: VocaBookData, newTitle: String, newWords: [VocaData]) -> Completable {
        return Completable.create { completable in
            vocaBook.title = newTitle
            vocaBook.words = try? NSKeyedArchiver.archivedData(withRootObject: newWords, requiringSecureCoding: false) as NSObject
            completable(.completed)
            return Disposables.create()
        }.concat(self.saveContext()) // 변경사항 저장.
    }
    
    // VocaBookData를 삭제하는 메서드.
    func deleteVocaBookData(vocaBook: VocaBookData) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self = self else {
                completable(.error(NSError(domain: "CoreDataManager", code: -1, userInfo: nil)))
                return Disposables.create()
            }
            self.context.delete(vocaBook)
            completable(.completed)
            return Disposables.create()
        }.concat(self.saveContext())
    }
    
    // MARK: - CRUD for RecordData
    
    // 새로운 RecordData를 생성하는 메서드.
    func createRecordData(correctWords: [VocaData], wrongWords: [VocaData], date: Date) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self = self else {
                completable(.error(NSError(domain: "CoreDataManager", code: -1, userInfo: nil)))
                return Disposables.create()
            }
            // 새로운 RecordData 객체 생성 및 초기화
            let record = RecordData(context: self.context)
            record.id = UUID()
            record.date = date
            record.correctWords = try? NSKeyedArchiver.archivedData(withRootObject: correctWords, requiringSecureCoding: false) as NSObject
            record.wrongWords = try? NSKeyedArchiver.archivedData(withRootObject: wrongWords, requiringSecureCoding: false) as NSObject
            completable(.completed)
            return Disposables.create()
        }.concat(self.saveContext())
    }
    
    // RecordData를 가져오는 메서드.
    func fetchRecordData() -> Observable<[RecordData]> {
        return Observable.create { [weak self] observer in
            guard let self = self else {
                observer.onError(NSError(domain: "CoreDataManager", code: -1, userInfo: nil))
                return Disposables.create()
            }
            let request: NSFetchRequest<RecordData> = RecordData.fetchRequest()
            do {
                let data = try self.context.fetch(request)
                observer.onNext(data)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            return Disposables.create()
        }
    }
    
    // RecordData를 업데이트하는 메서드.
    func updateRecordData(record: RecordData, correctWords: [VocaData], wrongWords: [VocaData]) -> Completable {
        return Completable.create { completable in
            record.correctWords = try? NSKeyedArchiver.archivedData(withRootObject: correctWords, requiringSecureCoding: false) as NSObject
            record.wrongWords = try? NSKeyedArchiver.archivedData(withRootObject: wrongWords, requiringSecureCoding: false) as NSObject
            completable(.completed)
            return Disposables.create()
        }.concat(self.saveContext())
    }
    
    // RecordData를 삭제하는 메서드.
    func deleteRecordData(record: RecordData) -> Completable {
        return Completable.create { [weak self] completable in
            guard let self = self else {
                completable(.error(NSError(domain: "CoreDataManager", code: -1, userInfo: nil)))
                return Disposables.create()
            }
            self.context.delete(record)
            completable(.completed)
            return Disposables.create()
        }.concat(self.saveContext())
    }
    
}
