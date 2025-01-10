//
//  VocaBookData+CoreDataProperties.swift
//  VocaVocca
//
//  Created by 강민성 on 1/8/25.
//
//

import Foundation
import CoreData


extension VocaBookData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VocaBookData> {
        return NSFetchRequest<VocaBookData>(entityName: "VocaBookData")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var words: NSSet?

}

// MARK: Generated accessors for words
extension VocaBookData {

    @objc(addWordsObject:)
    @NSManaged public func addToWords(_ value: VocaData)

    @objc(removeWordsObject:)
    @NSManaged public func removeFromWords(_ value: VocaData)

    @objc(addWords:)
    @NSManaged public func addToWords(_ values: NSSet)

    @objc(removeWords:)
    @NSManaged public func removeFromWords(_ values: NSSet)

}

extension VocaBookData : Identifiable {

}
