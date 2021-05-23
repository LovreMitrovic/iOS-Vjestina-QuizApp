//
//  LogInPresenter.swift
//  QuizApp
//
//  Created by Lovre on 14/05/2021.
//

import Foundation

protocol LogInProtocol{
    func login(email: String, password: String) -> Void
}

class LogInPresenter:LogInProtocol{
    private let router:AppRouter!
    
    init(router:AppRouter){
        self.router = router
    }
    
    func login(email: String, password: String) -> Void {
        
        let networkService = NetworkService<Userinfo>()
        let requestUrl  = "https://iosquiz.herokuapp.com/api/session"
        guard let url = URL(string:requestUrl)?.appending("username", value: email).appending("password", value: password) else { return }
    
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        networkService.executeUrlRequest(request) {(result: Result<Userinfo,RequestError>) in
                switch result{
                case .failure(let error):
                    networkService.handleError(error: error)
                    return
                case .success(let value):
                    let userDefaults:UserDefaults = UserDefaults()
                    userDefaults.setValue(value.userId, forKey: "user_id")
                    userDefaults.setValue(value.token, forKey: "user_token")
                    DispatchQueue.main.async {
                        self.router.showTabMenu()
                    }
                    return
                }
            }
    }
    
}
