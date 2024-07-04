//
//  Webservice.swift
//  HelloCoffee
//
//  Created by Brandon Jones on 7/3/24.
//

import Foundation


enum NetworkError: Error {
  case invalidURL
  case invalidRequest
  case invalidResponse
  case decodingError
}

class Webservice {
  
  private var baseURL: URL
  
  init(baseURL: URL) {
    self.baseURL = baseURL
  }
  
  func getOrders() async throws ->  [Order] {
    
    //https://island-bramble.glitch.me/test/orders
    
    guard let url = URL(string: Endpoints.allOrders.path, relativeTo: baseURL) else {
      throw NetworkError.invalidURL
    }
    
    let (data, response) = try await URLSession.shared.data(from: url)
    guard let httpRespnse = response as? HTTPURLResponse,
          httpRespnse.statusCode == 200 else {
      throw NetworkError.invalidResponse
    }
    
    guard let orders = try?  JSONDecoder().decode([Order].self, from: data) else {
      throw NetworkError.decodingError
    }
    return orders
  }
}
