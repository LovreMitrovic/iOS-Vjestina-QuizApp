//
//  QuizzesPresenter.swift
//  QuizApp
//
//  Created by Lovre on 14/05/2021.
//
import Foundation

protocol QuizzesPresenterProtocol{
    func fetchQuizzes() -> Void
}
class QuizzesPresenter: QuizzesPresenterProtocol{
    
    weak var viewController:QuizzesViewController?
    
    init(viewController: QuizzesViewController){
        self.viewController = viewController
    }
    
    func fetchQuizzes() -> Void {
        
        let networkService = NetworkService<[Quiz]>()
        let requestUrl  = "https://iosquiz.herokuapp.com/api/quizzes"
        guard let url = URL(string:requestUrl) else { return }
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        networkService.executeUrlRequest(request) {(result: Result<[Quiz],RequestError>) in
            switch result{
            case .failure(let error):
                networkService.handleError(error: error)
                return
            case .success(let quizzesArray):
                
                let categoriesArray:[QuizCategory] = Array(Set(quizzesArray.map({$0.category})))
                for category in categoriesArray{
                    var row:[Quiz]! = []
                    for quiz in quizzesArray{
                        if quiz.category == category{
                            row.append(quiz)
                        }
                    }
                    self.viewController!.quizzes.append(row)
                }
                
                return
            }
        }
        
        return
    }
    
    
}
