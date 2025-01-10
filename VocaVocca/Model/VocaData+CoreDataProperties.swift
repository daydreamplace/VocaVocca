//
//  VocaData+CoreDataProperties.swift
//  VocaVocca
//
//  Created by 강민성 on 1/8/25.
//
//

import Foundation
import CoreData


extension VocaData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<VocaData> {
        return NSFetchRequest<VocaData>(entityName: "VocaData")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var language: String?
    @NSManaged public var meaning: String?
    @NSManaged public var word: String?

}

extension VocaData : Identifiable {

}
