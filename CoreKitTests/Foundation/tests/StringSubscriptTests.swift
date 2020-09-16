/*******************************************************************************
 * StringSubscriptTests.swift                                                  *
 * CoreKit Copyright© 2019; Electric Bolt Limited.                             *
 ******************************************************************************/

import XCTest
@testable import CoreKit

class StringSubscriptTests: XCTestCase {

    override func setUp() {
    }

    override func tearDown() {
    }

    func testSubscriptAtIndex() {
        XCTAssertNil(""[0])
        XCTAssertNil(""[-1])
        XCTAssertNil(""[1])
        XCTAssertNil("abc"[-1])
        XCTAssertEqual(Character("a"), "abc"[0])
        XCTAssertEqual(Character("b"), "abc"[1])
        XCTAssertEqual(Character("c"), "abc"[2])
        XCTAssertNil("abc"[3])
        XCTAssertEqual(Character("\u{2665}"), "Hello,\u{2665}\u{1f496}!"[6])
        XCTAssertEqual(Character("\u{1f496}"), "Hello,\u{2665}\u{1f496}!"[7])
        XCTAssertEqual(Character("!"), "Hello,\u{2665}\u{1f496}!"[8])
    }
    
    func testSubscriptPartialRangeFrom() {
        XCTAssertEqual("", ""[0...])
        XCTAssertEqual("", ""[1...])
        XCTAssertEqual("", ""[2...])
        XCTAssertEqual("", ""[(-1)...])
        XCTAssertEqual("", ""[(-2)...])
        
        XCTAssertEqual("a", "a"[0...])
        XCTAssertEqual("", "a"[1...])
        XCTAssertEqual("", "a"[2...])
        XCTAssertEqual("a", "a"[(-1)...])
        XCTAssertEqual("a", "a"[(-2)...])
        
        XCTAssertEqual("ab", "ab"[0...])
        XCTAssertEqual("b", "ab"[1...])
        XCTAssertEqual("", "ab"[2...])
        XCTAssertEqual("ab", "ab"[(-1)...])
        XCTAssertEqual("ab", "ab"[(-2)...])

        XCTAssertEqual("abc", "abc"[0...])
        XCTAssertEqual("bc", "abc"[1...])
        XCTAssertEqual("c", "abc"[2...])
        XCTAssertEqual("abc", "abc"[(-1)...])
        XCTAssertEqual("abc", "abc"[(-2)...])

        // Unicode characters. 2665=black heart (♥) 1f496=sparkling heart (💖)
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!"[0...])
        XCTAssertEqual("\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!"[6...])
        XCTAssertEqual("\u{1f496}!", "Hello,\u{2665}\u{1f496}!"[7...])
        XCTAssertEqual("!", "Hello,\u{2665}\u{1f496}!"[8...])
        XCTAssertEqual("", "Hello,\u{2665}\u{1f496}!"[9...])
    }

    func testSubscriptPartialRangeUpTo() {
        XCTAssertEqual("", ""[..<0])
        XCTAssertEqual("", ""[..<1])
        XCTAssertEqual("", ""[..<2])
        XCTAssertEqual("", ""[..<(-1)])
        XCTAssertEqual("", ""[..<(-2)])
        
        XCTAssertEqual("", "a"[..<0])
        XCTAssertEqual("a", "a"[..<1])
        XCTAssertEqual("a", "a"[..<2])
        XCTAssertEqual("", "a"[..<(-1)])
        XCTAssertEqual("", "a"[..<(-2)])
        
        XCTAssertEqual("", "ab"[..<0])
        XCTAssertEqual("a", "ab"[..<1])
        XCTAssertEqual("ab", "ab"[..<2])
        XCTAssertEqual("", "ab"[..<(-1)])
        XCTAssertEqual("", "ab"[..<(-2)])
        
        XCTAssertEqual("", "abc"[..<0])
        XCTAssertEqual("a", "abc"[..<1])
        XCTAssertEqual("ab", "abc"[..<2])
        XCTAssertEqual("", "abc"[..<(-1)])
        XCTAssertEqual("", "abc"[..<(-2)])
        
        // Unicode characters. 2665=black heart (♥) 1f496=sparkling heart (💖)
        XCTAssertEqual("Hello", "Hello,\u{2665}\u{1f496}!"[..<5])
        XCTAssertEqual("Hello,\u{2665}", "Hello,\u{2665}\u{1f496}!"[..<7])
        XCTAssertEqual("Hello,\u{2665}\u{1f496}", "Hello,\u{2665}\u{1f496}!"[..<8])
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!"[..<9])
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!"[..<10])
    }
    
    func testSubscriptPartialRangeThrough() {
        XCTAssertEqual("", ""[...0])
        XCTAssertEqual("", ""[...1])
        XCTAssertEqual("", ""[...2])
        XCTAssertEqual("", ""[...(-1)])
        XCTAssertEqual("", ""[...(-2)])
        
        XCTAssertEqual("a", "a"[...0])
        XCTAssertEqual("a", "a"[...1])
        XCTAssertEqual("a", "a"[...2])
        XCTAssertEqual("", "a"[...(-1)])
        XCTAssertEqual("", "a"[...(-2)])
        
        XCTAssertEqual("a", "ab"[...0])
        XCTAssertEqual("ab", "ab"[...1])
        XCTAssertEqual("ab", "ab"[...2])
        XCTAssertEqual("", "ab"[...(-1)])
        XCTAssertEqual("", "ab"[...(-2)])
        
        XCTAssertEqual("a", "abc"[...0])
        XCTAssertEqual("ab", "abc"[...1])
        XCTAssertEqual("abc", "abc"[...2])
        XCTAssertEqual("", "abc"[...(-1)])
        XCTAssertEqual("", "abc"[...(-2)])
        
        // Unicode characters. 2665=black heart (♥) 1f496=sparkling heart (💖)
        XCTAssertEqual("Hello", "Hello,\u{2665}\u{1f496}!"[...4])
        XCTAssertEqual("Hello,\u{2665}", "Hello,\u{2665}\u{1f496}!"[...6])
        XCTAssertEqual("Hello,\u{2665}\u{1f496}", "Hello,\u{2665}\u{1f496}!"[...7])
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!"[...8])
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!"[...9])
    }
    
    func testSubscriptClosedRange() {
        // 0...n
        
        XCTAssertEqual("", ""[0...0])
        XCTAssertEqual("", ""[0...1])
        XCTAssertEqual("", ""[0...2])
        // XCTAssertEqual("", ""[0...(-1)]) // fatal error: Can't form range with upperBound < lowerBound
        // XCTAssertEqual("", ""[0...(-2)]) // fatal error: Can't form range with upperBound < lowerBound
        
        XCTAssertEqual("a", "a"[0...0])
        XCTAssertEqual("a", "a"[0...1])
        XCTAssertEqual("a", "a"[0...2])
        // XCTAssertEqual("", "a"[0...(-1)]) // fatal error: Can't form range with upperBound < lowerBound
        // XCTAssertEqual("", "a"[0...(-2)]) // fatal error: Can't form range with upperBound < lowerBound
        
        XCTAssertEqual("a", "ab"[0...0])
        XCTAssertEqual("ab", "ab"[0...1])
        XCTAssertEqual("ab", "ab"[0...2])
        // XCTAssertEqual("", "ab"[0...(-1)]) // fatal error: Can't form range with upperBound < lowerBound
        // XCTAssertEqual("", "ab"[0...(-2)]) // fatal error: Can't form range with upperBound < lowerBound

        XCTAssertEqual("a", "abc"[0...0])
        XCTAssertEqual("ab", "abc"[0...1])
        XCTAssertEqual("abc", "abc"[0...2])
        // XCTAssertEqual("", "ab"[0...(-1)]) // fatal error: Can't form range with upperBound < lowerBound
        // XCTAssertEqual("", "ab"[0...(-2)]) // fatal error: Can't form range with upperBound < lowerBound

        // 1...n
        
        // XCTAssertEqual("", ""[1...0]) // fatal error: Can't form range with upperBound < lowerBound
        XCTAssertEqual("", ""[1...1])
        XCTAssertEqual("", ""[1...2])
        // XCTAssertEqual("", ""[0...(-1)]) // fatal error: Can't form range with upperBound < lowerBound
        // XCTAssertEqual("", ""[0...(-2)]) // fatal error: Can't form range with upperBound < lowerBound
        
        // XCTAssertEqual("", "a"[1...0]) // fatal error: Can't form range with upperBound < lowerBound
        XCTAssertEqual("", "a"[1...1])
        XCTAssertEqual("", "a"[1...2])
        // XCTAssertEqual("", "a"[1...(-1)]) // fatal error: Can't form range with upperBound < lowerBound
        // XCTAssertEqual("", "a"[1...(-2)]) // fatal error: Can't form range with upperBound < lowerBound
        
        // XCTAssertEqual("", "ab"[1...0]) // fatal error: Can't form range with upperBound < lowerBound
        XCTAssertEqual("b", "ab"[1...1])
        XCTAssertEqual("b", "ab"[1...2])
        // XCTAssertEqual("", "ab"[1...(-1)]) // fatal error: Can't form range with upperBound < lowerBound
        // XCTAssertEqual("", "ab"[1...(-2)]) // fatal error: Can't form range with upperBound < lowerBound
        
        // XCTAssertEqual("", "abc"[1...0]) // fatal error: Can't form range with upperBound < lowerBound
        XCTAssertEqual("b", "abc"[1...1])
        XCTAssertEqual("bc", "abc"[1...2])
        // XCTAssertEqual("", "ab"[1...(-1)]) // fatal error: Can't form range with upperBound < lowerBound
        // XCTAssertEqual("", "ab"[1...(-2)]) // fatal error: Can't form range with upperBound < lowerBound
        
        // Unicode characters. 2665=black heart (♥) 1f496=sparkling heart (💖)
        XCTAssertEqual("Hello", "Hello,\u{2665}\u{1f496}!"[0...4])
        XCTAssertEqual("Hello,\u{2665}", "Hello,\u{2665}\u{1f496}!"[0...6])
        XCTAssertEqual("Hello,\u{2665}\u{1f496}", "Hello,\u{2665}\u{1f496}!"[0...7])
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!"[0...8])
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!"[0...10])

        XCTAssertEqual("\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!"[6...8])
        XCTAssertEqual("\u{2665}", "Hello,\u{2665}\u{1f496}!"[6...6])
        XCTAssertEqual("lo,\u{2665}", "Hello,\u{2665}\u{1f496}!"[3...6])
        XCTAssertEqual("\u{1f496}!", "Hello,\u{2665}\u{1f496}!"[7...8])
        XCTAssertEqual("ello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!"[1...9])
    }
    
    func testSubscriptRange() {
        // 0...n
        
        XCTAssertEqual("", ""[0..<0])
        XCTAssertEqual("", ""[0..<1])
        XCTAssertEqual("", ""[0..<2])
        // XCTAssertEqual("", ""[0..<(-1)]) // fatal error: Can't form range with upperBound < lowerBound
        // XCTAssertEqual("", ""[0..<(-2)]) // fatal error: Can't form range with upperBound < lowerBound
        
        XCTAssertEqual("", "a"[0..<0])
        XCTAssertEqual("a", "a"[0..<1])
        XCTAssertEqual("a", "a"[0..<2])
        // XCTAssertEqual("", "a"[0...(-1)]) // fatal error: Can't form range with upperBound < lowerBound
        // XCTAssertEqual("", "a"[0...(-2)]) // fatal error: Can't form range with upperBound < lowerBound
        
        XCTAssertEqual("", "ab"[0..<0])
        XCTAssertEqual("a", "ab"[0..<1])
        XCTAssertEqual("ab", "ab"[0..<2])
        // XCTAssertEqual("", "ab"[0...(-1)]) // fatal error: Can't form range with upperBound < lowerBound
        // XCTAssertEqual("", "ab"[0...(-2)]) // fatal error: Can't form range with upperBound < lowerBound
        
        XCTAssertEqual("", "abc"[0..<0])
        XCTAssertEqual("a", "abc"[0..<1])
        XCTAssertEqual("ab", "abc"[0..<2])
        XCTAssertEqual("abc", "abc"[0..<3])
        XCTAssertEqual("abc", "abc"[0..<4])
        XCTAssertEqual("abc", "abc"[0..<5])
        // XCTAssertEqual("", "ab"[0..<(-1)]) // fatal error: Can't form range with upperBound < lowerBound
        // XCTAssertEqual("", "ab"[0..<(-2)]) // fatal error: Can't form range with upperBound < lowerBound

        // 1...n
        
        // XCTAssertEqual("", ""[1..<0]) // fatal error: Can't form range with upperBound < lowerBound
        XCTAssertEqual("", ""[1..<1])
        XCTAssertEqual("", ""[1..<2])
        // XCTAssertEqual("", ""[1..<(-1)]) // fatal error: Can't form range with upperBound < lowerBound
        // XCTAssertEqual("", ""[1..<(-2)]) // fatal error: Can't form range with upperBound < lowerBound
        
        // XCTAssertEqual("", "a"[1..<0]) // fatal error: Can't form range with upperBound < lowerBound
        XCTAssertEqual("", "a"[1..<1])
        XCTAssertEqual("", "a"[1..<2])
        // XCTAssertEqual("", "a"[1...(-1)]) // fatal error: Can't form range with upperBound < lowerBound
        // XCTAssertEqual("", "a"[1...(-2)]) // fatal error: Can't form range with upperBound < lowerBound
        
        // XCTAssertEqual("", "ab"[1..<0]) // fatal error: Can't form range with upperBound < lowerBound
        XCTAssertEqual("", "ab"[1..<1])
        XCTAssertEqual("b", "ab"[1..<2])
        // XCTAssertEqual("", "ab"[1...(-1)]) // fatal error: Can't form range with upperBound < lowerBound
        // XCTAssertEqual("", "ab"[1...(-2)]) // fatal error: Can't form range with upperBound < lowerBound
        
        // XCTAssertEqual("", "abc"[1..<0]) // fatal error: Can't form range with upperBound < lowerBound
        XCTAssertEqual("", "abc"[1..<1])
        XCTAssertEqual("b", "abc"[1..<2])
        XCTAssertEqual("bc", "abc"[1..<3])
        XCTAssertEqual("bc", "abc"[1..<4])
        XCTAssertEqual("bc", "abc"[1..<5])
        // XCTAssertEqual("", "ab"[1..<(-1)]) // fatal error: Can't form range with upperBound < lowerBound
        // XCTAssertEqual("", "ab"[1..<(-2)]) // fatal error: Can't form range with upperBound < lowerBound

        // Unicode characters. 2665=black heart (♥) 1f496=sparkling heart (💖)
        XCTAssertEqual("Hello", "Hello,\u{2665}\u{1f496}!"[0..<5])
        XCTAssertEqual("Hello,\u{2665}", "Hello,\u{2665}\u{1f496}!"[0..<7])
        XCTAssertEqual("Hello,\u{2665}\u{1f496}", "Hello,\u{2665}\u{1f496}!"[0..<8])
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!"[0..<9])
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!"[0..<11])
        
        XCTAssertEqual("\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!"[6..<9])
        XCTAssertEqual("\u{2665}", "Hello,\u{2665}\u{1f496}!"[6..<7])
        XCTAssertEqual("lo,\u{2665}", "Hello,\u{2665}\u{1f496}!"[3..<7])
        XCTAssertEqual("\u{1f496}!", "Hello,\u{2665}\u{1f496}!"[7..<9])
        XCTAssertEqual("ello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!"[1..<10])
    }
    
    func testSubstringFrom() {
        XCTAssertEqual("", "".substring(from: 0))
        XCTAssertEqual("", "".substring(from: 1))
        XCTAssertEqual("", "".substring(from: 2))
        XCTAssertEqual("", "".substring(from: -1))
        XCTAssertEqual("", "".substring(from: -2))
        
        XCTAssertEqual("a", "a".substring(from: 0))
        XCTAssertEqual("", "a".substring(from: 1))
        XCTAssertEqual("", "a".substring(from: 2))
        XCTAssertEqual("a", "a".substring(from: -1))
        XCTAssertEqual("a", "a".substring(from: -2))
        
        XCTAssertEqual("ab", "ab".substring(from: 0))
        XCTAssertEqual("b", "ab".substring(from: 1))
        XCTAssertEqual("", "ab".substring(from: 2))
        XCTAssertEqual("ab", "ab".substring(from: -1))
        XCTAssertEqual("ab", "ab".substring(from: -2))
        
        XCTAssertEqual("abc", "abc".substring(from: 0))
        XCTAssertEqual("bc", "abc".substring(from: 1))
        XCTAssertEqual("c", "abc".substring(from: 2))
        XCTAssertEqual("abc", "abc".substring(from: -1))
        XCTAssertEqual("abc", "abc".substring(from: -2))
        
        // Unicode characters. 2665=black heart (♥) 1f496=sparkling heart (💖)
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!".substring(from: 0))
        XCTAssertEqual("\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!".substring(from: 6))
        XCTAssertEqual("\u{1f496}!", "Hello,\u{2665}\u{1f496}!".substring(from: 7))
        XCTAssertEqual("!", "Hello,\u{2665}\u{1f496}!".substring(from: 8))
        XCTAssertEqual("", "Hello,\u{2665}\u{1f496}!".substring(from: 9))
    }
    
    func testSubstringTo() {
        XCTAssertEqual("", "".substring(to: 0))
        XCTAssertEqual("", "".substring(to: 1))
        XCTAssertEqual("", "".substring(to: 2))
        XCTAssertEqual("", "".substring(to: -1))
        XCTAssertEqual("", "".substring(to: -2))
        
        XCTAssertEqual("", "a".substring(to: 0))
        XCTAssertEqual("a", "a".substring(to: 1))
        XCTAssertEqual("a", "a".substring(to: 2))
        XCTAssertEqual("", "a".substring(to: -1))
        XCTAssertEqual("", "a".substring(to: -2))
        
        XCTAssertEqual("", "ab".substring(to: 0))
        XCTAssertEqual("a", "ab".substring(to: 1))
        XCTAssertEqual("ab", "ab".substring(to: 2))
        XCTAssertEqual("", "ab".substring(to: -1))
        XCTAssertEqual("", "ab".substring(to: -2))
        
        XCTAssertEqual("", "abc".substring(to: 0))
        XCTAssertEqual("a", "abc".substring(to: 1))
        XCTAssertEqual("ab", "abc".substring(to: 2))
        XCTAssertEqual("", "abc".substring(to: -1))
        XCTAssertEqual("", "abc".substring(to: -2))
        
        // Unicode characters. 2665=black heart (♥) 1f496=sparkling heart (💖)
        XCTAssertEqual("Hello", "Hello,\u{2665}\u{1f496}!".substring(to: 5))
        XCTAssertEqual("Hello,\u{2665}", "Hello,\u{2665}\u{1f496}!".substring(to: 7))
        XCTAssertEqual("Hello,\u{2665}\u{1f496}", "Hello,\u{2665}\u{1f496}!".substring(to: 8))
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!".substring(to: 9))
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!".substring(to: 10))
    }
    
    func testSubstringRange() {
        // 0...n
        
        XCTAssertEqual("", "".substring(from: 0, to: 0))
        XCTAssertEqual("", "".substring(from: 0, to: 1))
        XCTAssertEqual("", "".substring(from: 0, to: 2))
        XCTAssertEqual("", "".substring(from: 0, to: -1))
        XCTAssertEqual("", "".substring(from: 0, to: -2))
        
        XCTAssertEqual("", "a".substring(from: 0, to: 0))
        XCTAssertEqual("a", "a".substring(from: 0, to: 1))
        XCTAssertEqual("a", "a".substring(from: 0, to: 2))
        XCTAssertEqual("", "a".substring(from: 0, to: -1))
        XCTAssertEqual("", "a".substring(from: 0, to: -2))

        XCTAssertEqual("", "ab".substring(from: 0, to: 0))
        XCTAssertEqual("a", "ab".substring(from: 0, to: 1))
        XCTAssertEqual("ab", "ab".substring(from: 0, to: 2))
        XCTAssertEqual("", "ab".substring(from: 0, to: -1))
        XCTAssertEqual("", "ab".substring(from: 0, to: -2))

        XCTAssertEqual("", "abc".substring(from: 0, to: 0))
        XCTAssertEqual("a", "abc".substring(from: 0, to: 1))
        XCTAssertEqual("ab", "abc".substring(from: 0, to: 2))
        XCTAssertEqual("abc", "abc".substring(from: 0, to: 3))
        XCTAssertEqual("abc", "abc".substring(from: 0, to: 4))
        XCTAssertEqual("abc", "abc".substring(from: 0, to: 5))
        XCTAssertEqual("", "ab".substring(from: 0, to: -1))
        XCTAssertEqual("", "ab".substring(from: 0, to: -2))

        // 1...n

        XCTAssertEqual("", "".substring(from: 1, to: 0))
        XCTAssertEqual("", "".substring(from: 1, to: 1))
        XCTAssertEqual("", "".substring(from: 1, to: 2))
        XCTAssertEqual("", "".substring(from: 1, to: -1))
        XCTAssertEqual("", "".substring(from: 1, to: -2))

        XCTAssertEqual("", "a".substring(from: 1, to: 0))
        XCTAssertEqual("", "a".substring(from: 1, to: 1))
        XCTAssertEqual("", "a".substring(from: 1, to: 2))
        XCTAssertEqual("", "a".substring(from: 1, to: -1))
        XCTAssertEqual("", "a".substring(from: 1, to: -2))

        XCTAssertEqual("", "ab".substring(from: 1, to: 0))
        XCTAssertEqual("", "ab".substring(from: 1, to: 1))
        XCTAssertEqual("b", "ab".substring(from: 1, to: 2))
        XCTAssertEqual("", "ab".substring(from: 1, to: -1))
        XCTAssertEqual("", "ab".substring(from: 1, to: -2))

        XCTAssertEqual("", "abc".substring(from: 1, to: 0))
        XCTAssertEqual("", "abc".substring(from: 1, to: 1))
        XCTAssertEqual("b", "abc".substring(from: 1, to: 2))
        XCTAssertEqual("bc", "abc".substring(from: 1, to: 3))
        XCTAssertEqual("bc", "abc".substring(from: 1, to: 4))
        XCTAssertEqual("bc", "abc".substring(from: 1, to: 5))
        XCTAssertEqual("", "ab".substring(from: 1, to: -1))
        XCTAssertEqual("", "ab".substring(from: 1, to: -2))

        // Unicode characters. 2665=black heart (♥) 1f496=sparkling heart (💖)
        XCTAssertEqual("Hello", "Hello,\u{2665}\u{1f496}!".substring(from: 0, to: 5))
        XCTAssertEqual("Hello,\u{2665}", "Hello,\u{2665}\u{1f496}!".substring(from: 0, to: 7))
        XCTAssertEqual("Hello,\u{2665}\u{1f496}", "Hello,\u{2665}\u{1f496}!".substring(from: 0, to: 8))
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!".substring(from: 0, to: 9))
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!".substring(from: 0, to: 11))

        XCTAssertEqual("\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!".substring(from: 6, to: 9))
        XCTAssertEqual("\u{2665}", "Hello,\u{2665}\u{1f496}!".substring(from: 6, to: 7))
        XCTAssertEqual("lo,\u{2665}", "Hello,\u{2665}\u{1f496}!".substring(from: 3, to: 7))
        XCTAssertEqual("\u{1f496}!", "Hello,\u{2665}\u{1f496}!".substring(from: 7, to: 9))
        XCTAssertEqual("ello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!".substring(from: 1, to: 10))
    }
    
    func testSplit() {
        // 1 character
        
        var messages = "".split(largestLength: 256, splitLength: 240)
        XCTAssertEqual(1, messages.count)
        XCTAssertEqual("", messages[0])
        
        // 3 characters
        
        messages = "abc".split(largestLength: 256, splitLength: 240)
        XCTAssertEqual(1, messages.count)
        XCTAssertEqual("abc", messages[0])
        
        // 254 characters
        
        //                10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220       230       240       250 254
        var s = "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234"
        XCTAssertEqual(s.count, 254)
        messages = s.split(largestLength: 256, splitLength: 240)
        XCTAssertEqual(1, messages.count)
        XCTAssertEqual(s, messages[0])
        
        // 255 characters
        
        //            10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220       230       240       250  255
        s = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345"
        XCTAssertEqual(s.count, 255)
        messages = s.split(largestLength: 256, splitLength: 240)
        XCTAssertEqual(1, messages.count)
        XCTAssertEqual(s, messages[0])
        
        // 256 characters
        
        //            10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220       230       240       250   256
        s = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456"
        XCTAssertEqual(s.count, 256)
        messages = s.split(largestLength: 256, splitLength: 240)
        XCTAssertEqual(1, messages.count)
        XCTAssertEqual(s, messages[0])
        
        // 257 characters
        
        //            10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220       230       240       250    257
        s = "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567"
        XCTAssertEqual(s.count, 257)
        messages = s.split(largestLength: 256, splitLength: 240)
        XCTAssertEqual(2, messages.count)
        //                 10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220       230       240
        var s1 = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
        var s2 = "12345678901234567"
        XCTAssertEqual(s1.count, 240)
        XCTAssertEqual(s2.count, 17)
        XCTAssertEqual(s1, messages[0])
        XCTAssertEqual(s2, messages[1])
        
        // 263 characters
        
        //            10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220       230       240       250          263
        s = "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123"
        XCTAssertEqual(s.count, 263)
        messages = s.split(largestLength: 256, splitLength: 240)
        XCTAssertEqual(2, messages.count)
        //             10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220       230       240
        s1 = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
        s2 = "12345678901234567890123"
        XCTAssertEqual(s1.count, 240)
        XCTAssertEqual(s2.count, 23)
        XCTAssertEqual(s1, messages[0])
        XCTAssertEqual(s2, messages[1])
        
        // 479 characters
        
        //            10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220       230       240       250       260       270       280       290       300       310       320       330       340       350       360       370       380       390       400       410       420       430       440       450       460       470      479
        s = "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
        XCTAssertEqual(s.count, 479)
        messages = s.split(largestLength: 256, splitLength: 240)
        XCTAssertEqual(2, messages.count)
        //             10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220       230       240
        s1 = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
        s2 = "12345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789"
        XCTAssertEqual(s1.count, 240)
        XCTAssertEqual(s2.count, 239)
        XCTAssertEqual(s1, messages[0])
        XCTAssertEqual(s2, messages[1])
        
        // 480 characters
        
        //            10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220       230       240       250       260       270       280       290       300       310       320       330       340       350       360       370       380       390       400       410       420       430       440       450       460       470       480
        s = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
        XCTAssertEqual(s.count, 480)
        messages = s.split(largestLength: 256, splitLength: 240)
        XCTAssertEqual(2, messages.count)
        //             10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220       230       240
        s1 = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
        s2 = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
        XCTAssertEqual(s1.count, 240)
        XCTAssertEqual(s2.count, 240)
        XCTAssertEqual(s1, messages[0])
        XCTAssertEqual(s2, messages[1])
        
        // 481 characters
        
        //            10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220       230       240       250       260       270       280       290       300       310       320       330       340       350       360       370       380       390       400       410       420       430       440       450       460       470        481
        s = "1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901"
        XCTAssertEqual(s.count, 481)
        messages = s.split(largestLength: 256, splitLength: 240)
        XCTAssertEqual(3, messages.count)
        //             10        20        30        40        50        60        70        80        90        100       110       120       130       140       150       160       170       180       190       200       210       220       230       240
        s1 = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
        s2 = "123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890"
        let s3 = "1"
        XCTAssertEqual(s1.count, 240)
        XCTAssertEqual(s2.count, 240)
        XCTAssertEqual(s3.count, 1)
        XCTAssertEqual(s1, messages[0])
        XCTAssertEqual(s2, messages[1])
        XCTAssertEqual(s3, messages[2])
    }

    func testRemovePrefix() {
        XCTAssertEqual("", "".removePrefix(""))
        XCTAssertEqual("abc", "abc".removePrefix(""))
        XCTAssertEqual("abc123", "abc123".removePrefix("123"))
        XCTAssertEqual("123", "abc123".removePrefix("abc"))
        XCTAssertEqual("", "abc123".removePrefix("abc123"))
        
        // Unicode characters. 2665=black heart (♥) 1f496=sparkling heart (💖)
        XCTAssertEqual("\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!".removePrefix("Hello,"))
        XCTAssertEqual("\u{1f496}!", "Hello,\u{2665}\u{1f496}!".removePrefix("Hello,\u{2665}"))
        XCTAssertEqual("!", "Hello,\u{2665}\u{1f496}!".removePrefix("Hello,\u{2665}\u{1f496}"))
    }

    func testRemoveSuffix() {
        XCTAssertEqual("", "".removeSuffix(""))
        XCTAssertEqual("abc", "abc".removeSuffix(""))
        XCTAssertEqual("abc", "abc123".removeSuffix("123"))
        XCTAssertEqual("abc123", "abc123".removeSuffix("abc"))
        XCTAssertEqual("", "abc123".removeSuffix("abc123"))
        
        // Unicode characters. 2665=black heart (♥) 1f496=sparkling heart (💖)
        XCTAssertEqual("Hello,", "Hello,\u{2665}\u{1f496}!".removeSuffix("\u{2665}\u{1f496}!"))
        XCTAssertEqual("Hello,\u{2665}", "Hello,\u{2665}\u{1f496}!".removeSuffix("\u{1f496}!"))
    }

    func testLeft() {
        XCTAssertEqual("", "".left(-1))
        XCTAssertEqual("", "".left(0))
        XCTAssertEqual("", "".left(1))
        XCTAssertEqual("", "my dog has fleas".left(0))
        XCTAssertEqual("m", "my dog has fleas".left(1))
        XCTAssertEqual("my dog", "my dog has fleas".left(6))
        XCTAssertEqual("my dog has fleas", "my dog has fleas".left(50))
        
        // Unicode characters. 2665=black heart (♥) 1f496=sparkling heart (💖)
        XCTAssertEqual("Hello,", "Hello,\u{2665}\u{1f496}!".left(6))
        XCTAssertEqual("Hello,\u{2665}", "Hello,\u{2665}\u{1f496}!".left(7))
        XCTAssertEqual("Hello,\u{2665}\u{1f496}", "Hello,\u{2665}\u{1f496}!".left(8))
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!".left(9))
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!".left(10))
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!".left(50))
    }

    func testRight() {
        XCTAssertEqual("", "".right(-1))
        XCTAssertEqual("", "".right(0))
        XCTAssertEqual("", "".right(1))
        XCTAssertEqual("", "my dog has fleas".right(0))
        XCTAssertEqual("s", "my dog has fleas".right(1))
        XCTAssertEqual(" fleas", "my dog has fleas".right(6))
        XCTAssertEqual("my dog has fleas", "my dog has fleas".left(50))
        
        // Unicode characters. 2665=black heart (♥) 1f496=sparkling heart (💖)
        XCTAssertEqual("!", "Hello,\u{2665}\u{1f496}!".right(1))
        XCTAssertEqual("\u{1f496}!", "Hello,\u{2665}\u{1f496}!".right(2))
        XCTAssertEqual("\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!".right(3))
        XCTAssertEqual(",\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!".right(4))
        XCTAssertEqual("o,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!".right(5))
        XCTAssertEqual("Hello,\u{2665}\u{1f496}!", "Hello,\u{2665}\u{1f496}!".right(50))
    }

}
