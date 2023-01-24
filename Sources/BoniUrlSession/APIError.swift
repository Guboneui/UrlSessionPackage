//  APIError.swift
//  Created by 구본의 on 2023/01/25.

import Foundation

struct APIError: Codable, Error {
  var message: String?
  var status: Int?
}
