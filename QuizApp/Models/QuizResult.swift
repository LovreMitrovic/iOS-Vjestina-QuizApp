//
//  QuizResult.swift
//  QuizApp
//
//  Created by Lovre on 16/05/2021.
//

import Foundation
struct QuizResult:Codable{
    
    let quizId: Int
    let userId: String
    let time: Double
    let noOfCorrect: Int
    
    enum CodingKeys: String, CodingKey{
        case quizId = "quiz_id"
        case userId = "user_id"
        case time
        case noOfCorrect = "no_of_correct"
    }
    
    init(quizId:Int, userId:String, time:Double, noOfCorrect:Int) {
        self.quizId = quizId
        self.userId = userId
        self.time = time
        self.noOfCorrect = noOfCorrect
    }
    
}
