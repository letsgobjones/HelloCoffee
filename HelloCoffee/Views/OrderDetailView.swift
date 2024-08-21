//
//  OrderDetailView.swift
//  HelloCoffee
//
//  Created by Brandon Jones on 8/21/24.
//

import SwiftUI

struct OrderDetailView: View {
  
  
  
  let orderId: Int
  @EnvironmentObject private var model: CoffeeViewModel
  @State private var isPresented: Bool = false
    var body: some View {
      VStack {
        
        if let order = model.orderById(orderId) {
          VStack(alignment: .leading, spacing: 10) {
            Text(order.coffeeName)
              .font(.title)
              .frame(maxWidth: .infinity, alignment: .leading)
              .accessibilityIdentifier("coffeeNameText")
            Text(order.size.rawValue)
              .opacity(0.5)
            
//                  Text(order.total as NSNumber, formatter: NumberFormatter.currency)
            Text(order.total, format: .currency(code: "USD"))
//              .accessibilityIdentifier("coffeePriceText")
            
            
            
            HStack {
              Spacer()
              Button("Delete Order" , role: .destructive) {
                
              }.accessibilityIdentifier("deleteOrderButton")
              
              Button("Edit Order") {
                isPresented = true
              }.accessibilityIdentifier("editOrderButton")
              
              Spacer()
              
            }
          }.sheet(isPresented: $isPresented, content: {
            AddCoffieView(order: order)
          })
          
          
        }
        Spacer()
        
      }.padding()
    }
}

#Preview {
  
  // Configuration setup
  var config = Configuration()
  // Creating an instance of CoffeeViewModel for the preview
  let coffeeViewModel = CoffeeViewModel(webservice: Webservice(baseURL: config.environment.baseURL))
  // Returning the ContentView with the environment object set to the created CoffeeViewModel instance


  return OrderDetailView(orderId: Order.example.id ?? 1).environmentObject(coffeeViewModel)
}
