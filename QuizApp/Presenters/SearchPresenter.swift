//
//  SearchPresenter.swift
//  QuizApp
//
//  Created by Lovre on 29/05/2021.
//

import Foundation
protocol SearchPresenterProtocol{
    func searchQuizzes(condition:String!) -> Void
}
class SearchPresenter: SearchPresenterProtocol{
    weak var viewController:SearchViewController?
    private var repository:QuizRepository!
    
    init(viewController: SearchViewController){
        self.viewController = viewController
        self.repository = QuizRepository()
    }
    
    func searchQuizzes(condition:String!){
        if(condition == nil){
            print("Bez uvjetno")
        }
        let allQuizes = repository.fetchFromDatabase()
        self.viewController!.quizzes! = filterQuizzes(allQuizzes: allQuizes, condition: condition)
        DispatchQueue.main.async {
            self.viewController!.showQuizzes()
        }
    }
    
    private func filterQuizzes(allQuizzes:[[Quiz]],condition:String) -> [[Quiz]]{
        var filtered:[[Quiz]] = []
        for category in allQuizzes{
            var categoryArray:[Quiz] = []
            for quiz in category{
                if(fullfils(quiz: quiz, condition: condition)){
                    categoryArray.append(quiz)
                }
            }
            if !(categoryArray.isEmpty){
                filtered.append(categoryArray)
            }
        }
        return filtered
    }
    
    private func fullfils(quiz:Quiz,condition:String)->Bool{
        if (quiz.title.contains(condition)){
            return true
        }
        return false
    }
}
