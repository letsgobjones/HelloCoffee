//
//  HelloCoffeeEndToEndTests.swift
//  HelloCoffeeEndToEndTests
//
//  Created by Brandon Jones on 7/4/24.
//

import XCTest

final class when_adding_a_new_coffee_order: XCTestCase {
  
 private var app: XCUIApplication!
  
  
    override func setUp() async throws {
        // Make this an async function to use 'await'
        Task { // Start a new asynchronous task
            guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://island-bramble.glitch.me")!) else { return }
            let (_, _) = try await URLSession.shared.data(from: url)
        } // End of the asynchronous task
    }
  
  //called before runnng each test
  override func setUp() {
    app = XCUIApplication()
    continueAfterFailure = false
    app.launchEnvironment = ["ENV": "TEST"]
    app.launch()
    
    
    //go to place order screen
    app.buttons["addNewOrderButton"].tap()
    //fill out the textfields
    
    let nameTextField = app.textFields["name"]
    let coffeeNameTextField = app.textFields["coffeeName"]
    let priceTextField = app.textFields["price"]
    let coffeeSizePicker = app.segmentedControls["coffeeSize"]
    let placeOrderButton = app.buttons["placeOrderButton"]
    
    
    nameTextField.tap()
    nameTextField.typeText("Brandon")
    
 
    
    //fill out the textfields
    
//    app.textFields["name"].tap()
//    app.textFields["name"].typeText("Brandon")
//    
coffeeNameTextField.tap()
    coffeeNameTextField.typeText("Espresso")
    
//    app.textFields["coffeeName"].tap()
//    app.textFields["coffeeName"].typeText("Espresso")
    
    priceTextField.tap()
    priceTextField.typeText("2.50")
    
    
//    app.textFields["price"].tap()
//    app.textFields["price"].typeText("2.50")
    

    
    coffeeSizePicker.buttons["Small"].tap()
    //place the order
    app.buttons["placeOrderButton"].tap()
  }
  
  func test_should_display_coffee_order_in_list_successfully() throws {
    XCTAssertEqual("Brandon", app.staticTexts["orderNameText"].label)
    XCTAssertEqual("Espresso (Small)", app.staticTexts["coffeeNameAndSizeText"].label)
    XCTAssertEqual("$2.50", app.staticTexts["coffeePriceText"].label)
  }
  
  
  override func tearDown() async throws {
      // Make this an async function to use 'await'
      Task { // Start a new asynchronous task
          guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://island-bramble.glitch.me")!) else { return }
          let (_, _) = try await URLSession.shared.data(from: url)
      } // End of the asynchronous task
  }

}


final class when_app_is_launched_with_no_orders: XCTestCase {
    func test_should_make_sure_no_orders_message_is_displayed() throws {
      let app = XCUIApplication()
      continueAfterFailure = false
      app.launchEnvironment = ["ENV": "TEST"]
      app.launch()
      
      XCTAssertEqual("No orders available!", app.staticTexts["noOrdersText"].label)
    }
  
}
