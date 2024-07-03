//
//  CoffeeViewModel.swift
//  HelloCoffee
//
//  Created by Brandon Jones on 7/3/24.
//

import Foundation

@MainActor
class CoffeeViewModel: ObservableObject {
  
  let webservice: Webservice
  @Published private(set) var orders: [Order] = []
  
  init(webservice: Webservice) {
    self.webservice = webservice
  }
  
  func populateOrders() async throws{
    orders = try await webservice.getOrders()
    
  }
}
