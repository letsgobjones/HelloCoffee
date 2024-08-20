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
  
  func placeOrder(_ order: Order) async throws {
   let newOrder =  try await webservice.placeOrder(order: order)
    orders.append(newOrder)
  }
  
  func deleteOrder(_ orderId: Int) async throws {
    let deletedOrder = try await webservice.deleteOrder(orderId: orderId)
    orders = orders.filter { $0.id != deletedOrder.id }
  }
  
  func updateOrder(_ order: Order) async throws {
    let updateOrder = try await webservice.updateOrder(order)
    guard let index = orders.firstIndex(where:  {$0.id == updateOrder.id }) else {
      throw CoffeeOrderError.invalidOrderId
    }
    orders[index] = updateOrder
  }
  
}
