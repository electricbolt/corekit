/*******************************************************************************
 * Data+Codec.swift                                                            *
 * CoreKit Copyright© 2019; Electric Bolt Limited.                             *
 ******************************************************************************/

import Foundation

/**
 Encoding & decoding extensions to Swift's Data class.
 */

public extension Data {
    
    /**
     Creates a data buffer by decoding a hex encoded string into bytes. Accepts 0-9,A-F,a-f characters only.
     If string is malformed nil is returned.
     */

    init?(hexEncoded: String) {
        guard hexEncoded.count & 1 == 0 else { return nil }
        let buf = UnsafeMutablePointer<UInt8>.allocate(capacity: hexEncoded.count / 2)
        var o = 0
        var i = hexEncoded.startIndex
        while i != hexEncoded.endIndex {
            guard let hi = hexEncoded[i].hexDigitValue else { return nil }
            i = hexEncoded.index(after: i)
            guard let lo = hexEncoded[i].hexDigitValue else { return nil }
            i = hexEncoded.index(after: i)
            buf[o] = UInt8((hi << 4) | lo)
            o += 1
        }
        self.init(bytesNoCopy: buf, count: hexEncoded.count / 2, deallocator: .free)
    }

    struct HexEncodingOptions: OptionSet {
        
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)

        public let rawValue: Int
        public init(rawValue: Int) {
            self.rawValue = rawValue
        }
    }

    fileprivate static let lowerCaseHexDigits = "0123456789abcdef".utf8CString
    fileprivate static let upperCaseHexDigits = "0123456789ABCDEF".utf8CString

    /**
     Creates a hex encoded string from the data buffer's bytes. Specify .upperCase to output the string with
     0-9,A-F characters as by default will use lower case 0-9,a-f.
     */

    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        if #available(macOS 11.0, iOS 14.0, watchOS 7.0, tvOS 14.0, *) {
            // Coded for speed and upto 6x faster than: `map { String(format: "%02hhx", $0) }.joined()`
            let hexDigits = options.contains(.upperCase) ? Data.upperCaseHexDigits : Data.lowerCaseHexDigits
            var o = 0
            return String(unsafeUninitializedCapacity: count * 2) { buf in
                for b in self {
                    let (hi, lo) = Int(b).quotientAndRemainder(dividingBy: 16)
                    buf[o] = UInt8(hexDigits[hi])
                    o += 1
                    buf[o] = UInt8(hexDigits[lo])
                    o += 1
                }
                return count * 2
            }
        } else {
            // Coded for speed and upto 34x faster than: `map { String(format: "%02hhx", $0) }.joined()`
            let hexDigits = options.contains(.upperCase) ? Data.upperCaseHexDigits : Data.lowerCaseHexDigits
            var o = 0
            let buf = UnsafeMutablePointer<CChar>.allocate(capacity: count * 2)
            for b in self {
                let (hi, lo) = Int(b).quotientAndRemainder(dividingBy: 16)
                buf[o] = hexDigits[hi]
                o += 1
                buf[o] = hexDigits[lo]
                o += 1
            }
            return String(bytesNoCopy: buf, length: count * 2, encoding: .utf8, freeWhenDone: true)!
        }
    }
}
