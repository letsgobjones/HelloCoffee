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
  
  
  func updateOrder(_ order: Order) async throws -> Order {
    
    guard let orderId = order.id else {
      throw NetworkError.invalidRequest
    }
    
    guard let url = URL(string: Endpoints.updateOrder(orderId).path, relativeTo: baseURL) else {
      throw NetworkError.invalidURL
      
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    
    let (data, response) = try await URLSession.shared.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
      throw NetworkError.invalidRequest
    }
    
   guard let updatedOrder = try? JSONDecoder().decode(Order.self, from: data) else {
     throw NetworkError.decodingError
    }
    return updatedOrder
  }
  
  
  func deleteOrder(orderId: Int) async throws -> Order {
    guard let url = URL(string: Endpoints.deleteOrder(orderId).path, relativeTo: baseURL) else {
      throw NetworkError.invalidURL
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    
    let (data, response) = try await URLSession.shared.data(for: request)
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
      throw NetworkError.invalidResponse

    }
    
    guard let deletedOrder = try? JSONDecoder().decode(Order.self, from: data) else {
      throw NetworkError.decodingError
    
    }
    return deletedOrder
  }
  
  
  func placeOrder(order: Order) async throws -> Order {
    guard let url = URL(string: Endpoints.placeOrder.path, relativeTo: baseURL) else {
     throw NetworkError.invalidURL
    }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = try JSONEncoder().encode(order)
    
    let (data, response) = try await URLSession.shared.data(for: request)
    
    guard let httpResponse = response as? HTTPURLResponse,
          httpResponse.statusCode == 200 else {
      throw NetworkError.invalidResponse
    }
    
    guard let newOrder = try? JSONDecoder().decode(Order.self, from: data) else {
      throw NetworkError.decodingError
    }
    return newOrder
    
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
