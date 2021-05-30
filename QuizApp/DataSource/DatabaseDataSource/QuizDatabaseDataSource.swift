//
//  QuizDatabaseDataSource.swift
//  QuizApp
//
//  Created by Lovre on 23/05/2021.
//

import Foundation
import CoreData

protocol QuizDatabaseDataSourceProtocol {
    
    func fetchQuizzes()
    func saveQuizzes(_ quizzes: [[Quiz]])
    func deleteAll() throws
    
}

class QuizDatabaseDataSource:QuizDatabaseDataSourceProtocol{
    
    weak var repository:QuizRepository!
    private let coreDataContext: NSManagedObjectContext

    init(coreDataContext: NSManagedObjectContext) {
        self.coreDataContext = coreDataContext
    }
    
    init(repo:QuizRepository){
        repository = repo
    }
    func fetchQuizzes()->Void{
        let request: NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
    
        do {
            let results = try coreDataContext.fetch(request)
            let quizzesArray = results
            var quizzesMatrix:[[Quiz]] = []
            let categoriesArray:[QuizCategory] = Array(Set(quizzesArray.map({$0.category})))
            for category in categoriesArray{
                var row:[Quiz] = []
                for quiz in quizzesArray{
                    if quiz.category == category{
                        row.append(quiz)
                    }
                }
                quizzesMatrix.append(row)
            }
            self.repository?.quizzes? = quizzesMatrix
        } catch {
            print("Error when fetching quizzes from core data: \(error)")
        }
    }
    func saveQuizzes(_ quizzes: [[Quiz]]) {
        quizzes.forEach { quiz in
            do {
                let cdQuiz = try fetchQuiz(withId: quiz.id) ?? CDQuiz(context: coreDataContext)
                quiz.populate(cdQuiz, in: coreDataContext)
            } catch {
                print("Error when fetching/creating a quiz: \(error)")
            }

            do {
                try coreDataContext.save()
            } catch {
                print("Error when saving updated quiz: \(error)")
            }
        }
    }
    
    func deleteAll() throws{
        let request: NSFetchRequest<CDQuiz> = CDQuiz.fetchRequest()
        let quizzesToDelete = try coreDataContext.fetch(request)
        quizzesToDelete.forEach { coreDataContext.delete($0) }
        try coreDataContext.save()
    }
    
}
