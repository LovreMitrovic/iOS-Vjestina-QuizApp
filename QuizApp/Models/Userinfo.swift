//
//  Userinfo.swift
//  QuizApp
//
//  Created by Lovre on 14/05/2021.
//

struct Userinfo: Codable{
    let token:String!
    let userId:Int!
    
    enum CodingKeys: String, CodingKey{
        case token
        case userId = "user_id"
    }
}
