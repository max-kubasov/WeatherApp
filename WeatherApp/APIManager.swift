//
//  APIManager.swift
//  WeatherApp
//
//  Created by Max on 04.12.2022.
//

import Foundation

typealias JSONTask = URLSessionDataTask
typealias JSONComplitionHandler = ([String: AnyObject]?, HTTPURLResponse?, Error?) -> Void

protocol APIManager {
    var sessionConfiguration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    func JSONTaskWith(request: URLRequest, complitionHeandler: JSONComplitionHandler) -> JSONTask
    
    init(sessionConfiguration: URLSessionConfiguration)
}
