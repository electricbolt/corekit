/*******************************************************************************
 * MoneyTests.swift                                                            *
 * CoreKit Copyright© 2019; Electric Bolt Limited.                             *
 ******************************************************************************/

import XCTest
@testable import CoreKit

class MoneyTests: XCTestCase {

    var NZD = CurrencyManager.shared.get(code: "NZD")!
    var JPY = CurrencyManager.shared.get(code: "JPY")!

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testDebugDescription() {
        var m = Money(decimal: Decimal(string: "-1245.54")!, currency: NZD)
        XCTAssertEqual(m.debugDescription, "NZD -$1,245.54")
        m = Money(unavailable: NZD)
        XCTAssertEqual(m.debugDescription, "NZD N/A")
    }
    
    func testCurrency() {
        let m = Money(float: 0, currency: NZD)
        XCTAssertEqual(m.currency, NZD)
        XCTAssertNotEqual(m.currency, JPY)
    }
    
    func testFloatInit0DP() {
        var m = Money(float: 0, currency: JPY)
        XCTAssertEqual(0, m.floatValue)
        XCTAssertEqual(0, m.doubleValue)
        XCTAssertEqual(Decimal.init(0), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 0), m.decimalNumber)
        XCTAssertEqual("0", m.stringValue)
        
        m = Money(float: 1, currency: JPY)
        XCTAssertEqual(1, m.floatValue)
        XCTAssertEqual(1, m.doubleValue)
        XCTAssertEqual(Decimal.init(1), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 1), m.decimalNumber)
        XCTAssertEqual("1", m.stringValue)
        
        m = Money(float: 12248, currency: JPY)
        XCTAssertEqual(12248, m.floatValue)
        XCTAssertEqual(12248, m.doubleValue)
        XCTAssertEqual(Decimal.init(12248), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 12248), m.decimalNumber)
        XCTAssertEqual("12248", m.stringValue)
        
        m = Money(float: -12248, currency: JPY)
        XCTAssertEqual(-12248, m.floatValue)
        XCTAssertEqual(-12248, m.doubleValue)
        XCTAssertEqual(Decimal.init(-12248), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: -12248), m.decimalNumber)
        XCTAssertEqual("-12248", m.stringValue)
        
        m = Money(float: Float.nan, currency: JPY)
        XCTAssertTrue(m.floatValue.isNaN)
        XCTAssertTrue(m.doubleValue.isNaN)
        XCTAssertTrue(m.decimalValue.isNaN)
        XCTAssertEqual(NSDecimalNumber.notANumber, m.decimalNumber)
        XCTAssertEqual("", m.stringValue)
    }
    
    func testFloatInit2DP() {
        var m = Money(float: 0.0, currency: NZD)
        XCTAssertEqual(0.0, m.floatValue)
        XCTAssertEqual(0.0, m.doubleValue)
        XCTAssertEqual(Decimal.init(0.0), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 0.0), m.decimalNumber)
        XCTAssertEqual("0.00", m.stringValue)

        m = Money(float: 1.54, currency: NZD)
        XCTAssertEqual(1.54, m.floatValue)
        XCTAssertEqual(1.54, m.doubleValue)
        XCTAssertEqual(Decimal.init(1.54), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 1.54), m.decimalNumber)
        XCTAssertEqual("1.54", m.stringValue)

        m = Money(float: 12248.39, currency: NZD)
        XCTAssertEqual(12248.39, m.floatValue)
        XCTAssertEqual(12248.39, m.doubleValue)
        XCTAssertEqual(Decimal.init(12248.39), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 12248.39), m.decimalNumber)
        XCTAssertEqual("12248.39", m.stringValue)

        m = Money(float: -12248.39, currency: NZD)
        XCTAssertEqual(-12248.39, m.floatValue)
        XCTAssertEqual(-12248.39, m.doubleValue)
        XCTAssertEqual(Decimal.init(-12248.39), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: -12248.39), m.decimalNumber)
        XCTAssertEqual("-12248.39", m.stringValue)

        m = Money(float: Float.nan, currency: NZD)
        XCTAssertTrue(m.floatValue.isNaN)
        XCTAssertTrue(m.doubleValue.isNaN)
        XCTAssertTrue(m.decimalValue.isNaN)
        XCTAssertEqual(NSDecimalNumber.notANumber, m.decimalNumber)
        XCTAssertEqual("", m.stringValue)
    }

    func testDoubleInit0DP() {
        var m = Money(double: 0, currency: JPY)
        XCTAssertEqual(0, m.floatValue)
        XCTAssertEqual(0, m.doubleValue)
        XCTAssertEqual(Decimal.init(0), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 0), m.decimalNumber)
        XCTAssertEqual("0", m.stringValue)
        
        m = Money(double: 1, currency: JPY)
        XCTAssertEqual(1, m.floatValue)
        XCTAssertEqual(1, m.doubleValue)
        XCTAssertEqual(Decimal.init(1), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 1), m.decimalNumber)
        XCTAssertEqual("1", m.stringValue)
        
        m = Money(double: 12248, currency: JPY)
        XCTAssertEqual(12248, m.floatValue)
        XCTAssertEqual(12248, m.doubleValue)
        XCTAssertEqual(Decimal.init(12248), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 12248), m.decimalNumber)
        XCTAssertEqual("12248", m.stringValue)
        
        m = Money(double: -12248, currency: JPY)
        XCTAssertEqual(-12248, m.floatValue)
        XCTAssertEqual(-12248, m.doubleValue)
        XCTAssertEqual(Decimal.init(-12248), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: -12248), m.decimalNumber)
        XCTAssertEqual("-12248", m.stringValue)
        
        m = Money(double: Double.nan, currency: JPY)
        XCTAssertTrue(m.floatValue.isNaN)
        XCTAssertTrue(m.doubleValue.isNaN)
        XCTAssertTrue(m.decimalValue.isNaN)
        XCTAssertEqual(NSDecimalNumber.notANumber, m.decimalNumber)
        XCTAssertEqual("", m.stringValue)
    }
    
    func testDoubleInit2DP() {
        var m = Money(double: 0.0, currency: NZD)
        XCTAssertEqual(0.0, m.floatValue)
        XCTAssertEqual(0.0, m.doubleValue)
        XCTAssertEqual(Decimal.init(0.0), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 0.0), m.decimalNumber)
        XCTAssertEqual("0.00", m.stringValue)

        m = Money(double: 1.54, currency: NZD)
        XCTAssertEqual(1.54, m.floatValue)
        XCTAssertEqual(1.54, m.doubleValue)
        XCTAssertEqual(Decimal.init(1.54), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 1.54), m.decimalNumber)
        XCTAssertEqual("1.54", m.stringValue)
    
        m = Money(double: 12248.39, currency: NZD)
        XCTAssertEqual(12248.39, m.floatValue)
        XCTAssertEqual(12248.39, m.doubleValue)
        XCTAssertEqual(Decimal.init(12248.39), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 12248.39), m.decimalNumber)
        XCTAssertEqual("12248.39", m.stringValue)
        
        m = Money(double: -12248.39, currency: NZD)
        XCTAssertEqual(-12248.39, m.floatValue)
        XCTAssertEqual(-12248.39, m.doubleValue)
        XCTAssertEqual(Decimal.init(-12248.39), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: -12248.39), m.decimalNumber)
        XCTAssertEqual("-12248.39", m.stringValue)

        m = Money(double: Double.nan, currency: NZD)
        XCTAssertTrue(m.floatValue.isNaN)
        XCTAssertTrue(m.doubleValue.isNaN)
        XCTAssertTrue(m.decimalValue.isNaN)
        XCTAssertEqual(NSDecimalNumber.notANumber, m.decimalNumber)
        XCTAssertEqual("", m.stringValue)
    }
    
    func testDecimalInit0DP() {
        var m = Money(decimal: Decimal.zero, currency: JPY)
        XCTAssertEqual(0, m.floatValue)
        XCTAssertEqual(0, m.doubleValue)
        XCTAssertEqual(Decimal.init(0), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 0), m.decimalNumber)
        XCTAssertEqual("0", m.stringValue)
        
        m = Money(decimal: Decimal(string: "1")!, currency: JPY)
        XCTAssertEqual(1, m.floatValue)
        XCTAssertEqual(1, m.doubleValue)
        XCTAssertEqual(Decimal.init(1), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 1), m.decimalNumber)
        XCTAssertEqual("1", m.stringValue)
        
        m = Money(decimal: Decimal(string: "12248")!, currency: JPY)
        XCTAssertEqual(12248, m.floatValue)
        XCTAssertEqual(12248, m.doubleValue)
        XCTAssertEqual(Decimal.init(12248), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 12248), m.decimalNumber)
        XCTAssertEqual("12248", m.stringValue)
        
        m = Money(decimal: Decimal(string: "-12248")!, currency: JPY)
        XCTAssertEqual(-12248, m.floatValue)
        XCTAssertEqual(-12248, m.doubleValue)
        XCTAssertEqual(Decimal.init(-12248), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: -12248), m.decimalNumber)
        XCTAssertEqual("-12248", m.stringValue)
        
        m = Money(decimal: Decimal.nan, currency: JPY)
        XCTAssertTrue(m.floatValue.isNaN)
        XCTAssertTrue(m.doubleValue.isNaN)
        XCTAssertTrue(m.decimalValue.isNaN)
        XCTAssertEqual(NSDecimalNumber.notANumber, m.decimalNumber)
        XCTAssertEqual("", m.stringValue)
    }
    
    func testDecimalInit2DP() {
        var m = Money(decimal: Decimal.zero, currency: NZD)
        XCTAssertEqual(0.0, m.floatValue)
        XCTAssertEqual(0.0, m.doubleValue)
        XCTAssertEqual(Decimal.init(0.0), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 0.0), m.decimalNumber)
        XCTAssertEqual("0.00", m.stringValue)

        m = Money(decimal: Decimal(string: "1.54")!, currency: NZD)
        XCTAssertEqual(1.54, m.floatValue)
        XCTAssertEqual(1.54, m.doubleValue)
        XCTAssertEqual(Decimal.init(1.54), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 1.54), m.decimalNumber)
        XCTAssertEqual("1.54", m.stringValue)

        m = Money(decimal: Decimal(string: "12248.39")!, currency: NZD)
        XCTAssertEqual(12248.39, m.floatValue)
        XCTAssertEqual(12248.39, m.doubleValue)
        XCTAssertEqual(Decimal.init(12248.39), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 12248.39), m.decimalNumber)
        XCTAssertEqual("12248.39", m.stringValue)
        
        m = Money(decimal: Decimal(string: "-12248.39")!, currency: NZD)
        XCTAssertEqual(-12248.39, m.floatValue)
        XCTAssertEqual(-12248.39, m.doubleValue)
        XCTAssertEqual(Decimal.init(-12248.39), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: -12248.39), m.decimalNumber)
        XCTAssertEqual("-12248.39", m.stringValue)

        m = Money(decimal: Decimal.nan, currency: NZD)
        XCTAssertTrue(m.floatValue.isNaN)
        XCTAssertTrue(m.doubleValue.isNaN)
        XCTAssertTrue(m.decimalValue.isNaN)
        XCTAssertEqual(NSDecimalNumber.notANumber, m.decimalNumber)
        XCTAssertEqual("", m.stringValue)
    }

    func testStringInit0DP() {
        var m = Money(string: "0", currency: JPY)
        XCTAssertEqual(0, m.floatValue)
        XCTAssertEqual(0, m.doubleValue)
        XCTAssertEqual(Decimal.init(0), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 0), m.decimalNumber)
        XCTAssertEqual("0", m.stringValue)
        
        m = Money(string: "1", currency: JPY)
        XCTAssertEqual(1, m.floatValue)
        XCTAssertEqual(1, m.doubleValue)
        XCTAssertEqual(Decimal.init(1), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 1), m.decimalNumber)
        XCTAssertEqual("1", m.stringValue)
        
        m = Money(string: "12248", currency: JPY)
        XCTAssertEqual(12248, m.floatValue)
        XCTAssertEqual(12248, m.doubleValue)
        XCTAssertEqual(Decimal.init(12248), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 12248), m.decimalNumber)
        XCTAssertEqual("12248", m.stringValue)
        
        m = Money(string: "-12248", currency: JPY)
        XCTAssertEqual(-12248, m.floatValue)
        XCTAssertEqual(-12248, m.doubleValue)
        XCTAssertEqual(Decimal.init(-12248), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: -12248), m.decimalNumber)
        XCTAssertEqual("-12248", m.stringValue)
        
        m = Money(string: "", currency: JPY)
        XCTAssertTrue(m.floatValue.isNaN)
        XCTAssertTrue(m.doubleValue.isNaN)
        XCTAssertTrue(m.decimalValue.isNaN)
        XCTAssertEqual(NSDecimalNumber.notANumber, m.decimalNumber)
        XCTAssertEqual("", m.stringValue)
    }
    
    func testStringInit2DP() {
        var m = Money(string: "0.00", currency: NZD)
        XCTAssertEqual(0.0, m.floatValue)
        XCTAssertEqual(0.0, m.doubleValue)
        XCTAssertEqual(Decimal.init(0.0), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 0.0), m.decimalNumber)
        XCTAssertEqual("0.00", m.stringValue)
        
        m = Money(string: "1.54", currency: NZD)
        XCTAssertEqual(1.54, m.floatValue)
        XCTAssertEqual(1.54, m.doubleValue)
        XCTAssertEqual(Decimal.init(1.54), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 1.54), m.decimalNumber)
        XCTAssertEqual("1.54", m.stringValue)
        
        m = Money(string: "12248.39", currency: NZD)
        XCTAssertEqual(12248.39, m.floatValue)
        XCTAssertEqual(12248.39, m.doubleValue)
        XCTAssertEqual(Decimal.init(12248.39), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: 12248.39), m.decimalNumber)
        XCTAssertEqual("12248.39", m.stringValue)
        
        m = Money(string: "-12248.39", currency: NZD)
        XCTAssertEqual(-12248.39, m.floatValue)
        XCTAssertEqual(-12248.39, m.doubleValue)
        XCTAssertEqual(Decimal.init(-12248.39), m.decimalValue)
        XCTAssertEqual(NSDecimalNumber.init(floatLiteral: -12248.39), m.decimalNumber)
        XCTAssertEqual("-12248.39", m.stringValue)
        
        m = Money(string: "", currency: NZD)
        XCTAssertTrue(m.floatValue.isNaN)
        XCTAssertTrue(m.doubleValue.isNaN)
        XCTAssertTrue(m.decimalValue.isNaN)
        XCTAssertEqual(NSDecimalNumber.notANumber, m.decimalNumber)
        XCTAssertEqual("", m.stringValue)
    }
    
    func testComparable() {
        // == equality
        XCTAssertEqual(Money(string: "0.00", currency: NZD), Money(string: "0.00", currency: NZD))
        XCTAssertNotEqual(Money(string: "0.00", currency: NZD), Money(string: "0.01", currency: NZD))

        XCTAssertEqual(Money(string: "1.54", currency: NZD), Money(string: "1.54", currency: NZD))
        XCTAssertNotEqual(Money(string: "1.53", currency: NZD), Money(string: "1.54", currency: NZD))

        XCTAssertEqual(Money(string: "12248.39", currency: NZD), Money(string: "12248.39", currency: NZD))
        XCTAssertNotEqual(Money(string: "12248.38", currency: NZD), Money(string: "12248.39", currency: NZD))
        
        XCTAssertEqual(Money(string: "-12248.39", currency: NZD), Money(string: "-12248.39", currency: NZD))
        XCTAssertNotEqual(Money(string: "-12248.38", currency: NZD), Money(string: "-12248.39", currency: NZD))

        XCTAssertEqual(Money(unavailable: NZD), Money(unavailable: NZD))
        XCTAssertNotEqual(Money(unavailable: NZD), Money(string: "-12248.39", currency: NZD))

        // < less than
        XCTAssertFalse(Money(string: "0.00", currency: NZD) < Money(string: "0.00", currency: NZD))
        XCTAssertTrue(Money(string: "0.00", currency: NZD) < Money(string: "0.01", currency: NZD))
        
        XCTAssertFalse(Money(string: "1.54", currency: NZD) < Money(string: "1.54", currency: NZD))
        XCTAssertTrue(Money(string: "1.53", currency: NZD) < Money(string: "1.54", currency: NZD))
        
        XCTAssertFalse(Money(string: "12248.39", currency: NZD) < Money(string: "12248.39", currency: NZD))
        XCTAssertTrue(Money(string: "12248.38", currency: NZD) < Money(string: "12248.39", currency: NZD))
        
        XCTAssertFalse(Money(string: "-12248.39", currency: NZD) < Money(string: "-12248.39", currency: NZD))
        XCTAssertTrue(Money(string: "-12248.39", currency: NZD) < Money(string: "-12248.38", currency: NZD))
        
        XCTAssertFalse(Money(unavailable: NZD) < Money(unavailable: NZD))
        XCTAssertTrue(Money(unavailable: NZD) < Money(string: "-12248.39", currency: NZD))
        
        XCTAssertEqual(Money(string: "0", currency: JPY), Money(string: "0", currency: JPY))
        XCTAssertEqual(Money(string: "163", currency: JPY), Money(string: "163", currency: JPY))
    }
    
    func testHashable() {
        let money1 = Money(string: "0.00", currency: NZD)
        var hasher1 = Hasher()
        money1.hash(into: &hasher1)

        let money2 = Money(string: "1", currency: JPY)
        var hasher2 = Hasher()
        money2.hash(into: &hasher2)
        
        XCTAssertNotEqual(hasher1.finalize(), hasher2.finalize())
    }
    
    func testNegate2DP() {
        XCTAssertEqual(Money(string: "-3.45", currency: NZD), -(Money(string: "3.45", currency: NZD)))
    }
    
    func testAdd2DP() {
        XCTAssertEqual(Money(string: "0.00", currency: NZD), (Money(string: "0.00", currency: NZD) + Money(string: "0.00", currency: NZD)))
        XCTAssertEqual(Money(string: "0.03", currency: NZD), (Money(string: "0.01", currency: NZD) + Money(string: "0.02", currency: NZD)))
        XCTAssertEqual(Money(string: "-143.90", currency: NZD), (Money(string: "150.29", currency: NZD) + Money(string: "-294.19", currency: NZD)))

        // Adding a real amount and an unavailable amount always equals an unavailable amount
        XCTAssertEqual(Money(unavailable: NZD), (Money(string: "150.29", currency: NZD) + Money(unavailable: NZD)))
    }
   
    func testAddEquals2DP() {
        var m1 = Money(string: "1.23", currency: NZD)
        let m2 = Money(string: "4.56", currency: NZD)
        m1 += m2
        XCTAssertEqual(m1, Money(string: "5.79", currency: NZD))
        
        // Adding a real amount and an unavailable amount always equals an unavailable amount
        let m3 = Money(unavailable: NZD)
        m1 += m3
        XCTAssertEqual(m1, Money(unavailable: NZD))
    }

    func testMinus2DP() {
        XCTAssertEqual(Money(string: "0.00", currency: NZD), (Money(string: "0.00", currency: NZD) - Money(string: "0.00", currency: NZD)))
        XCTAssertEqual(Money(string: "-0.01", currency: NZD), (Money(string: "0.01", currency: NZD) - Money(string: "0.02", currency: NZD)))
        XCTAssertEqual(Money(string: "444.48", currency: NZD), (Money(string: "150.29", currency: NZD) - Money(string: "-294.19", currency: NZD)))
        
        // Adding a real amount and an unavailable amount always equals an unavailable amount
        XCTAssertEqual(Money(unavailable: NZD), (Money(string: "150.29", currency: NZD) + Money(unavailable: NZD)))
    }
    
    func testMinusEquals2DP() {
        var m1 = Money(string: "1.23", currency: NZD)
        let m2 = Money(string: "4.56", currency: NZD)
        m1 -= m2
        XCTAssertEqual(m1, Money(string: "-3.33", currency: NZD))
        
        // Adding a real amount and an unavailable amount always equals an unavailable amount
        let m3 = Money(unavailable: NZD)
        m1 += m3
        XCTAssertEqual(m1, Money(unavailable: NZD))
    }
}
