//  BoniUrlSession.swift
//  Created by 구본의 on 2023/01/25.

import Foundation

open class BoniUrlSession {
  public static let boni = BoniUrlSession()

  func BoniUrlSessionTest() {
    print("🔊[DEBUG]: BoniUrlSession Package 성공")
  }
}

@available(iOS 13.0.0, *)
extension BoniUrlSession: UrlSessionManagerProtocol {
  public func requestPlane<T: Codable>(url: String, method: HttpMethod, resonse: T.Type) async throws -> T {
    let request = await makePlaneRequest(url: url, method: method)
    let (data, response) = try await URLSession.shared.data(for: request)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      let statusCode: Int = (response as? HTTPURLResponse)?.statusCode ?? 500
      print("🚨[ERROR]: \(APIError(message: "plz check http request", status: statusCode))")
      throw APIError()
    }
    guard let responseData = try? JSONDecoder().decode(T.self, from: data) else { throw APIError() }
    return responseData
  }
  
  public func requestQueryString<T: Codable>(url: String, method: HttpMethod, query: [String:Any], response: T.Type) async throws -> T {
    let request = await makeQueryRequest(url: url, method: method, query: query)
    let (data, response) = try await URLSession.shared.data(for: request)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      let statusCode: Int = (response as? HTTPURLResponse)?.statusCode ?? 500
      print("🚨[ERROR]: \(APIError(message: "plz check http request", status: statusCode))")
      throw APIError()
    }
    guard let responseData = try? JSONDecoder().decode(T.self, from: data) else { throw APIError() }
    return responseData
  }
  
  public func requestParameter<T: Codable>(url: String, method: HttpMethod, parameter: [String:Any], resonse: T.Type) async throws -> T {
    let request = await makeParameterRequest(url: url, method: method, parameter: parameter)
    let (data, response) = try await URLSession.shared.data(for: request)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      let statusCode: Int = (response as? HTTPURLResponse)?.statusCode ?? 500
      print("🚨[ERROR]: \(APIError(message: "plz check http request", status: statusCode))")
      throw APIError()
    }
    guard let responseData = try? JSONDecoder().decode(T.self, from: data) else { throw APIError() }
    return responseData
  }
  
  public func requestQueryWithParameter<T: Codable>(url: String, method: HttpMethod, query: [String:Any], parameter: [String:Any], resonse: T.Type) async throws -> T {
    let request = await makeQueryWithParameterRequest(url: url, method: method, query: query, parameter: parameter)
    let (data, response) = try await URLSession.shared.data(for: request)
    guard (response as? HTTPURLResponse)?.statusCode == 200 else {
      let statusCode: Int = (response as? HTTPURLResponse)?.statusCode ?? 500
      print("🚨[ERROR]: \(APIError(message: "plz check http request", status: statusCode))")
      throw APIError()
    }
    guard let responseData = try? JSONDecoder().decode(T.self, from: data) else { throw APIError() }
    return responseData
  }
}
