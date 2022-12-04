//
//  APIManager.swift
//  WeatherApp
//
//  Created by Max on 04.12.2022.
//

import Foundation

typealias JSONTask = URLSessionDataTask
typealias JSONComplitionHandler = ([String: AnyObject]?, HTTPURLResponse?, Error?) -> Void

enum APIResult<T> {
    case Success(T)
    case Failure(Error)
}

protocol APIManager {
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func JSONTaskWith(request: URLRequest, complitionHeandler: JSONComplitionHandler) -> JSONTask
    func fetch<T>(request: URLRequest, parse: ([String: AnyObject]) -> T?, copletionHandler: (APIResult<T>) -> Void )
    
    init(sessionConfiguration: URLSessionConfiguration)
}

extension APIManager {
    
    func JSONTaskWith(request: URLRequest, complitionHeandler: @escaping JSONComplitionHandler) -> JSONTask {
        
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            guard let HTTPResponse = response as? HTTPURLResponse else {
                
                let userInfo = [
                    NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
                ]
                let error = NSError(domain: SWINetworkingErrorDomain, code: 100, userInfo: userInfo)
                
                complitionHeandler(nil, nil, error)
                return
            }
            
            if data == nil {
                if let error = error {
                    complitionHeandler(nil, HTTPResponse, nil)
                }
            } else {
                switch HTTPResponse.statusCode {
                case 200:
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
                        complitionHeandler(json, HTTPResponse, nil)
                    } catch let error as NSError {
                        complitionHeandler(nil, HTTPResponse, error)
                    }
                default:
                    print("We have got response status \(HTTPResponse.statusCode)")
                }
            }
        }
        return dataTask
    }
}
