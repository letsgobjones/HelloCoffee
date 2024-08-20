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
          List {
            ForEach(model.orders) { order in
              OrderCellView(order: order)
            }.onDelete(perform: deleteOrder)
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
  
  
  
  
  private func deleteOrder(_ indexSet: IndexSet) {
    indexSet.forEach{ index in
      let order = model.orders[index]
      guard let orderId = order.id else {
        return
      }
      Task {
        do {
          try await model.deleteOrder(orderId)
        } catch {
          print(error)
        }
        print("deleted order")
      }
    }
  }
  
}
