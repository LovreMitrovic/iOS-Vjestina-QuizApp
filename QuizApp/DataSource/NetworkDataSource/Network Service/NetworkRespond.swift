//
//  NetworkRespond.swift
//  QuizApp
//
//  Created by Lovre on 16/05/2021.
//

import Foundation
enum NetworkRespond:String, Codable{
    case unauthorized = "UNAUTHORIZED"
    case forbidden = "FORBIDDEN"
    case notFoudn = "NOT FOUND"
    case badRequest = "BAD REQUEST"
    case ok = "OK"
}
