//
//  RequestError.swift
//  QuizApp
//
//  Created by Lovre on 13/05/2021.
//

import Foundation
enum RequestError:Error{
    case clientError
    case serverError
    case noData
    case dataDecodingError
}
