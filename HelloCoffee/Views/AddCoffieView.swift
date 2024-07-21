//
//  AddCoffieView.swift
//  HelloCoffee
//
//  Created by Brandon Jones on 7/21/24.
//

import SwiftUI

struct AddCoffieView: View {
  @State private var name: String = ""
  @State private var coffeeName: String = ""
  @State private var price: String = ""
  @State private var coffeeSize: CoffeeSize = .medium
  @State private var errors: AddCoffeeErrors = AddCoffeeErrors()
  
  var formIsValid: Bool {
    
    errors = AddCoffeeErrors()
    //This is Not a business rule
    //This is jsut UI validation
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
        
        Button("Place Order") {
          if formIsValid {
           //place the order
          }
          
          
          
          
        }.accessibilityIdentifier("placeOrderButton")
          .centerHorizontally()
        
      }
    }
}

#Preview {
    AddCoffieView()
}
