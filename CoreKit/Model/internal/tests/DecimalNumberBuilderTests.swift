/*******************************************************************************
 * DecimalNumberBuilderTests.swift                                             *
 * CoreKit Copyright© 2019; Electric Bolt Limited.                             *
 ******************************************************************************/

import XCTest
@testable import CoreKit

class DecimalNumberBuilderTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func XCTAssertAmount(amount parseAmount: String, expected expectedAmount: NSDecimalNumber, file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(NSDecimalNumber(string: parseAmount).decimalValue, expectedAmount.decimalValue, file: file, line: line)
    }
    
    func testBuilder0DP() {
        do {
            var builder = try DecimalNumberBuilder(fractionalPrecision: 0, isNegative: false)
            try builder.addDigit("1")
            XCTAssertAmount(amount: "1", expected: try builder.build())
            try builder.addDigit("2")
            XCTAssertAmount(amount: "12", expected: try builder.build())
            try builder.addDigit("3")
            XCTAssertAmount(amount: "123", expected: try builder.build())
            try builder.addDigit("4")
            XCTAssertAmount(amount: "1234", expected: try builder.build())
            
            do {
                try builder.setFractional()
                XCTAssertFalse(true, "Should have thrown DecimalNumberBuilderError.unexpectedDecimalSeperator error")
            } catch DecimalNumberBuilderError.unexpectedDecimalSeperator {
                // correct
            } catch {
                XCTAssertFalse(true, "Should not have thrown \(error)")
            }
        } catch {
            XCTAssertFalse(true, "Should not have thrown \(error)")
        }
    }
    
    func testBuilder1DP() {
        do {
            var builder = try DecimalNumberBuilder(fractionalPrecision: 1, isNegative: false)
            try builder.addDigit("1")
            XCTAssertAmount(amount: "1.0", expected: try builder.build())
            try builder.addDigit("2")
            XCTAssertAmount(amount: "12.0", expected: try builder.build())
            try builder.addDigit("3")
            XCTAssertAmount(amount: "123.0", expected: try builder.build())
            try builder.addDigit("4")
            XCTAssertAmount(amount: "1234.0", expected: try builder.build())
            try builder.setFractional()
            try builder.addDigit("5")
            XCTAssertAmount(amount: "1234.5", expected: try builder.build())
            
            do {
                try builder.addDigit("6")
                XCTAssertFalse(true, "Should have thrown DecimalNumberBuilderError.tooManyFractionalDigits error")
            } catch DecimalNumberBuilderError.tooManyFractionalDigits {
                // correct
            } catch {
                XCTAssertFalse(true, "Should not have thrown \(error)")
            }
        } catch {
            XCTAssertFalse(true, "Should not have thrown \(error)")
        }
    }
    
    func testBuilder2DP() {
        do {
            var builder = try DecimalNumberBuilder(fractionalPrecision: 2, isNegative: false)
            try builder.addDigit("1")
            XCTAssertAmount(amount: "1.00", expected: try builder.build())
            try builder.addDigit("2")
            XCTAssertAmount(amount: "12.00", expected: try builder.build())
            try builder.addDigit("3")
            XCTAssertAmount(amount: "123.00", expected: try builder.build())
            try builder.addDigit("4")
            XCTAssertAmount(amount: "1234.00", expected: try builder.build())
            try builder.setFractional()
            try builder.addDigit("5")
            XCTAssertAmount(amount: "1234.50", expected: try builder.build())
            try builder.addDigit("6")
            XCTAssertAmount(amount: "1234.56", expected: try builder.build())
            
            do {
                try builder.addDigit("7")
                XCTAssertFalse(true, "Should have thrown DecimalNumberBuilderError.tooManyFractionalDigits error")
            } catch DecimalNumberBuilderError.tooManyFractionalDigits {
                // correct
            } catch {
                XCTAssertFalse(true, "Should not have thrown \(error)")
            }
        } catch {
            XCTAssertFalse(true, "Should not have thrown \(error)")
        }
    }
    
    func testBuilder3DP() {
        do {
            var builder = try DecimalNumberBuilder(fractionalPrecision: 3, isNegative: false)
            try builder.addDigit("1")
            XCTAssertAmount(amount: "1.000", expected: try builder.build())
            try builder.addDigit("2")
            XCTAssertAmount(amount: "12.000", expected: try builder.build())
            try builder.addDigit("3")
            XCTAssertAmount(amount: "123.000", expected: try builder.build())
            try builder.addDigit("4")
            XCTAssertAmount(amount: "1234.000", expected: try builder.build())
            try builder.setFractional()
            try builder.addDigit("5")
            XCTAssertAmount(amount: "1234.500", expected: try builder.build())
            try builder.addDigit("6")
            XCTAssertAmount(amount: "1234.560", expected: try builder.build())
            try builder.addDigit("7")
            XCTAssertAmount(amount: "1234.567", expected: try builder.build())
            
            do {
                try builder.addDigit("8")
                XCTAssertFalse(true, "Should have thrown DecimalNumberBuilderError.tooManyFractionalDigits error")
            } catch DecimalNumberBuilderError.tooManyFractionalDigits {
                // correct
            } catch {
                XCTAssertFalse(true, "Should not have thrown \(error)")
            }
        } catch {
            XCTAssertFalse(true, "Should not have thrown \(error)")
        }
    }
    
    func testBuilder4DP() {
        do {
            var builder = try DecimalNumberBuilder(fractionalPrecision: 4, isNegative: true)
            try builder.addDigit("1")
            XCTAssertAmount(amount: "-1.0000", expected: try builder.build())
            try builder.addDigit("2")
            XCTAssertAmount(amount: "-12.0000", expected: try builder.build())
            try builder.addDigit("3")
            XCTAssertAmount(amount: "-123.0000", expected: try builder.build())
            try builder.addDigit("4")
            XCTAssertAmount(amount: "-1234.0000", expected: try builder.build())
            try builder.setFractional()
            try builder.addDigit("5")
            XCTAssertAmount(amount: "-1234.5000", expected: try builder.build())
            try builder.addDigit("6")
            XCTAssertAmount(amount: "-1234.5600", expected: try builder.build())
            try builder.addDigit("7")
            XCTAssertAmount(amount: "-1234.5670", expected: try builder.build())
            try builder.addDigit("8")
            XCTAssertAmount(amount: "-1234.5678", expected: try builder.build())
            do {
                try builder.addDigit("9")
                XCTAssertFalse(true, "Should have thrown DecimalNumberBuilderError.tooManyFractionalDigits error")
            } catch DecimalNumberBuilderError.tooManyFractionalDigits {
                // correct
            } catch {
                XCTAssertFalse(true, "Should not have thrown \(error)")
            }
            
            
        } catch {
            XCTAssertFalse(true, "Should not have thrown \(error)")
        }
    }
    
    func testBuilder5DP() {
        do {
            var _ = try DecimalNumberBuilder(fractionalPrecision: 5, isNegative: false)
        } catch DecimalNumberBuilderError.tooManyFractionalDigits {
            // correct
        } catch {
            XCTAssertFalse(true, "Should not have thrown \(error)")
        }
    }

    func testBuilderTooManyDigits0DP() {
        do {
            var builder = try DecimalNumberBuilder(fractionalPrecision: 0, isNegative: false)
            try builder.addDigit("1")
            try builder.addDigit("2")
            try builder.addDigit("3")
            try builder.addDigit("4")
            try builder.addDigit("5")
            try builder.addDigit("6")
            try builder.addDigit("7")
            try builder.addDigit("8")
            try builder.addDigit("9")
            try builder.addDigit("0")
            try builder.addDigit("1")
            try builder.addDigit("2")
            try builder.addDigit("3")
            try builder.addDigit("4")
            try builder.addDigit("5")
            do {
                try builder.addDigit("6")
            } catch DecimalNumberBuilderError.tooManyDigits {
                // correct
            } catch {
                XCTAssertFalse(true, "Should not have thrown \(error)")
            }
        } catch {
            XCTAssertFalse(true, "Should not have thrown \(error)")
        }
    }

    func testBuilderTooManyDigits1DP() {
        do {
            var builder = try DecimalNumberBuilder(fractionalPrecision: 1, isNegative: false)
            try builder.addDigit("1")
            try builder.addDigit("2")
            try builder.addDigit("3")
            try builder.addDigit("4")
            try builder.addDigit("5")
            try builder.addDigit("6")
            try builder.addDigit("7")
            try builder.addDigit("8")
            try builder.addDigit("9")
            try builder.addDigit("0")
            try builder.addDigit("1")
            try builder.addDigit("2")
            try builder.addDigit("3")
            try builder.addDigit("4")
            try builder.setFractional()
            try builder.addDigit("5")
            do {
                try builder.addDigit("6")
            } catch DecimalNumberBuilderError.tooManyDigits {
                // correct
            } catch {
                XCTAssertFalse(true, "Should not have thrown \(error)")
            }
        } catch {
            XCTAssertFalse(true, "Should not have thrown \(error)")
        }
    }

}
