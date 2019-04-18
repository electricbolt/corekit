/*******************************************************************************
 * CurrencyTests.swift                                                         *
 * CoreKit Copyright© 2019; Electric Bolt Limited.                             *
 ******************************************************************************/

import XCTest
@testable import CoreKit

class CurrencyTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDebugDescription() {
        let NZD = Currency(code: "NZD", name: "New Zealand dollar", flag: "🇳🇿", symbolPrefix: "$", symbolSuffix: "", exponent: 2, unit: "dollar", units: "dollars", subunit: "cent", subunits: "cents", prefix: "new zealand")
        XCTAssertEqual(NZD.debugDescription, "NZD,$,New Zealand dollar,2DP")
    }
    
}
