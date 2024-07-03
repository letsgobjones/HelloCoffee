//
//  NumberFormatter+Extension.swift
//  HelloCoffee
//
//  Created by Brandon Jones on 7/3/24.
//

import Foundation

extension NumberFormatter {
  static var currency: NumberFormatter {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "en_US")
    return formatter
  }
}
