//
//  CDquiz+CoreDataProperties.swift
//  
//
//  Created by Lovre on 23/05/2021.
//
//

import Foundation
import CoreData


extension CDquiz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDquiz> {
        return NSFetchRequest<CDquiz>(entityName: "CDquiz")
    }

    @NSManaged public var id: Int16
    @NSManaged public var title: String?
    @NSManaged public var descriptionAtr: String?
    @NSManaged public var category: NSObject?
    @NSManaged public var imageUrl: String?
    @NSManaged public var questions: NSObject?
    @NSManaged public var level: Int16
    @NSManaged public var quizQuestion: NSSet?

}

// MARK: Generated accessors for quizQuestion
extension CDquiz {

    @objc(addQuizQuestionObject:)
    @NSManaged public func addToQuizQuestion(_ value: CDquestion)

    @objc(removeQuizQuestionObject:)
    @NSManaged public func removeFromQuizQuestion(_ value: CDquestion)

    @objc(addQuizQuestion:)
    @NSManaged public func addToQuizQuestion(_ values: NSSet)

    @objc(removeQuizQuestion:)
    @NSManaged public func removeFromQuizQuestion(_ values: NSSet)

}
