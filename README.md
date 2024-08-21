# Hello Coffee ☕️

**A SwiftUI app for managing coffee orders.**

## Features ⚛️

* View a list of coffee orders
* Add new coffee orders
* Edit existing coffee orders
* Delete coffee orders

## Tech Stack 🖥️

* SwiftUI
* Swift Concurrency (async/await)
* URLSession for networking
* MVVM architecture
* XCTest for unit and UI testing

## Getting Started    🤩

1. Clone the repository.
2. Open the project in Xcode.
3. Build and run the app on a simulator or device.

**Note:** Make sure you have a compatible version of Xcode and iOS installed.

## Testing 📝

The project incorporates a comprehensive testing suite to ensure app quality and stability:

* **Unit Tests:** These tests focus on verifying the correctness of individual components in isolation, such as the `Webservice` class or the `CoffeeViewModel`.

* **UI Tests (End-to-End Tests):** These tests simulate user interactions with the app, ensuring critical user flows (adding, editing, deleting orders) function as expected. 

**Key Test Cases:**

* **`when_updating_an_existing_order`:** Validates that an existing order can be successfully edited and saved.
* **`when_deleting_an_order`:** Checks that an order is removed from the list after the delete operation.
* **`when_adding_a_new_coffee_order`:** Ensures that a new order is added correctly and displays the right information.
* **`when_app_is_launched_with_no_orders`:** Confirms the app shows the "No orders available" message when there are no orders.



