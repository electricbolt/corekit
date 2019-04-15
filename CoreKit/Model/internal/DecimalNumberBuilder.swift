/*******************************************************************************
 * DecimalNumberBuilder.swift                                                  *
 * CoreKit Copyright© 2019; Electric Bolt Limited.                             *
 ******************************************************************************/

import Foundation

internal enum DecimalNumberBuilderError : Error {
    case notDigit
    case tooManyDigits
    case tooManyFractionalDigits
    case unexpectedDecimalSeperator
    case noDigits
}

/**
 Internal class to generate our own decimal value parsing routine as [NSNumberFormatter numberFromString:] internally
 uses a double (even when generatesDecimalNumbers property is true), causing binary approximation errors.
 e.g. "99.9" outputs value 99.90000000000001.  See radar http://www.openradar.me/29923468 for more details.
 */

internal struct DecimalNumberBuilder {
    
    fileprivate var mantissa: UInt64 = 0
    fileprivate var negative : Bool
    fileprivate var fractional = false
    fileprivate var mantissaLength = 0
    fileprivate var fractionalLength: UInt = 0
    fileprivate var fractionalPrecision: UInt
    
    /**
     Initializes the builder object.
     - Parameters:
       - fractionalPrecision: Amount of fractional digits allowed. 0..4
       - isNegative: If the resulting NSDecimalNumber from the build method should
         be negative.
     - Throws: DecimalNumberBuilderError.tooManyFractionalDigits if the
               fractionalPrecision is out of range 0..4
     */
    internal init(fractionalPrecision: UInt, isNegative: Bool) throws {
        guard fractionalPrecision <= 4 else {
            throw DecimalNumberBuilderError.tooManyFractionalDigits
        }
        self.negative = isNegative
        self.fractionalPrecision = fractionalPrecision
    }

    /**
     Adds a digit 0..9 to the builder object.
     - Parameters:
       - c: Character in ascii range '0'..'9'
     - Throws: DecimalNumberBuilderError.notDigit if character is not '0'..'9'.
     - Throws: DecimalNumberBuilderError.tooManyDigits if more than 15 digits
               are added.
     - Throws: DecimalNumberBuilderError.tooManyFractionalDigits if more than
               fractionalPrecision digits are added.
     */
    internal mutating func addDigit(_ c: Character) throws {
        if mantissaLength >= 15 {
            throw DecimalNumberBuilderError.tooManyDigits
        }
        if fractional && fractionalLength >= fractionalPrecision {
            throw DecimalNumberBuilderError.tooManyFractionalDigits
        }
        if !c.isASCII || c.asciiValue! < 0x30 && c.asciiValue! > 0x39 {
            throw DecimalNumberBuilderError.notDigit
        }
        mantissa = (mantissa * 10) + UInt64(c.asciiValue! - 0x30)
        mantissaLength += 1
        fractionalLength += fractional ? 1 : 0
    }

    /**
     Returns true if setFractional has been called.
     */
    internal var isFractional: Bool {
        get {
            return fractional
        }
    }
    
    /**
     This method must be called before you add any fractional digits.
     - Throws: DecimalNumberBuilderError.unexpectedDecimalSeperator if you
               attempt to call this method multiple times or if the fractional
               precision specified in the init method is 0.
     */
    internal mutating func setFractional() throws {
        guard fractionalPrecision >= 1 && fractional == false else {
            throw DecimalNumberBuilderError.unexpectedDecimalSeperator
        }
        fractional = true
    }
    
    /**
     Builds and returns the NSDecimalNumber based upon the digits added to the
     builder object.
     - Throws: DecimalNumberBuilderError.noDigits if no digits have been added
               to the builder object then
     */
    internal func build() throws -> NSDecimalNumber {
        guard mantissaLength > 0 else {
            throw DecimalNumberBuilderError.noDigits
        }
        let power10: [UInt64] = [1, 10, 100, 1_000, 10_000]
        let _mantissa = mantissa * power10[Int(fractionalPrecision - fractionalLength)]
        return NSDecimalNumber(mantissa: _mantissa, exponent: -(Int16(fractionalPrecision)), isNegative: negative)
    }
    
}
