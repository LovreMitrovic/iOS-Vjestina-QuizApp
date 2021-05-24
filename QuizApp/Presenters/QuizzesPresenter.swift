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
        
        let networkService = NetworkService<Quizzes>()
        let requestUrl  = "https://iosquiz.herokuapp.com/api/quizzes"
        guard let url = URL(string:requestUrl) else { return }
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //DispatchQueue.main.async 
        networkService.executeUrlRequest(request) {(result: Result<Quizzes,RequestError>) in
            switch result{
            case .failure(let error):
                networkService.handleError(error: error)
                return
            case .success(let quizzes):
                let quizzesArray = quizzes.quizzes
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
                
                DispatchQueue.main.async {
                    self.viewController!.showQuizzes()
                }
                
                return
            }
        }
        
        return
    }
    
    
}
