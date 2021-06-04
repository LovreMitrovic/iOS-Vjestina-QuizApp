//
//  NetworkServiceProtocol.swift
//  QuizApp
//
//  Created by Lovre on 13/05/2021.
//

import Foundation
protocol NetworkServiceProtocol{
    associatedtype U
    func executeUrlRequest(_ request: URLRequest, completionHandler: @escaping(Result<U,RequestError>) -> Void)
    
}
