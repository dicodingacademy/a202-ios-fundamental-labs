//
//  UITestingUITests.swift
//  UITestingUITests
//
//  Created by Gilang Ramadhan on 28/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import XCTest

class UITestingUITests: XCTestCase {

  func testExample() throws {
    let app = XCUIApplication()
    app.launch()
    app.buttons["Halo"].tap()
    app.alerts["Apa kabar?"].scrollViews.otherElements.buttons["OK"].tap()
  }

}
