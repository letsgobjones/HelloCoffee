//
//  AppEnvironment.swift
//  HelloCoffee
//
//  Created by Brandon Jones on 7/4/24.
//

import Foundation

enum Endpoints {
    case allOrders
  case placeOrder
  case deleteOrder(Int)
  case updateOrder(Int)
  var path: String {
    switch self {
    case .allOrders:
      // "/orders"
      return "/test/orders"
    case .placeOrder:
      return "/test/new-order"
      
    case .deleteOrder(let orderId):
      return "/test/orders/\(orderId)"
      
    case .updateOrder(let orderId):
      return "/test/orders/\(orderId)"
    }
  }
}


struct Configuration {
  lazy var environment: AppEnvironment = {
    
    //read value from enviroment variable
    guard let env = ProcessInfo.processInfo.environment["ENV"] else {
      return AppEnvironment.dev
    }
    if env == "TEST" {
      return AppEnvironment.test
    }
    return AppEnvironment.dev
    
  }()
}


enum AppEnvironment {
  case dev
  case test
  
  var baseURL: URL {
    switch self {
    case .dev:
      // "https://dev.island-bramble.glitch.me"
      return URL(string: "https://server-bjones.glitch.me")!
    case .test:
      // "https://test.island-bramble.glitch.me"
      return URL(string: "https://server-bjones.glitch.me")!
    }
  }
}
