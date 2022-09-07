//
//  GreetingAppsUITests.swift
//  GreetingAppsUITests
//
//  Created by Gilang Ramadhan on 02/09/22.
//

import XCTest

final class GreetingAppsUITests: XCTestCase {
  func testExample() throws {
    let app = XCUIApplication()
    app.launch()
    app.buttons["Halo"].tap()
    app.alerts["Apa kabar?"].scrollViews.otherElements.buttons["OK"].tap()
  }
}
