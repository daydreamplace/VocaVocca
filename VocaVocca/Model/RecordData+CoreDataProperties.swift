//
//  RecordData+CoreDataProperties.swift
//  VocaVocca
//
//  Created by 강민성 on 1/8/25.
//
//

import Foundation
import CoreData


extension RecordData {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RecordData> {
        return NSFetchRequest<RecordData>(entityName: "RecordData")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var iscorrected: Bool
    @NSManaged public var voca: VocaData?

}

extension RecordData : Identifiable {

}
