//
//  ResultPresenter.swift
//  QuizApp
//
//  Created by Lovre on 14/05/2021.
//

import Foundation

protocol ResultPresenterProtocol{
    func startQuiz() -> Void
    func finishQuiz(noOfCorrect:Int, quizId:Int) -> Void
}

class ResultPresenter:ResultPresenterProtocol{
    
    private var timer:Timer!
    private var seconds:Double!
    
    func finishQuiz(noOfCorrect:Int, quizId:Int) {
        timer.invalidate()
        
        let networkService = NetworkService<NetworkRespond>()
        let requestUrl  = "https://iosquiz.herokuapp.com/api/result"
        guard let url = URL(string:requestUrl) else { return }
    
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let userDefaults = UserDefaults()
        let token = userDefaults.string(forKey: "user_token")
        request.setValue(token, forHTTPHeaderField: "Authorization")
        
        let quizResult = QuizResult(quizId: quizId, userId: userDefaults.string(forKey: "user_id")!, time: seconds, noOfCorrect: noOfCorrect)
        let requestBody = try!JSONEncoder().encode(quizResult)
        request.httpBody = requestBody
        
        networkService.executeUrlRequest(request) {(result: Result<NetworkRespond,RequestError>) in
            switch result{
            case .failure(let error):
                networkService.handleError(error: error)
                return
            case .success(let value):
                print(value)
                return
            }
        }
        
    }
    
    func startQuiz() {
        seconds = 0
        timer = Timer(timeInterval: 1, target: self, selector: #selector(keepTimer), userInfo: nil, repeats: true)
    }
    
    @objc
    private func keepTimer(){
        seconds += 1
    }
}
