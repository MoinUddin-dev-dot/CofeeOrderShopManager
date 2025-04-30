//
//  CofeeOrderShopE2ETests.swift
//  CofeeOrderShopE2ETests
//
//  Created by Moin on 4/29/25.
//

import XCTest

final class when_adding_a_new_coffee_order: XCTestCase{
    
    private var app: XCUIApplication!
    
    // called before running each test
    override func setUp() {
        app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV":"TEST"]
        app.launch()
        
        app.buttons["addNewOrderButton"].tap()
        
        let nameTextField = app.textFields["name"]
        let cofeeNameTextFIeld = app.textFields["coffeeName"]
        let priceTextFIeld = app.textFields["price"]
        let placeOrderButton = app.buttons["placeOrderButton"]
        
        nameTextField.tap()
        nameTextField.typeText("John doe")
        cofeeNameTextFIeld.tap()
        cofeeNameTextFIeld.typeText("Hot Coffee")
        priceTextFIeld.tap()
        priceTextFIeld.typeText("4.50")
        
        placeOrderButton.tap()
    }
    
    func test_should_display_coffee_order_successfully() throws {
        XCTAssertEqual("John doe", app.staticTexts["orderNameText"].label)
        XCTAssertEqual("Hot Coffee (Medium)", app.staticTexts["coffeeNameAndSizeText"].label)
        XCTAssertEqual("$4.50", app.staticTexts["coffeePriceText"].label)
    }
    
    //callled after running each test
    override func tearDown(){
        Task{
            guard let url = URL(string: "/test/clear-orders", relativeTo: URL(string: "https://island-bramble.glitch.me/test/orders"))else {
                return
            }
            let (_,_) =  try! await URLSession.shared.data(from: url)
        }
    }
}



final class when_app_is_launched_with_no_orders: XCTestCase {

    
    @MainActor
    func test_should_make_sure_no_orders_message_is_displayed() throws {
        
        let app = XCUIApplication()
        continueAfterFailure = false
        app.launchEnvironment = ["ENV": "TEST"]
        app.launch()

        XCTAssertEqual("No Orders Available", app.staticTexts["noOrdersText"].label)
    }

    
}
