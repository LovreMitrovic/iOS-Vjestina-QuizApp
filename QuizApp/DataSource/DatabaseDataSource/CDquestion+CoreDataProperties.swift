//
//  CDquestion+CoreDataProperties.swift
//  
//
//  Created by Lovre on 23/05/2021.
//
//

import Foundation
import CoreData


extension CDquestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDquestion> {
        return NSFetchRequest<CDquestion>(entityName: "CDquestion")
    }

    @NSManaged public var id: Int16
    @NSManaged public var question: String?
    @NSManaged public var answears: NSObject?
    @NSManaged public var correctAnswear: Int16
    @NSManaged public var questionQuiz: CDquiz?

}
