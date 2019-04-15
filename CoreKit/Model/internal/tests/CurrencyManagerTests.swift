/*******************************************************************************
 * CurrencyManagerTests.swift                                                  *
 * CoreKit Copyright© 2019; Electric Bolt Limited.                             *
 ******************************************************************************/

import XCTest
@testable import CoreKit

class CurrencyManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    public func testSingleton() {
        XCTAssertTrue(CurrencyManager.shared === CurrencyManager.shared)
    }
    
    public func testInit() {
        let manager = CurrencyManager()
        XCTAssertEqual(43, manager.list().count)
    }
    
    public func testRemovePopulate() {
        let manager = CurrencyManager()

        manager.remove(code: "NZD")
        XCTAssertNil(manager.get(code: "NZD"))
        XCTAssertEqual(42, manager.list().count)

        manager.removeAll()
        XCTAssertEqual(0, manager.list().count)

        manager.populateWithStaticList()
        XCTAssertEqual(43, manager.list().count)
        var list = manager.list()
        list.sort()
        XCTAssertEqual("AED", list[0].code)
        XCTAssertEqual("ZAR", list[42].code)
    }
    
    public func testList() {
        let manager = CurrencyManager()
        XCTAssertEqual(43, manager.list().count)
        var list = manager.list()
        for c in list {
            print(c)
        }
        XCTAssertEqual("AED", list[0].code)
        XCTAssertEqual("ZAR", list[42].code)
    }
    
    public func testGet() {
        let manager = CurrencyManager()
        XCTAssertNil(manager.get(code: "BOB"))
        XCTAssertNil(manager.get(code: ""))
        XCTAssertNotNil(manager.get(code: "NZD"))
    }

}
