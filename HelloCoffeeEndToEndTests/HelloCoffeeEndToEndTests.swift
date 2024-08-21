//
//  HelloCoffeeEndToEndTests.swift
//  HelloCoffeeEndToEndTests
//
//  Created by Brandon Jones on 7/4/24.
//

import XCTest

final class when_updating_an_existing_order: XCTestCase {
  
  private var app: XCUIApplication!
  override func setUp() {
    app = XCUIApplication()
    continueAfterFailure = false
    app.launchEnvironment = ["ENV": "TEST"]
    app.launch()
    
    //go to the add order screen
    app.buttons["addNewOrderButton"].tap()
    
    //write into textfields
    let nameTextField = app.textFields["name"]
    let coffeeNameTextField = app.textFields["coffeeName"]
    let priceTextField = app.textFields["price"]
    let coffeeSizePicker = app.segmentedControls["coffeeSize"]
    let placeOrderButton = app.buttons["placeOrderButton"]
    
    
    
    nameTextField.tap()
    nameTextField.typeText("Sora")
    
    coffeeNameTextField.tap()
    coffeeNameTextField.typeText("Tea")
    
    priceTextField.tap()
    priceTextField.typeText("3.50")
    
    coffeeSizePicker.buttons["Small"].tap()
    
    //place the order
    placeOrderButton.tap()
  }
  func test_should_update_order_successfully() throws {
    let _ = app.collectionViews["ordersList"].buttons["orderNameText-coffeeNameAndSizeText-coffeePriceText"].waitForExistence(timeout: 5.0)
    let orderList = app.collectionViews["ordersList"]
    orderList.buttons["orderNameText-coffeeNameAndSizeText-coffeePriceText"].tap()
    
    app.buttons["editOrderButton"].tap()
    
    let nameTextField = app.textFields["name"]
    let coffeeNameTextField = app.textFields["coffeeName"]
    let priceTextField = app.textFields["price"]
    let coffeeSizePicker = app.segmentedControls["coffeeSize"]
    let placeOrderButton = app.buttons["placeOrderButton"]
    
    let _ = nameTextField.waitForExistence(timeout: 2.0)
    nameTextField.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    nameTextField.typeText("Sora Edit")
    
    let _ = coffeeNameTextField.waitForExistence(timeout: 2.0)
    coffeeNameTextField.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    coffeeNameTextField.typeText("Tea Edit")
    
    let _ = priceTextField.waitForExistence(timeout: 2.0)
    priceTextField.tap(withNumberOfTaps: 2, numberOfTouches: 1)
    priceTextField.typeText("4.50")
    
    coffeeSizePicker.buttons["Large"].tap()
    
    placeOrderButton.tap()
    
    let updatedCoffeeNameText = app.staticTexts["coffeeNameText"]
    let _ = updatedCoffeeNameText.waitForExistence(timeout: 5.0)
    
    XCTAssertEqual("Tea Edit", updatedCoffeeNameText.label)
  }
  // TEAR DOWN FUNCTIONS AND THEN DELETES ALL ORDERS FROM THE TEST DATABASE
  override func tearDown() async throws {
    // Make this an async function to use 'await'
    Task { // Start a new asynchronous task
      guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://hello-coffee-letsgobjones.glitch.me")!) else { return }
      let (_, _) = try await URLSession.shared.data(from: url)
    } // End of the asynchronous task
  }
}



final class when_deleting_an_order: XCTestCase {
  private var app: XCUIApplication!
  override func setUp()  {
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
    nameTextField.typeText("Axel")
    
    coffeeNameTextField.tap()
    coffeeNameTextField.typeText("Hot Coffee")
    
    priceTextField.tap()
    priceTextField.typeText("4.50")
    
    coffeeSizePicker.buttons["Large"].tap()
    
    //place the order
    placeOrderButton.tap()
  }
  
  
  func test_should_delete_order_successfully() throws {
    let collectionViewsQuery = XCUIApplication().collectionViews
    
    let cellsQuery = collectionViewsQuery.cells
    let element = cellsQuery.children(matching: .other).element(boundBy: 1).children(matching: .other).element
    XCTAssertTrue(element.waitForExistence(timeout: 5.0))
    element.swipeLeft()
    
    let deleteButton = collectionViewsQuery.buttons["Delete"]
    XCTAssertTrue(deleteButton.waitForExistence(timeout: 5.0))
    deleteButton.tap()
    
    let orderList = app.collectionViews["orderList"]
    XCTAssertEqual(0, orderList.cells.count)
  }
  // TEAR DOWN FUNCTIONS AND THEN DELETES ALL ORDERS FROM THE TEST DATABASE
  override func tearDown() async throws {
    // Make this an async function to use 'await'
    Task { // Start a new asynchronous task
      guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://hello-coffee-letsgobjones.glitch.me")!) else { return }
      let (_, _) = try await URLSession.shared.data(from: url)
    } // End of the asynchronous task
  }
}


final class when_adding_a_new_coffee_order: XCTestCase {
  private var app: XCUIApplication!
  override func setUp() async throws {
    // Make this an async function to use 'await'
    Task { // Start a new asynchronous task
      guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://hello-coffee-letsgobjones.glitch.me")!) else { return }
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
    
    coffeeNameTextField.tap()
    coffeeNameTextField.typeText("Espresso")
    
    
    priceTextField.tap()
    priceTextField.typeText("2.50")
    
    coffeeSizePicker.buttons["Small"].tap()
    
    //place the order
    placeOrderButton.tap()
  }
  
  func test_should_display_coffee_order_in_list_successfully() throws {
    XCTAssertEqual("Brandon", app.staticTexts["orderNameText"].label)
    XCTAssertEqual("Espresso (Small)", app.staticTexts["coffeeNameAndSizeText"].label)
    XCTAssertEqual("$2.50", app.staticTexts["coffeePriceText"].label)
  }
  
  // TEAR DOWN FUNCTIONS AND THEN DELETES ALL ORDERS FROM THE TEST DATABASE
  override func tearDown() async throws {
    // Make this an async function to use 'await'
    Task { // Start a new asynchronous task
      guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://hello-coffee-letsgobjones.glitch.me")!) else { return }
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
