/*******************************************************************************
 * MoneyFormatterParsingTests.swift                                            *
 * CoreKit Copyright© 2019; Electric Bolt Limited.                             *
 ******************************************************************************/

import XCTest
@testable import CoreKit

class MoneyFormatterParsingTests: XCTestCase {
    
    var formatter: MoneyFormatter!

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func XCTAssertParse(parse: String, expected: String, file: StaticString = #file, line: UInt = #line) {
        var value: AnyObject?
        var XCTAssertError: NSString?
        let result = formatter.getObjectValue(&value, for: parse, errorDescription: &XCTAssertError)
        XCTAssertTrue(result, file: file, line: line)
        if result == true {
            let computed = (value as! NSDecimalNumber).decimalValue
            let expected = NSDecimalNumber(string: expected).decimalValue
            XCTAssertEqual(computed, expected, file: file, line: line)
        }
        XCTAssertNil(XCTAssertError, file: file, line: line)
    }
    
    func XCTAssertError(parse: String, expected: String, file: StaticString = #file, line: UInt = #line) {
        var value: AnyObject?
        var XCTAssertError: NSString?
        let result = formatter.getObjectValue(&value, for: parse, errorDescription: &XCTAssertError)
        XCTAssertFalse(result, file: file, line: line)
        XCTAssertNil(value, file: file, line: line)
        XCTAssertEqual(XCTAssertError, expected as NSString, file: file, line: line)
    }
    
    func testParseStringAmounts0DP() {
        formatter = MoneyFormatter(CurrencyManager.shared.get(code: "JPY")!)

        XCTAssertError(parse: "", expected: "Digits expected, none found for input string ''")
        XCTAssertError(parse: "1.2", expected: "Unexpected decimal seperator character '.' for input string '1.2'")
        XCTAssertError(parse: "-1.2", expected: "Unexpected decimal seperator character '.' for input string '-1.2'")
        XCTAssertError(parse: ".1", expected: "Unexpected decimal seperator character '.' for input string '.1'")
        XCTAssertError(parse: "1.", expected: "Unexpected decimal seperator character '.' for input string '1.'")
        XCTAssertError(parse: "-.1", expected: "Unexpected decimal seperator character '.' for input string '-.1'")
        XCTAssertError(parse: "-1.", expected: "Unexpected decimal seperator character '.' for input string '-1.'")
        
        XCTAssertError(parse: "1abc", expected: "Invalid character 'a' for input string '1abc'")
        XCTAssertError(parse: "abc1", expected: "Invalid character 'a' for input string 'abc1'")
        
        XCTAssertParse(parse: "1", expected: "1")
        XCTAssertParse(parse: "12", expected: "12")
        XCTAssertParse(parse: "123", expected: "123")
        XCTAssertParse(parse: "1234", expected: "1234")
        XCTAssertParse(parse: "12345", expected: "12345")
        XCTAssertParse(parse: "123456", expected: "123456")
        XCTAssertParse(parse: "1234567", expected: "1234567")
        XCTAssertParse(parse: "12345678", expected: "12345678")
        XCTAssertParse(parse: "123456789", expected: "123456789")
        XCTAssertParse(parse: "1234567890", expected: "1234567890")
        XCTAssertParse(parse: "12345678901", expected: "12345678901")
        XCTAssertParse(parse: "123456789012", expected: "123456789012")
        XCTAssertParse(parse: "1234567890123", expected: "1234567890123")
        XCTAssertParse(parse: "12345678901234", expected: "12345678901234")
        XCTAssertParse(parse: "123456789012345", expected: "123456789012345")
        
        XCTAssertParse(parse: "-1", expected: "-1")
        XCTAssertParse(parse: "-12", expected: "-12")
        XCTAssertParse(parse: "-123", expected: "-123")
        XCTAssertParse(parse: "-1234", expected: "-1234")
        XCTAssertParse(parse: "-12345", expected: "-12345")
        XCTAssertParse(parse: "-123456", expected: "-123456")
        XCTAssertParse(parse: "-1234567", expected: "-1234567")
        XCTAssertParse(parse: "-12345678", expected: "-12345678")
        XCTAssertParse(parse: "-123456789", expected: "-123456789")
        XCTAssertParse(parse: "-1234567890", expected: "-1234567890")
        XCTAssertParse(parse: "-12345678901", expected: "-12345678901")
        XCTAssertParse(parse: "-123456789012", expected: "-123456789012")
        XCTAssertParse(parse: "-1234567890123", expected: "-1234567890123")
        XCTAssertParse(parse: "-12345678901234", expected: "-12345678901234")
        XCTAssertParse(parse: "-123456789012345", expected: "-123456789012345")
        
        XCTAssertParse(parse: "1,234", expected: "1234")
        XCTAssertParse(parse: "12,345", expected: "12345")
        XCTAssertParse(parse: "123,456", expected: "123456")
        XCTAssertParse(parse: "1,234,567", expected: "1234567")
        XCTAssertParse(parse: "12,345,678", expected: "12345678")
        XCTAssertParse(parse: "123,456,789", expected: "123456789")
        XCTAssertParse(parse: "1,234,567,890", expected: "1234567890")
        XCTAssertParse(parse: "12,345,678,901", expected: "12345678901")
        XCTAssertParse(parse: "123,456,789,012", expected: "123456789012")
        XCTAssertParse(parse: "1,234,567,890,123", expected: "1234567890123")
        XCTAssertParse(parse: "12,345,678,901,234", expected: "12345678901234")
        XCTAssertParse(parse: "123,456,789,012,345", expected: "123456789012345")
        
        XCTAssertParse(parse: "-1,234", expected: "-1234")
        XCTAssertParse(parse: "-12,345", expected: "-12345")
        XCTAssertParse(parse: "-123,456", expected: "-123456")
        XCTAssertParse(parse: "-1,234,567", expected: "-1234567")
        XCTAssertParse(parse: "-12,345,678", expected: "-12345678")
        XCTAssertParse(parse: "-123,456,789", expected: "-123456789")
        XCTAssertParse(parse: "-1,234,567,890", expected: "-1234567890")
        XCTAssertParse(parse: "-12,345,678,901", expected: "-12345678901")
        XCTAssertParse(parse: "-123,456,789,012", expected: "-123456789012")
        XCTAssertParse(parse: "-1,234,567,890,123", expected: "-1234567890123")
        XCTAssertParse(parse: "-12,345,678,901,234", expected: "-12345678901234")
        XCTAssertParse(parse: "-123,456,789,012,345", expected: "-123456789012345")

        XCTAssertError(parse: "$1", expected: "Invalid character '$' for input string '$1'")
        XCTAssertParse(parse: "￥1", expected: "1")
        XCTAssertError(parse: "￥1.2", expected: "Unexpected decimal seperator character '.' for input string '￥1.2'")
        XCTAssertParse(parse: "￥12", expected: "12")
        XCTAssertParse(parse: "￥123", expected: "123")
        XCTAssertParse(parse: "￥1234", expected: "1234")
        XCTAssertParse(parse: "￥1,234", expected: "1234")

        XCTAssertParse(parse: "-￥1", expected: "-1")
        XCTAssertError(parse: "-￥1.2", expected: "Unexpected decimal seperator character '.' for input string '-￥1.2'")
        XCTAssertParse(parse: "-￥12", expected: "-12")
        XCTAssertParse(parse: "-￥123", expected: "-123")
        XCTAssertParse(parse: "-￥1234", expected: "-1234")
        XCTAssertParse(parse: "-￥1,234", expected: "-1234")
    }
    
    func testParseStringAmounts2DP() {
        formatter = MoneyFormatter(CurrencyManager.shared.get(code: "NZD")!)

        XCTAssertError(parse: "", expected: "Digits expected, none found for input string ''")
        XCTAssertParse(parse: "1.2", expected: "1.20")
        XCTAssertParse(parse: "1.23", expected: "1.23")
        XCTAssertError(parse: "1.234", expected: "Too many fractional digits for input string '1.234'")
        XCTAssertParse(parse: "-1.2", expected: "-1.20")
        XCTAssertParse(parse: "-1.23", expected: "-1.23")
        XCTAssertParse(parse: ".1", expected: "0.10")
        XCTAssertParse(parse: "1.", expected: "1.00")
        XCTAssertParse(parse: "-.1", expected: "-0.10")
        XCTAssertParse(parse: "-1.", expected: "-1.00")
        
        XCTAssertError(parse: "1abc", expected: "Invalid character 'a' for input string '1abc'")
        XCTAssertError(parse: "abc1", expected: "Invalid character 'a' for input string 'abc1'")
        
        XCTAssertParse(parse: "1", expected: "1.00")
        XCTAssertParse(parse: "12", expected: "12.00")
        XCTAssertParse(parse: "123", expected: "123.00")
        XCTAssertParse(parse: "1234", expected: "1234.00")
        XCTAssertParse(parse: "12345", expected: "12345.00")
        XCTAssertParse(parse: "123456", expected: "123456.00")
        XCTAssertParse(parse: "1234567", expected: "1234567.00")
        XCTAssertParse(parse: "12345678", expected: "12345678.00")
        XCTAssertParse(parse: "123456789", expected: "123456789.00")
        XCTAssertParse(parse: "1234567890", expected: "1234567890.00")
        XCTAssertParse(parse: "12345678901", expected: "12345678901.00")
        XCTAssertParse(parse: "123456789012", expected: "123456789012.00")
        XCTAssertParse(parse: "1234567890123", expected: "1234567890123.00")
        XCTAssertParse(parse: "12345678901234", expected: "12345678901234.00")
        XCTAssertParse(parse: "123456789012345", expected: "123456789012345.00")

        XCTAssertParse(parse: "-1", expected: "-1.00")
        XCTAssertParse(parse: "-12", expected: "-12.00")
        XCTAssertParse(parse: "-123", expected: "-123.00")
        XCTAssertParse(parse: "-1234", expected: "-1234.00")
        XCTAssertParse(parse: "-12345", expected: "-12345.00")
        XCTAssertParse(parse: "-123456", expected: "-123456.00")
        XCTAssertParse(parse: "-1234567", expected: "-1234567.00")
        XCTAssertParse(parse: "-12345678", expected: "-12345678.00")
        XCTAssertParse(parse: "-123456789", expected: "-123456789.00")
        XCTAssertParse(parse: "-1234567890", expected: "-1234567890.00")
        XCTAssertParse(parse: "-12345678901", expected: "-12345678901.00")
        XCTAssertParse(parse: "-123456789012", expected: "-123456789012.00")
        XCTAssertParse(parse: "-1234567890123", expected: "-1234567890123.00")
        XCTAssertParse(parse: "-12345678901234", expected: "-12345678901234.00")
        XCTAssertParse(parse: "-123456789012345", expected: "-123456789012345.00")

        XCTAssertParse(parse: "1,234", expected: "1234.00")
        XCTAssertParse(parse: "12,345", expected: "12345.00")
        XCTAssertParse(parse: "123,456", expected: "123456.00")
        XCTAssertParse(parse: "1,234,567", expected: "1234567.00")
        XCTAssertParse(parse: "12,345,678", expected: "12345678.00")
        XCTAssertParse(parse: "123,456,789", expected: "123456789.00")
        XCTAssertParse(parse: "1,234,567,890", expected: "1234567890.00")
        XCTAssertParse(parse: "12,345,678,901", expected: "12345678901.00")
        XCTAssertParse(parse: "123,456,789,012", expected: "123456789012.00")
        XCTAssertParse(parse: "1,234,567,890,123", expected: "1234567890123.00")
        XCTAssertParse(parse: "12,345,678,901,234", expected: "12345678901234.00")
        XCTAssertParse(parse: "123,456,789,012,345", expected: "123456789012345.00")

        XCTAssertParse(parse: "-1,234", expected: "-1234.00")
        XCTAssertParse(parse: "-12,345", expected: "-12345.00")
        XCTAssertParse(parse: "-123,456", expected: "-123456.00")
        XCTAssertParse(parse: "-1,234,567", expected: "-1234567.00")
        XCTAssertParse(parse: "-12,345,678", expected: "-12345678.00")
        XCTAssertParse(parse: "-123,456,789", expected: "-123456789.00")
        XCTAssertParse(parse: "-1,234,567,890", expected: "-1234567890.00")
        XCTAssertParse(parse: "-12,345,678,901", expected: "-12345678901.00")
        XCTAssertParse(parse: "-123,456,789,012", expected: "-123456789012.00")
        XCTAssertParse(parse: "-1,234,567,890,123", expected: "-1234567890123.00")
        XCTAssertParse(parse: "-12,345,678,901,234", expected: "-12345678901234.00")
        XCTAssertParse(parse: "-123,456,789,012,345", expected: "-123456789012345.00")
        
        XCTAssertParse(parse: "$1", expected: "1.00")
        XCTAssertParse(parse: "$1.2", expected: "1.20")
        XCTAssertParse(parse: "$1.23", expected: "1.23")
        XCTAssertParse(parse: "$12.34", expected: "12.34")
        XCTAssertParse(parse: "$123.45", expected: "123.45")
        XCTAssertParse(parse: "$1,234.56", expected: "1234.56")

        XCTAssertParse(parse: "-$1", expected: "-1.00")
        XCTAssertParse(parse: "-$1.2", expected: "-1.20")
        XCTAssertParse(parse: "-$1.23", expected: "-1.23")
        XCTAssertParse(parse: "-$12.34", expected: "-12.34")
        XCTAssertParse(parse: "-$123.45", expected: "-123.45")
        XCTAssertParse(parse: "-$1,234.56", expected: "-1234.56")

        XCTAssertError(parse: "1.23.4", expected: "Unexpected decimal seperator character '.' for input string '1.23.4'")
    }

    func testParseStringAmounts3DPAndSuffixUnicode() {
        // Unicode characters. 1f496=sparkling heart (💖)
        formatter = MoneyFormatter(Currency(code: "BST", name: "BST bs", flag: " ", symbolPrefix: "", symbolSuffix: "\u{1f496}bs", exponent: 3, unit: "", units: "", subunit: "", subunits: "", prefix: ""))

        XCTAssertParse(parse: "1.2", expected: "1.200")
        XCTAssertParse(parse: "1.23", expected: "1.230")
        XCTAssertParse(parse: "1.234", expected: "1.234")
        XCTAssertError(parse: "1.2345", expected: "Too many fractional digits for input string '1.2345'")
        
        XCTAssertParse(parse: "12.345", expected: "12.345")
        XCTAssertParse(parse: "123.456", expected: "123.456")
        XCTAssertParse(parse: "1,234.567", expected: "1234.567")
        
        XCTAssertParse(parse: "-1,234.567", expected: "-1234.567")
        XCTAssertParse(parse: "-1,234.567\u{1f496}bs", expected: "-1234.567")
    }
    
}
