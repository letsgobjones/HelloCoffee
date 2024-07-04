//
//  ContentView.swift
//  HelloCoffee
//
//  Created by Brandon Jones on 7/3/24.
//

import SwiftUI

struct ContentView: View {
  @EnvironmentObject private var model: CoffeeViewModel
  
  var body: some View {
    VStack {
      List(model.orders) { order in
      OrderCellView(order: order)
      }
    }.task {
      do {
        try await model.populateOrders()
      } catch {
        print(error)
      }
    }
  }
}

#Preview {
  var config = Configuration()
  ContentView().environmentObject(CoffeeViewModel(webservice: Webservice(baseURL: config.environment.baseURL)))

}
