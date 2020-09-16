/*******************************************************************************
 * MoneyFormatterFormattingTests.swift                                         *
 * CoreKit Copyright© 2019; Electric Bolt Limited.                             *
 ******************************************************************************/

import XCTest
@testable import CoreKit

class MoneyFormatterFormattingTests: XCTestCase {
    
    var formatter: MoneyFormatter!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func XCTAssertFormat(amount: String, expected: String, symbols: Bool = true, grouping: Bool = true, negative: Bool = true, file: StaticString = #file, line: UInt = #line) {
        let value = NSDecimalNumber(string: amount)
        let s = formatter.string(for: value, symbols: symbols, grouping: grouping, negative: negative)
        XCTAssertEqual(expected, s!, file: file, line: line)
    }
    
    func testFormatError() {
        formatter = MoneyFormatter(CurrencyManager.shared.get(code: "JPY")!)
        
        XCTAssertEqual("", formatter.string(for: "cat"))
        XCTAssertEqual("", formatter.string(for: nil))
    }
    
    func testDecimalValue() {
        formatter = MoneyFormatter(CurrencyManager.shared.get(code: "JPY")!)
        XCTAssertEqual(formatter.decimalValue(for: nil), Decimal.nan)
        XCTAssertEqual(formatter.decimalValue(for: Decimal.nan), Decimal.nan)
        XCTAssertEqual(formatter.decimalValue(for: "Hello, World!"), Decimal.nan)
        XCTAssertEqual(formatter.decimalValue(for: Money(string: "1", currency: CurrencyManager.shared.get(code: "JPY")!)), Decimal(string: "1")!)
        XCTAssertEqual(formatter.decimalValue(for: Decimal(string: "1")!), Decimal(string: "1")!)
        XCTAssertEqual(formatter.decimalValue(for: NSDecimalNumber(string: "1")), Decimal(string: "1")!)
    }

    func testFormatDecimalAmounts0DP() {
        formatter = MoneyFormatter(CurrencyManager.shared.get(code: "JPY")!)
        
        XCTAssertFormat(amount: "0", expected: "￥0")
        XCTAssertFormat(amount: "1", expected: "￥1")
        XCTAssertFormat(amount: "12", expected: "￥12")
        XCTAssertFormat(amount: "123", expected: "￥123")
        XCTAssertFormat(amount: "1234", expected: "￥1,234")
        XCTAssertFormat(amount: "12345", expected: "￥12,345")
        XCTAssertFormat(amount: "123456", expected: "￥123,456")
        XCTAssertFormat(amount: "1234567", expected: "￥1,234,567")
        XCTAssertFormat(amount: "12345678", expected: "￥12,345,678")
        XCTAssertFormat(amount: "123456789", expected: "￥123,456,789")
        XCTAssertFormat(amount: "1234567890", expected: "￥1,234,567,890")
        
        XCTAssertFormat(amount: "-1", expected: "-￥1")
        XCTAssertFormat(amount: "-12", expected: "-￥12")
        XCTAssertFormat(amount: "-123", expected: "-￥123")
        XCTAssertFormat(amount: "-1234", expected: "-￥1,234")
        XCTAssertFormat(amount: "-12345", expected: "-￥12,345")
        XCTAssertFormat(amount: "-123456", expected: "-￥123,456")
        XCTAssertFormat(amount: "-1234567", expected: "-￥1,234,567")
        XCTAssertFormat(amount: "-12345678", expected: "-￥12,345,678")
        XCTAssertFormat(amount: "-123456789", expected: "-￥123,456,789")
        XCTAssertFormat(amount: "-1234567890", expected: "-￥1,234,567,890")
        
        XCTAssertFormat(amount: "1", expected: "1", symbols: false)
        XCTAssertFormat(amount: "-1", expected: "-1", symbols: false)
        
        XCTAssertFormat(amount: "1234", expected: "￥1234", grouping: false)
        XCTAssertFormat(amount: "-1234", expected: "-￥1234", grouping: false)
        
        XCTAssertFormat(amount: "1234", expected: "￥1,234", negative: false)
        XCTAssertFormat(amount: "-1234", expected: "￥1,234", negative: false)
        
        XCTAssertFormat(amount: "1234", expected: "￥1,234")
        XCTAssertFormat(amount: "-1234", expected: "-￥1,234")
        
        XCTAssertFormat(amount: "1234", expected: "1,234", symbols: false)
        XCTAssertFormat(amount: "-1234", expected: "-1,234", symbols: false)
        
        XCTAssertFormat(amount: "1234", expected: "1234", symbols: false, grouping: false)
        XCTAssertFormat(amount: "-1234", expected: "-1234", symbols: false, grouping: false)
        
        XCTAssertFormat(amount: "1234", expected: "1234", symbols: false, grouping: false, negative: false)
        XCTAssertFormat(amount: "-1234", expected: "1234", symbols: false, grouping: false, negative: false)
    }

    func testFormatDecimalAmounts2DP() {
        formatter = MoneyFormatter(CurrencyManager.shared.get(code: "NZD")!)

        XCTAssertFormat(amount: "0.12", expected: "$0.12")
        XCTAssertFormat(amount: "1.23", expected: "$1.23")
        XCTAssertFormat(amount: "12.34", expected: "$12.34")
        XCTAssertFormat(amount: "123.45", expected: "$123.45")
        XCTAssertFormat(amount: "1234.56", expected: "$1,234.56")
        XCTAssertFormat(amount: "12345.67", expected: "$12,345.67")
        XCTAssertFormat(amount: "123456.78", expected: "$123,456.78")
        XCTAssertFormat(amount: "1234567.89", expected: "$1,234,567.89")
        XCTAssertFormat(amount: "12345678.90", expected: "$12,345,678.90")
        XCTAssertFormat(amount: "123456789.01", expected: "$123,456,789.01")
        XCTAssertFormat(amount: "1234567890.12", expected: "$1,234,567,890.12")

        XCTAssertFormat(amount: "-0.12", expected: "-$0.12")
        XCTAssertFormat(amount: "-1.23", expected: "-$1.23")
        XCTAssertFormat(amount: "-12.34", expected: "-$12.34")
        XCTAssertFormat(amount: "-123.45", expected: "-$123.45")
        XCTAssertFormat(amount: "-1234.56", expected: "-$1,234.56")
        XCTAssertFormat(amount: "-12345.67", expected: "-$12,345.67")
        XCTAssertFormat(amount: "-123456.78", expected: "-$123,456.78")
        XCTAssertFormat(amount: "-1234567.89", expected: "-$1,234,567.89")
        XCTAssertFormat(amount: "-12345678.90", expected: "-$12,345,678.90")
        XCTAssertFormat(amount: "-123456789.01", expected: "-$123,456,789.01")
        XCTAssertFormat(amount: "-1234567890.12", expected: "-$1,234,567,890.12")

        XCTAssertFormat(amount: "1.23", expected: "1.23", symbols: false)
        XCTAssertFormat(amount: "-1.23", expected: "-1.23", symbols: false)

        XCTAssertFormat(amount: "1234.56", expected: "$1234.56", grouping: false)
        XCTAssertFormat(amount: "-1234.56", expected: "-$1234.56", grouping: false)

        XCTAssertFormat(amount: "1234.56", expected: "$1,234.56", negative: false)
        XCTAssertFormat(amount: "-1234.56", expected: "$1,234.56", negative: false)
        
        XCTAssertFormat(amount: "1234.56", expected: "1234.56", symbols: false, grouping: false, negative: false)
        XCTAssertFormat(amount: "-1234.56", expected: "1234.56", symbols: false, grouping: false, negative: false)
    }
    
    func testParseStringAmounts3DPAndSuffixUnicode() {
        // Unicode characters. 1f496=sparkling heart (💖)
        formatter = MoneyFormatter(Currency(code: "BST", name: "BST bs", flag: " ", symbolPrefix: "", symbolSuffix: "\u{1f496}bs", exponent: 3, unit: "", units: "", subunit: "", subunits: "", prefix: ""))
        
        XCTAssertFormat(amount: "0.123", expected: "0.123\u{1f496}bs")
        XCTAssertFormat(amount: "1.234", expected: "1.234\u{1f496}bs")
        XCTAssertFormat(amount: "12.345", expected: "12.345\u{1f496}bs")
        XCTAssertFormat(amount: "123.456", expected: "123.456\u{1f496}bs")
        XCTAssertFormat(amount: "1234.567", expected: "1,234.567\u{1f496}bs")
        XCTAssertFormat(amount: "12345.678", expected: "12,345.678\u{1f496}bs")
        XCTAssertFormat(amount: "123456.789", expected: "123,456.789\u{1f496}bs")
        XCTAssertFormat(amount: "1234567.890", expected: "1,234,567.890\u{1f496}bs")
        XCTAssertFormat(amount: "12345678.901", expected: "12,345,678.901\u{1f496}bs")
        XCTAssertFormat(amount: "123456789.012", expected: "123,456,789.012\u{1f496}bs")
        XCTAssertFormat(amount: "1234567890.123", expected: "1,234,567,890.123\u{1f496}bs")

        XCTAssertFormat(amount: "-0.123", expected: "-0.123\u{1f496}bs")
        XCTAssertFormat(amount: "-1.234", expected: "-1.234\u{1f496}bs")
        XCTAssertFormat(amount: "-12.345", expected: "-12.345\u{1f496}bs")
        XCTAssertFormat(amount: "-123.456", expected: "-123.456\u{1f496}bs")
        XCTAssertFormat(amount: "-1234.567", expected: "-1,234.567\u{1f496}bs")
        XCTAssertFormat(amount: "-12345.678", expected: "-12,345.678\u{1f496}bs")
        XCTAssertFormat(amount: "-123456.789", expected: "-123,456.789\u{1f496}bs")
        XCTAssertFormat(amount: "-1234567.890", expected: "-1,234,567.890\u{1f496}bs")
        XCTAssertFormat(amount: "-12345678.901", expected: "-12,345,678.901\u{1f496}bs")
        XCTAssertFormat(amount: "-123456789.012", expected: "-123,456,789.012\u{1f496}bs")
        XCTAssertFormat(amount: "-1234567890.123", expected: "-1,234,567,890.123\u{1f496}bs")

        XCTAssertFormat(amount: "1.234", expected: "1.234", symbols: false)
        XCTAssertFormat(amount: "-1.234", expected: "-1.234", symbols: false)
        
        XCTAssertFormat(amount: "1234.567", expected: "1234.567\u{1f496}bs", grouping: false)
        XCTAssertFormat(amount: "-1234.567", expected: "-1234.567\u{1f496}bs", grouping: false)
        
        XCTAssertFormat(amount: "1234.567", expected: "1,234.567\u{1f496}bs", negative: false)
        XCTAssertFormat(amount: "-1234.567", expected: "1,234.567\u{1f496}bs", negative: false)
        
        XCTAssertFormat(amount: "1234.567", expected: "1,234.567", symbols: false)
        XCTAssertFormat(amount: "-1234.567", expected: "-1,234.567", symbols: false)
        
        XCTAssertFormat(amount: "1234.567", expected: "1234.567", symbols: false, grouping: false, negative: false)
        XCTAssertFormat(amount: "-1234.567", expected: "1234.567", symbols: false, grouping: false, negative: false)
    }

}

