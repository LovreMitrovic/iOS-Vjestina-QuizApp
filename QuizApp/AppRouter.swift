//
//  AppRouter.swift
//  QuizApp
//
//  Created by Lovre on 11/05/2021.
//

import Foundation
import UIKit

protocol AppRouterProtocol{
    
    func setStart(in window: UIWindow?)
}

class AppRouter: AppRouterProtocol{
    
    private let navigationController: UINavigationController!
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func setStart(in window: UIWindow?) {
        let logInVC = LoginViewController(router: self)
        navigationController.pushViewController(logInVC, animated: false)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
    func showTabMenu(){
        let quizzesVc = QuizzesViewController(router: self)
        let settingsVc = SettingsViewController(router: self)
        let searchVc = SearchViewController(router:self)
        let tabBarCon = UITabBarController()
        quizzesVc.tabBarItem = UITabBarItem(title: "Quizzes", image: .add, selectedImage: .actions)
        settingsVc.tabBarItem = UITabBarItem(title: "Settings", image: .actions, selectedImage: .actions)
        searchVc.tabBarItem = UITabBarItem(title: "Search", image: .actions, selectedImage: .actions)
        tabBarCon.viewControllers = [quizzesVc,settingsVc,searchVc]
        navigationController.setViewControllers([tabBarCon], animated: false)
    }
    
    func showQuiz(myQuiz: Quiz){
        let quizVc = QuizViewController(router: self)
        quizVc.quiz = myQuiz
        navigationController.pushViewController(quizVc, animated: false)
    }
    
    func showQuizResults(correct:Int,sum:Int){
        let resultVc = QuizResultViewController(router: self)
        resultVc.setResult(numOfCorrect: correct, numOfSum: sum)
        navigationController.pushViewController(resultVc, animated: true)
    }
    
    func backToTabMenu(){
        navigationController.popToRootViewController(animated: false)
    }
    
    func backToLogIn(){
        let logInVc = LoginViewController(router:self)
        navigationController.setViewControllers([logInVc], animated: false)
    }
    
}
