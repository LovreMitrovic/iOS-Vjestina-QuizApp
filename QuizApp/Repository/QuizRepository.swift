//
//  QuizRepository.swift
//  QuizApp
//
//  Created by Lovre on 23/05/2021.
//

import Foundation
class QuizRepository {
    private var networkDS:QuizNetworkDataSource!
    private var databaseDS:QuizDatabaseDataSource!
    var quizzes:[[Quiz]]! = []
    
    init(){
        networkDS = QuizNetworkDataSource(repo: self)
        //databaseDS = QuizDatabaseDataSource(repo: self)
    }
    
    func fetchFromNetwork()->[[Quiz]]{
        DispatchQueue.global(qos: .userInitiated).sync {
            networkDS.fetchQuizzes()
            print("PRIORITWTNI")
        }
        print("REPOSITORY-FETCHFROMNETWORK")
        print(self.quizzes!)
        return self.quizzes!
    }
    
    func fetchQuizzes()->[[Quiz]]{
        return fetchFromNetwork()
    }
}
