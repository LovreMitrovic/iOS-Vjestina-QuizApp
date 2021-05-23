//
//  NetworkService.swift
//  QuizApp
//
//  Created by Lovre on 13/05/2021.
//

import Foundation

class NetworkService<P:Decodable>: NetworkServiceProtocol{
    typealias U = P
    func executeUrlRequest(_ request: URLRequest, completionHandler: @escaping (Result<P, RequestError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: request){
            data,response, err in
            guard err == nil else{
                completionHandler(.failure(.clientError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { completionHandler(.failure(.serverError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(.noData))
                return
            }
            
            guard let value = try? JSONDecoder().decode(P.self, from: data) else {
                completionHandler(.failure(.dataDecodingError))
                return
            }
            
            completionHandler(.success(value))
            
        }
        dataTask.resume()
    }
    
    func handleError(error:RequestError){
        switch error{
        case .clientError:
            print("Client error")
            break
        case .serverError:
            print("Server error")
            break
        case .noData:
            print("No data error")
            break
        case .dataDecodingError:
            print("Data encoding error")
            break
        }
    }
}
