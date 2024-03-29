//  BoniUrlSessionProtocol.swift
//  Created by 구본의 on 2023/01/25.

import Foundation

@available(iOS 13.0.0, *)
protocol UrlSessionManagerProtocol {
  func makePlaneRequest(url: String, method: HttpMethod) async -> URLRequest
  func makeQueryRequest(url: String, method: HttpMethod, query: [String:Any]) async -> URLRequest
  func makeParameterRequest(url: String, method: HttpMethod, parameter: [String:Any]) async -> URLRequest
  func makeQueryWithParameterRequest(url: String, method: HttpMethod, query: [String:Any], parameter: [String:Any]) async -> URLRequest
}

@available(iOS 13.0.0, *)
extension UrlSessionManagerProtocol {
  func makePlaneRequest(url: String, method: HttpMethod) async -> URLRequest{
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = method.rawValue
    return request
  }
  
  func makeQueryRequest(url: String, method: HttpMethod, query: [String:Any]) async -> URLRequest {
    var urlComponents = URLComponents(string: url)!
    let queryString = query.map{ URLQueryItem(name: $0.key, value: String(describing: $0.value)) }
    urlComponents.queryItems = queryString
    let requestURL = urlComponents.url!
    var request = URLRequest(url: requestURL)
    request.httpMethod = method.rawValue
    return request
  }
  
  func makeParameterRequest(url: String, method: HttpMethod, parameter: [String:Any]) async -> URLRequest {
    var request = URLRequest(url: URL(string: url)!)
    request.httpMethod = method.rawValue
    request.httpBody = try! JSONSerialization.data(withJSONObject: parameter, options: [])
    return request
  }
  
  func makeQueryWithParameterRequest(url: String, method: HttpMethod, query: [String:Any], parameter: [String:Any]) async -> URLRequest {
    let queryString = query.map{"?\($0)=\(String(describing: $1).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)"}.joined()
    var request = URLRequest(url: URL(string: url+queryString)!)
    request.httpMethod = method.rawValue
    request.httpBody = try! JSONSerialization.data(withJSONObject: parameter, options: [])
    return request
  }
}

