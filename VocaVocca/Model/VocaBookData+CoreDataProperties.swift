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
    @NSManaged public var words: NSObject?

}

extension VocaBookData : Identifiable {

}
