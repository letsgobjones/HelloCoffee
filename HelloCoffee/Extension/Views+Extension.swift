//
//  Views+Extension.swift
//  HelloCoffee
//
//  Created by Brandon Jones on 7/21/24.
//

import Foundation
import SwiftUI



extension View {

  func centerHorizontally() -> some View {
    HStack {
      Spacer()
      self
      Spacer()
    }
  }
}


