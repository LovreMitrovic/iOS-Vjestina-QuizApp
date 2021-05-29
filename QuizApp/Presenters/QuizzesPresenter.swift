//
//  QuizzesPresenter.swift
//  QuizApp
//
//  Created by Lovre on 14/05/2021.
//
import Foundation

protocol QuizzesPresenterProtocol{
    func presentQuizzes() -> Void
}
class QuizzesPresenter: QuizzesPresenterProtocol{
    
    weak var viewController:QuizzesViewController?
    private var repository:QuizRepository!
    
    init(viewController: QuizzesViewController){
        self.viewController = viewController
        self.repository = QuizRepository()
    }
    
    func presentQuizzes()->Void{
        DispatchQueue.global(qos: .userInitiated).sync {
            self.viewController!.quizzes = repository.fetchFromNetwork()
        }
        print("VIEWCONTROLLER")
        print(self.viewController!.quizzes!)
        DispatchQueue.main.async {
            self.viewController!.showQuizzes()
        }
    }
    
}
