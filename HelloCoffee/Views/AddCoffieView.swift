//
//  AddCoffieView.swift
//  HelloCoffee
//
//  Created by Brandon Jones on 7/21/24.
//

import SwiftUI

struct AddCoffieView: View {
  
  var order: Order? = nil
  @State private var name: String = ""
  @State private var coffeeName: String = ""
  @State private var price: String = ""
  @State private var coffeeSize: CoffeeSize = .medium
  @State private var errors: AddCoffeeErrors = AddCoffeeErrors()
  @Environment(\.dismiss) private var dismiss
  @EnvironmentObject private var model: CoffeeViewModel
  
  //This is Not a business rule
  //This is jsut UI validation
  var formIsValid: Bool {
    errors = AddCoffeeErrors()
    if name.isEmpty {
      errors.name = "Name is required"
    }
    
    if coffeeName.isEmpty {
      errors.coffeeName = "Coffee name is required"
    }
    
    if price.isEmpty {
      errors.price = "Price is required"
    } else if !price.isNumeric {
      errors.price = "Price must be a number"
    } else if price.isLessThan(1) {
      errors.price = "Price must be greater than 0"
    }
    return errors.name.isEmpty && errors.coffeeName.isEmpty && errors.price.isEmpty
  }
  
  
  
  
  
  var body: some View {
    NavigationStack {
      Form {
        TextField("Name", text: $name).accessibilityIdentifier("name")
        Text(errors.name).visable(errors.name.isNotEmpty).font(.caption)
        
        TextField("Coffee Name", text: $coffeeName).accessibilityIdentifier("coffeeName")
        Text(errors.coffeeName).visable(errors.coffeeName.isNotEmpty).font(.caption)
        
        TextField("Price", text: $price).accessibilityIdentifier("price")
        Text(errors.price).visable(errors.price.isNotEmpty).font(.caption)
        
        Picker("Select size", selection: $coffeeSize) {
          ForEach(CoffeeSize.allCases, id: \.rawValue) { size in
            Text(size.rawValue).tag(size)
          }
        }.pickerStyle(.segmented)
          .accessibilityIdentifier("coffeeSize")
        
        Button(order != nil ? "Update Order" : "Place Order") {
          if formIsValid {
            Task {
              await saveOrUpdateOrder()
            }
          }
        }.accessibilityIdentifier("placeOrderButton")
          .centerHorizontally()
      }
      .navigationTitle(order == nil ? "Add Order" : "Update Order")
      .onAppear{
        populateExistingOrder()
      }
      
      
      .toolbar {
        ToolbarItem(placement: .topBarTrailing) {
          
          Button("Cancel") {
            dismiss()
          }.accessibilityIdentifier("cancelOrderButton")
        }
      }
    }
  }
}

#Preview {
  NavigationStack {
    AddCoffieView()
  }
}


extension AddCoffieView {
  private func placeOrder(_ order: Order) async {

    do {
      try await model.placeOrder(order)
      dismiss()
    } catch {
      print(error)
    }
  }
}


extension AddCoffieView {
  private func updateOrder(_ order: Order) async {
    do {
      try await model.updateOrder(order)
    } catch {
      print(error)
    }
  }
}



extension AddCoffieView {
  private func populateExistingOrder() {
    if let order = order {
      name = order.name
      coffeeName = order.coffeeName
      price = String(order.total)
      coffeeSize = order.size
    }
  }
}

extension AddCoffieView {
  private func saveOrUpdateOrder() async {
    if let order {
      var editOrder = order
      editOrder.name = name
      editOrder.total = Double(price) ?? 0
      editOrder.coffeeName = coffeeName
      editOrder.size = coffeeSize
      await updateOrder(editOrder)
    } else {
      let order = Order(name: name, coffeeName: coffeeName, total: Double(price) ?? 0, size: coffeeSize)
      await placeOrder(order)
    }
    dismiss()
    }
}
