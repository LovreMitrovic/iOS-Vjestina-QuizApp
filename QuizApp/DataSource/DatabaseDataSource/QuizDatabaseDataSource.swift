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
    func deleteAll()
    
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
        
    }
    func saveQuizzes(_ quizzes: [[Quiz]]) {
        <#code#>
    }
    
    func deleteAll() {
        <#code#>
    }
    
}
