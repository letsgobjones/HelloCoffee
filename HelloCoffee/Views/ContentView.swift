//
//  ContentView.swift
//  HelloCoffee
//
//  Created by Brandon Jones on 7/3/24.
//

import SwiftUI

struct ContentView: View {
  @State private var isPresented: Bool = false
  @EnvironmentObject private var model: CoffeeViewModel
  
  var body: some View {
    NavigationStack {
      VStack {
        if model.orders.isEmpty{
          
          Text("No orders available!").accessibilityIdentifier("noOrdersText")
        } else {
          List(model.orders) { order in
            OrderCellView(order: order)
          }
        }
      }.task {
       await populateOrders()
      }
   
      .sheet(isPresented: $isPresented) {
        AddCoffieView()
      }
    
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          Button("Add New Order") {
            isPresented.toggle()
          }.accessibilityIdentifier("addNewOrderButton")
        }
      }
    }
  }
  }






#Preview {
  // Configuration setup
  var config = Configuration()
  // Creating an instance of CoffeeViewModel for the preview
  let coffeeViewModel = CoffeeViewModel(webservice: Webservice(baseURL: config.environment.baseURL))
  // Returning the ContentView with the environment object set to the created CoffeeViewModel instance


  return ContentView().environmentObject(coffeeViewModel)
  
}





extension ContentView {
  private func populateOrders() async {
    do {
      try await model.populateOrders()
    } catch {
      print(error)
    }
  }
  
}
