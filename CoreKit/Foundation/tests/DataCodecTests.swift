/*******************************************************************************
 * DataCodecTests.swift                                                        *
 * CoreKit Copyright© 2019; Electric Bolt Limited.                             *
 ******************************************************************************/

import XCTest
@testable import CoreKit

class DataEncodingTests: XCTestCase {
    
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    func testLowerHexEncodedString() {
        // 0 byte
        var i: [UInt8] = []
        var d = Data(i)
        XCTAssertEqual("", d.hexEncodedString());

        // 1 byte
        i = [0x41]
        d = Data(i)
        XCTAssertEqual("41", d.hexEncodedString());

        // 2 bytes
        i = [0x41, 0xef]
        d = Data(i)
        XCTAssertEqual("41ef", d.hexEncodedString(options: []));

        // 3 bytes
        i = [0x41, 0xef, 0xb5]
        d = Data(i)
        XCTAssertEqual("41efb5", d.hexEncodedString());
        
        // 16 bytes
        i = [0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f]
        d = Data(i)
        XCTAssertEqual("000102030405060708090a0b0c0d0e0f", d.hexEncodedString());
    }

    func testUpperHexEncodedString() {
        // 0 byte
        var i: [UInt8] = []
        var d = Data(i)
        XCTAssertEqual("", d.hexEncodedString(options: .upperCase));

        // 1 byte
        i = [0x41]
        d = Data(i)
        XCTAssertEqual("41", d.hexEncodedString(options: .upperCase));

        // 2 bytes
        i = [0x41, 0xef]
        d = Data(i)
        XCTAssertEqual("41EF", d.hexEncodedString(options: .upperCase));

        // 3 bytes
        i = [0x41, 0xef, 0xb5]
        d = Data(i)
        XCTAssertEqual("41EFB5", d.hexEncodedString(options: .upperCase));
        
        // 16 bytes
        i = [0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f]
        d = Data(i)
        XCTAssertEqual("000102030405060708090A0B0C0D0E0F", d.hexEncodedString(options: .upperCase));
    }
    
    func testDecodedData() {
        // odd size
        var d = Data(hexEncoded: "1")
        XCTAssertNil(d);

        // odd size
        d = Data(hexEncoded: "123")
        XCTAssertNil(d);

        // non hex character
        d = Data(hexEncoded: "0g")
        XCTAssertNil(d);

        // 0 byte
        d = Data(hexEncoded: "")
        XCTAssertEqual("", d!.hexEncodedString());

        // 1 byte
        d = Data(hexEncoded: "41")
        XCTAssertEqual("41", d!.hexEncodedString());

        // 2 bytes
        d = Data(hexEncoded: "41ef")
        XCTAssertEqual("41ef", d!.hexEncodedString(options: []));

        // 3 bytes
        d = Data(hexEncoded: "41EfB5")
        XCTAssertEqual("41efb5", d!.hexEncodedString());

        // 16 bytes
        d = Data(hexEncoded: "000102030405060708090A0b0C0d0E0f")
        XCTAssertEqual("000102030405060708090a0b0c0d0e0f", d!.hexEncodedString());
    }
    
}
