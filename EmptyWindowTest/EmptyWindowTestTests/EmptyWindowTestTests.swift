//
//  EmptyWindowTestTests.swift
//  EmptyWindowTestTests
//
//  Created by Gilang Ramadhan on 28/06/20.
//  Copyright © 2020 Dicoding Indonesia. All rights reserved.
//

import XCTest
 
@testable import EmptyWindowTest
class EmptyWindowTestTests: XCTestCase {
 
    var viewController = ViewController()
    
    func testDicodingSwift() {
        let input = "swift"
        let output = "dicoding"
        XCTAssertEqual(output, self.viewController.dicodingSwift(input), "Failed to produce \(output) from \(input)")
    }
}

