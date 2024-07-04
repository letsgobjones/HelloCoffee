//
//  HelloCoffeeApp.swift
//  HelloCoffee
//
//  Created by Brandon Jones on 7/3/24.
//

import SwiftUI

@main
struct HelloCoffeeApp: App {
  
  @StateObject private var model: CoffeeViewModel
  
  init() {
    var config = Configuration()
    let webservice = Webservice(baseURL: config.environment.baseURL)
    _model = StateObject(wrappedValue: CoffeeViewModel(webservice: webservice))
  }
  
    var body: some Scene {
      WindowGroup {
        ContentView()
          .environmentObject(model)
      }
    }
  }
