//
//  QuizRepository.swift
//  QuizApp
//
//  Created by Lovre on 23/05/2021.
//

import Foundation
import Reachability

class QuizRepository {
    private var networkDS:QuizNetworkDataSource!
    private var databaseDS:QuizDatabaseDataSource!
    var quizzes:[[Quiz]]! = []
    let reachability = try! Reachability()
    var internetConnection = false
    
    init(){
        networkDS = QuizNetworkDataSource(repo: self)
        databaseDS = QuizDatabaseDataSource(repo: self)
    }
    
    func fetchQuizzes()->[[Quiz]]{
        checkInternetConnection()
        if(internetConnection){
            databaseDS.deleteAll()
            let newQuizzes = fetchFromNetwork()
            databaseDS.saveQuizzes(newQuizzes)
            return newQuizzes
        }
        return fetchFromDatabase()
    }
    
    private func fetchFromNetwork()->[[Quiz]]{
        self.quizzes! = []
        DispatchQueue.global(qos: .userInitiated).sync {
            networkDS.fetchQuizzes()
        }
        return self.quizzes!
    }
    
    private func fetchFromDatabase()->[[Quiz]]{
        self.quizzes! = []
        DispatchQueue.global(qos: .userInitiated).sync {
            databaseDS.fetchQuizzes()
        }
        return self.quizzes!
    }
    
    private func fetchDummy()->[[Quiz]]{
        self.quizzes! = []
        let tempQuizzes = DataService.init().fetchQuizes()
        self.quizzes! = [tempQuizzes]
        return self.quizzes!
    }
    
    private func checkInternetConnection(){
            if reachability.isReachable{
                internetConnection = true
                print("reachable")
            } else {
                internetConnection = false
                print("unreachable")
            }
        }
}
