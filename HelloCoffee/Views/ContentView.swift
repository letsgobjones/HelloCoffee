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
  ContentView().environmentObject(CoffeeViewModel(webservice: Webservice()))
}




struct OrderCellView: View {
  let order: Order
  var body: some View {
    HStack {
      VStack(alignment: .leading) {
        Text(order.name).accessibilityIdentifier("orderNameText")
          .fontWeight(.bold)
        Text("\(order.coffeeName) (\(order.size.rawValue))")
          .accessibilityIdentifier("coffeenameAndSizeText")
          .opacity(0.5)
      }
      Spacer()
      
      Text(order.total as NSNumber, formatter: NumberFormatter.currency)
        .accessibilityIdentifier("coffeePriceText")
       
      
    }
  }
}
