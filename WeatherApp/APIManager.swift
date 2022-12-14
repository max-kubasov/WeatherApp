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
    
    func JSONTaskWith(request: URLRequest, complitionHeandler: @escaping JSONComplitionHandler) -> JSONTask
    func fetch<T>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> T?, copletionHandler: @escaping (APIResult<T>) -> Void )
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
                    complitionHeandler(nil, HTTPResponse, error)
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
    
    func fetch<T>(request: URLRequest, parse: @escaping ([String: AnyObject]) -> T?, copletionHandler: @escaping (APIResult<T>) -> Void ) {
        
        let dataTask = JSONTaskWith(request: request) { json, response, error in
            
            guard let json = json else {
                if let error = error {
                    copletionHandler(.Failure(error))
                }
                return
            }
            
            if let value = parse(json) {
                copletionHandler(.Success(value))
            } else {
                let error = NSError(domain: SWINetworkingErrorDomain, code: 200, userInfo: nil)
                copletionHandler(.Failure(error))
            }
        }
        dataTask.resume()
    }
}
