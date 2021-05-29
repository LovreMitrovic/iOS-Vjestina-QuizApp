//
//  QuizNetworkDataSource.swift
//  QuizApp
//
//  Created by Lovre on 23/05/2021.
//

import Foundation
class QuizNetworkDataSource{

    weak var repository:QuizRepository!
    
    init(repo:QuizRepository){
        repository = repo
    }
    
    func fetchQuizzes() -> Void {
        
        let networkService = NetworkService<Quizzes>()
        let requestUrl  = "https://iosquiz.herokuapp.com/api/quizzes"
        guard let url = URL(string:requestUrl) else { return }
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        DispatchQueue.global(qos: .userInitiated).sync {
        networkService.executeUrlRequest(request) {(result: Result<Quizzes,RequestError>) in
            switch result{
            case .failure(let error):
                networkService.handleError(error: error)
                return
            case .success(let quizzes):
                let quizzesArray = quizzes.quizzes
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
                print("poziv završen")
                self.repository?.quizzes? = quizzesMatrix
                
                return
            }
            
        }
        
        return
    }
    }
}
