//
//  OrderCellView.swift
//  HelloCoffee
//
//  Created by Brandon Jones on 7/3/24.
//

import SwiftUI


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
      
      //      Text(order.total as NSNumber, formatter: NumberFormatter.currency)
      Text(order.total, format: .currency(code: "USD"))
        .accessibilityIdentifier("coffeePriceText")
       
      
    }
  }
}


#Preview {
  OrderCellView(order: Order.example)
    .padding()
}
