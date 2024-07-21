//
//  AppEnvironment.swift
//  HelloCoffee
//
//  Created by Brandon Jones on 7/4/24.
//

import Foundation

enum Endpoints {
    case allOrders
  
  var path: String {
    switch self {
    case .allOrders:
      // "/orders"
      return "/test/orders"
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
      return URL(string: "https://island-bramble.glitch.me")!
    case .test:
      // "https://test.island-bramble.glitch.me"
      return URL(string: "https://island-bramble.glitch.me")!
    }
  }
}
