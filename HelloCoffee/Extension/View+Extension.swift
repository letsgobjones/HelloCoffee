//
//  View+Extension.swift
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
  
  
  
  @ViewBuilder
  func visable(_ value: Bool) -> some View {
    switch value {
      case true:
      self
      case false:
      EmptyView()
      
      
      
    }
  }
  
  
  
  
}



