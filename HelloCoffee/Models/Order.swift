//
//  Order.swift
//  HelloCoffee
//
//  Created by Brandon Jones on 7/3/24.
//

import Foundation


enum CoffeeSize: String, Codable, CaseIterable {
  case small = "Small"
  case medium = "Medium"
  case large = "Large"
}


struct Order: Codable, Identifiable, Hashable {
  
  var id: Int?
  var name: String
  var coffeeName: String
  var total: Double
  var size: CoffeeSize
}
