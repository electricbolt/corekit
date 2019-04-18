/*******************************************************************************
 * MoneyFormatterAcccessibilityTests.swift                                     *
 * CoreKit Copyright© 2019; Electric Bolt Limited.                             *
 ******************************************************************************/

import XCTest
@testable import CoreKit
import AVFoundation

class MoneyFormatterAccessibilityTests: XCTestCase {
    
    var formatter: MoneyFormatter!
    var currency: Currency!

    override func setUp() {
        super.setUp()
        formatter = MoneyFormatter(CurrencyManager.shared.get(code: "NZD")!)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFormatDefaultAccessibilityPrefix() {
        XCTAssertEqual("NZD", MoneyFormatter.defaultAccessibilityPrefix!.code)
        XCTAssertFormat(amount: "2.01", expected: "two dollars and one cent", prefix: true)
        XCTAssertFormat(amount: "2.01", expected: "two dollars and one cent", prefix: false)
        MoneyFormatter.defaultAccessibilityPrefix = nil
        XCTAssertFormat(amount: "2.01", expected: "new zealand two dollars and one cent", prefix: true)
        XCTAssertFormat(amount: "2.01", expected: "two dollars and one cent", prefix: false)
        MoneyFormatter.defaultAccessibilityPrefix = CurrencyManager.shared.get(code: "NZD")
    }
    
    func testFormatAccessibilityText_0_To_99() {
        XCTAssertEqual("zero", formatter.accessibilityText(0))
        XCTAssertEqual("one", formatter.accessibilityText(1))
        XCTAssertEqual("two", formatter.accessibilityText(2))
        XCTAssertEqual("three", formatter.accessibilityText(3))
        XCTAssertEqual("four", formatter.accessibilityText(4))
        XCTAssertEqual("five", formatter.accessibilityText(5))
        XCTAssertEqual("six", formatter.accessibilityText(6))
        XCTAssertEqual("seven", formatter.accessibilityText(7))
        XCTAssertEqual("eight", formatter.accessibilityText(8))
        XCTAssertEqual("nine", formatter.accessibilityText(9))
        XCTAssertEqual("ten", formatter.accessibilityText(10))
        XCTAssertEqual("eleven", formatter.accessibilityText(11))
        XCTAssertEqual("twelve", formatter.accessibilityText(12))
        XCTAssertEqual("thirteen", formatter.accessibilityText(13))
        XCTAssertEqual("fourteen", formatter.accessibilityText(14))
        XCTAssertEqual("fifteen", formatter.accessibilityText(15))
        XCTAssertEqual("sixteen", formatter.accessibilityText(16))
        XCTAssertEqual("seventeen", formatter.accessibilityText(17))
        XCTAssertEqual("eighteen", formatter.accessibilityText(18))
        XCTAssertEqual("nineteen", formatter.accessibilityText(19))
        XCTAssertEqual("twenty", formatter.accessibilityText(20))
        XCTAssertEqual("twenty one", formatter.accessibilityText(21))
        XCTAssertEqual("twenty nine", formatter.accessibilityText(29))
        XCTAssertEqual("thirty", formatter.accessibilityText(30))
        XCTAssertEqual("thirty one", formatter.accessibilityText(31))
        XCTAssertEqual("thirty nine", formatter.accessibilityText(39))
        XCTAssertEqual("fourty", formatter.accessibilityText(40))
        XCTAssertEqual("fourty one", formatter.accessibilityText(41))
        XCTAssertEqual("fourty nine", formatter.accessibilityText(49))
        XCTAssertEqual("fifty", formatter.accessibilityText(50))
        XCTAssertEqual("fifty one", formatter.accessibilityText(51))
        XCTAssertEqual("fifty nine", formatter.accessibilityText(59))
        XCTAssertEqual("sixty", formatter.accessibilityText(60))
        XCTAssertEqual("sixty one", formatter.accessibilityText(61))
        XCTAssertEqual("sixty nine", formatter.accessibilityText(69))
        XCTAssertEqual("seventy", formatter.accessibilityText(70))
        XCTAssertEqual("seventy one", formatter.accessibilityText(71))
        XCTAssertEqual("seventy nine", formatter.accessibilityText(79))
        XCTAssertEqual("eighty", formatter.accessibilityText(80))
        XCTAssertEqual("eighty one", formatter.accessibilityText(81))
        XCTAssertEqual("eighty nine", formatter.accessibilityText(89))
        XCTAssertEqual("ninety", formatter.accessibilityText(90))
        XCTAssertEqual("ninety one", formatter.accessibilityText(91))
        XCTAssertEqual("ninety nine", formatter.accessibilityText(99))
    }
    
    func testFormatAccessibilityText_100_To_999() {
        XCTAssertEqual("one hundred", formatter.accessibilityText(100))
        XCTAssertEqual("one hundred and one", formatter.accessibilityText(101))
        XCTAssertEqual("one hundred and two", formatter.accessibilityText(102))
        XCTAssertEqual("one hundred and nine", formatter.accessibilityText(109))
        XCTAssertEqual("one hundred and ten", formatter.accessibilityText(110))
        XCTAssertEqual("one hundred and eleven", formatter.accessibilityText(111))
        XCTAssertEqual("one hundred and nineteen", formatter.accessibilityText(119))
        XCTAssertEqual("one hundred and twenty", formatter.accessibilityText(120))
        XCTAssertEqual("one hundred and twenty one", formatter.accessibilityText(121))
        XCTAssertEqual("one hundred and twenty nine", formatter.accessibilityText(129))
        XCTAssertEqual("one hundred and thirty", formatter.accessibilityText(130))
        XCTAssertEqual("one hundred and thirty one", formatter.accessibilityText(131))
        XCTAssertEqual("one hundred and thirty nine", formatter.accessibilityText(139))
        XCTAssertEqual("one hundred and fourty", formatter.accessibilityText(140))
        XCTAssertEqual("one hundred and fourty one", formatter.accessibilityText(141))
        XCTAssertEqual("one hundred and fourty nine", formatter.accessibilityText(149))
        XCTAssertEqual("one hundred and fifty", formatter.accessibilityText(150))
        XCTAssertEqual("one hundred and fifty one", formatter.accessibilityText(151))
        XCTAssertEqual("one hundred and fifty nine", formatter.accessibilityText(159))
        XCTAssertEqual("one hundred and sixty", formatter.accessibilityText(160))
        XCTAssertEqual("one hundred and sixty one", formatter.accessibilityText(161))
        XCTAssertEqual("one hundred and sixty nine", formatter.accessibilityText(169))
        XCTAssertEqual("one hundred and seventy", formatter.accessibilityText(170))
        XCTAssertEqual("one hundred and seventy one", formatter.accessibilityText(171))
        XCTAssertEqual("one hundred and seventy nine", formatter.accessibilityText(179))
        XCTAssertEqual("one hundred and eighty", formatter.accessibilityText(180))
        XCTAssertEqual("one hundred and eighty one", formatter.accessibilityText(181))
        XCTAssertEqual("one hundred and eighty nine", formatter.accessibilityText(189))
        XCTAssertEqual("one hundred and ninety", formatter.accessibilityText(190))
        XCTAssertEqual("one hundred and ninety one", formatter.accessibilityText(191))
        XCTAssertEqual("one hundred and ninety nine", formatter.accessibilityText(199))
        XCTAssertEqual("two hundred", formatter.accessibilityText(200))
        XCTAssertEqual("two hundred and one", formatter.accessibilityText(201))
        XCTAssertEqual("two hundred and ten", formatter.accessibilityText(210))
        XCTAssertEqual("two hundred and nineteen", formatter.accessibilityText(219))
        XCTAssertEqual("two hundred and twenty", formatter.accessibilityText(220))
        XCTAssertEqual("two hundred and thirty", formatter.accessibilityText(230))
        XCTAssertEqual("two hundred and thirty one", formatter.accessibilityText(231))
        XCTAssertEqual("two hundred and fourty", formatter.accessibilityText(240))
        XCTAssertEqual("two hundred and fifty", formatter.accessibilityText(250))
        XCTAssertEqual("two hundred and sixty", formatter.accessibilityText(260))
        XCTAssertEqual("two hundred and seventy", formatter.accessibilityText(270))
        XCTAssertEqual("two hundred and eighty", formatter.accessibilityText(280))
        XCTAssertEqual("two hundred and ninety", formatter.accessibilityText(290))
        XCTAssertEqual("two hundred and ninety nine", formatter.accessibilityText(299))
        XCTAssertEqual("three hundred", formatter.accessibilityText(300))
        XCTAssertEqual("three hundred and twenty six", formatter.accessibilityText(326))
        XCTAssertEqual("four hundred and fifty two", formatter.accessibilityText(452))
        XCTAssertEqual("five hundred and seventy one", formatter.accessibilityText(571))
        XCTAssertEqual("six hundred", formatter.accessibilityText(600))
        XCTAssertEqual("seven hundred", formatter.accessibilityText(700))
        XCTAssertEqual("eight hundred", formatter.accessibilityText(800))
        XCTAssertEqual("nine hundred", formatter.accessibilityText(900))
        XCTAssertEqual("nine hundred and ninety nine", formatter.accessibilityText(999))
    }
    
    func testFormatAccessibilityText_1_000_To_9_999() {
        XCTAssertEqual("one thousand", formatter.accessibilityText(1000))
        XCTAssertEqual("one thousand and one", formatter.accessibilityText(1001))
        XCTAssertEqual("one thousand one hundred and ninety four", formatter.accessibilityText(1194))
        XCTAssertEqual("two thousand three hundred and sixty five", formatter.accessibilityText(2365))
        XCTAssertEqual("three thousand four hundred and one", formatter.accessibilityText(3401))
        XCTAssertEqual("four thousand and ten", formatter.accessibilityText(4010))
        XCTAssertEqual("five thousand six hundred and two", formatter.accessibilityText(5602))
        XCTAssertEqual("six thousand and ninety nine", formatter.accessibilityText(6099))
        XCTAssertEqual("seven thousand one hundred and fifty", formatter.accessibilityText(7150))
        XCTAssertEqual("eight thousand", formatter.accessibilityText(8000))
        XCTAssertEqual("nine thousand nine hundred and ninety eight", formatter.accessibilityText(9998))
    }
    
    func testFormatAccessibilityText_10_000_To_99_999() {
        XCTAssertEqual("ten thousand", formatter.accessibilityText(10000))
        XCTAssertEqual("eleven thousand four hundred and fifty one", formatter.accessibilityText(11451))
        XCTAssertEqual("twelve thousand and two", formatter.accessibilityText(12002))
        XCTAssertEqual("nineteen thousand nine hundred and ninety nine", formatter.accessibilityText(19999))
        XCTAssertEqual("twenty thousand", formatter.accessibilityText(20000))
        XCTAssertEqual("twenty thousand and one", formatter.accessibilityText(20001))
        XCTAssertEqual("twenty one thousand and one", formatter.accessibilityText(21001))
        XCTAssertEqual("twenty two thousand eight hundred and seventy five", formatter.accessibilityText(22875))
        XCTAssertEqual("thirty thousand one hundred and fifty six", formatter.accessibilityText(30156))
        XCTAssertEqual("ninety thousand and ten", formatter.accessibilityText(90010))
        XCTAssertEqual("ninety nine thousand nine hundred and ninety nine", formatter.accessibilityText(99999))
    }
    
    func testFormatAccessibilityText_100_000_To_999_999() {
        XCTAssertEqual("one hundred thousand", formatter.accessibilityText(100000))
        XCTAssertEqual("one hundred and nine thousand six hundred and five", formatter.accessibilityText(109605))
        XCTAssertEqual("one hundred and twelve thousand four hundred and fifteen", formatter.accessibilityText(112415))
        XCTAssertEqual("one hundred and twenty thousand and three", formatter.accessibilityText(120003))
        XCTAssertEqual("one hundred and twenty two thousand and seven", formatter.accessibilityText(122007))
        XCTAssertEqual("one hundred and ninety eight thousand six hundred and thirty four", formatter.accessibilityText(198634))
        XCTAssertEqual("two hundred thousand", formatter.accessibilityText(200000))
        XCTAssertEqual("two hundred thousand and two", formatter.accessibilityText(200002))
        XCTAssertEqual("two hundred and fifteen thousand seven hundred and nine", formatter.accessibilityText(215709))
        XCTAssertEqual("nine hundred and ninety nine thousand nine hundred and ninety nine", formatter.accessibilityText(999999))
    }

    func testFormatAccessibilityText_1_000_000_To_99_999_999() {
        XCTAssertEqual("one million", formatter.accessibilityText(1000000))
        XCTAssertEqual("one million and nine", formatter.accessibilityText(1000009))
        XCTAssertEqual("one million one hundred and nine thousand six hundred and five", formatter.accessibilityText(1109605))
        XCTAssertEqual("two million one hundred and twelve thousand four hundred and fifteen", formatter.accessibilityText(2112415))
        XCTAssertEqual("five million one hundred and twenty thousand and three", formatter.accessibilityText(5120003))
        XCTAssertEqual("eight million one hundred and twenty two thousand and seven", formatter.accessibilityText(8122007))
        XCTAssertEqual("nine million one hundred and ninety eight thousand six hundred and thirty four", formatter.accessibilityText(9198634))
        XCTAssertEqual("ten million one hundred thousand", formatter.accessibilityText(10100000))
        XCTAssertEqual("eleven million six hundred thousand one hundred and fifty two", formatter.accessibilityText(11600152))
        XCTAssertEqual("twenty million nine hundred and fifteen thousand seven hundred and nine", formatter.accessibilityText(20915709))
        XCTAssertEqual("thirty five million four hundred and ninety nine thousand nine hundred and ninety nine", formatter.accessibilityText(35499999))
        XCTAssertEqual("ninety nine million six thousand", formatter.accessibilityText(99006000))
    }

    func testFormatAccessibilityText_100_000_000_To_999_999_999() {
        XCTAssertEqual("one hundred million", formatter.accessibilityText(100000000))
        XCTAssertEqual("one hundred million and nine", formatter.accessibilityText(100000009))
        XCTAssertEqual("one hundred and fifteen million one hundred and nine thousand six hundred and five", formatter.accessibilityText(115109605))
        XCTAssertEqual("two hundred and seventy seven million one hundred and twelve thousand four hundred and fifteen", formatter.accessibilityText(277112415))
        XCTAssertEqual("nine hundred and ninety nine million nine hundred and ninety nine thousand nine hundred and ninety nine", formatter.accessibilityText(999999999))
    }

    func testFormatAccessibilityText_1_000_000_000_To_999_999_999_999() {
        XCTAssertEqual("one billion", formatter.accessibilityText(1000000000))
        XCTAssertEqual("one billion one hundred and eleven million one hundred and eleven thousand one hundred and eleven", formatter.accessibilityText(1111111111))
        XCTAssertEqual("nineteen billion and one", formatter.accessibilityText(19000000001))
        XCTAssertEqual("ninety nine billion seven hundred and fifty seven million and thirty eight", formatter.accessibilityText(99757000038))
        XCTAssertEqual("four hundred and eighty six billion seven hundred and fifty seven million nine hundred and sixty eight thousand two hundred and sixty two", formatter.accessibilityText(486757968262))
    }

    func testFormatAccessibilityText_1_000_000_000_000_To_9_999_999_999_999() {
        XCTAssertEqual("one trillion", formatter.accessibilityText(1000000000000))
        XCTAssertEqual("eight trillion four hundred and one billion one hundred and eleven million one hundred and eleven thousand one hundred and eleven", formatter.accessibilityText(8401111111111))
    }

    func XCTAssertFormat(amount: String, expected: String, negative: Bool = true, prefix: Bool = true, file: StaticString = #file, line: UInt = #line) {
        let value = NSDecimalNumber(string: amount)
        let s = formatter.accessibilityText(amount: value, negative: negative, prefix: prefix)
        XCTAssertEqual(expected, s, file: file, line: line)
    }

    func testFormatAccessibilityText_NAN() {
        XCTAssertEqual("", formatter.accessibilityText(amount: Decimal.nan, negative: true))
    }

    func testFormatAccessibilityTextNZD() {
        // no negative
        XCTAssertFormat(amount: "-1.01", expected: "one dollar and one cent", negative: false)
        XCTAssertFormat(amount: "-249.33", expected: "two hundred and fourty nine dollars and thirty three cents", negative: false)

        // negative
        XCTAssertFormat(amount: "-1.01", expected: "negative one dollar and one cent")
        XCTAssertFormat(amount: "-249.33", expected: "negative two hundred and fourty nine dollars and thirty three cents")

        // singular
        XCTAssertFormat(amount: "-1.01", expected: "negative one dollar and one cent")
        XCTAssertFormat(amount: "1.01", expected: "one dollar and one cent")

        // plural
        XCTAssertFormat(amount: "2.02", expected: "two dollars and two cents")
        XCTAssertFormat(amount: "493.58", expected: "four hundred and ninety three dollars and fifty eight cents")
        XCTAssertFormat(amount: "1391.29", expected: "one thousand three hundred and ninety one dollars and twenty nine cents")
        
        // whole and fractional optimizations
        XCTAssertFormat(amount: "0.00", expected: "zero dollars")
        XCTAssertFormat(amount: "1.00", expected: "one dollar")
        XCTAssertFormat(amount: "2.00", expected: "two dollars")
        XCTAssertFormat(amount: "5192.00", expected: "five thousand one hundred and ninety two dollars")
        XCTAssertFormat(amount: "0.01", expected: "one cent")
        XCTAssertFormat(amount: "0.02", expected: "two cents")
        XCTAssertFormat(amount: "0.98", expected: "ninety eight cents")
    }

    func testFormatAccessibilityTextJPY() {
        formatter = MoneyFormatter(CurrencyManager.shared.get(code: "JPY")!)

        // no negative
        XCTAssertFormat(amount: "-1", expected: "japanese one yen", negative: false)
        XCTAssertFormat(amount: "-249", expected: "japanese two hundred and fourty nine yen", negative: false)
        
        // negative
        XCTAssertFormat(amount: "-1", expected: "japanese negative one yen")
        XCTAssertFormat(amount: "-249", expected: "japanese negative two hundred and fourty nine yen")
        
        // singular
        XCTAssertFormat(amount: "-1", expected: "japanese negative one yen")
        XCTAssertFormat(amount: "1", expected: "japanese one yen")
        
        // plural
        XCTAssertFormat(amount: "2", expected: "japanese two yen")
        XCTAssertFormat(amount: "493", expected: "japanese four hundred and ninety three yen")
        XCTAssertFormat(amount: "1391", expected: "japanese one thousand three hundred and ninety one yen")
    }

// Uncomment method to utter accessibility text
//    func testFormatAccessibiltyTextSpeech() {
//        formatter = MoneyFormatter(CurrencyManager.shared.get(code: "AUD")!)
//        let string = formatter.accessibilityText(amount: Decimal(-51391.58))
//        XCTAssertEqual(string, "australian negative fifty one thousand three hundred and ninety one dollars and fifty eight cents")
//        let utterance = AVSpeechUtterance(string: string)
//        let synthesizer = AVSpeechSynthesizer()
//        synthesizer.speak(utterance)
//        // Sleep the main thread for 7.0 seconds otherwise the unit tests will finish and the process stopped before
//        // the utterance is complete.
//        Thread.sleep(forTimeInterval: 7.0)
//    }
    
}
