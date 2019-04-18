/*******************************************************************************
 * Money.swift                                                                 *
 * CoreKit Copyright© 2019; Electric Bolt Limited.                             *
 ******************************************************************************/

import Foundation

/**
 A Money is an struct that represents an amount and an associated currency. Amounts either represent a real value
 (e.g. -$1927.10, ￥10, £1.56, 0.00kr.) or are unavailable (e.g. have no numerical value).
 
 ☞ In many financial applications, host systems can be unavailable throughout the day due to batch jobs running etc,
 and for this reason, amounts have notion of being unavailable.
 
 Money objects can be compared, hashed, added and subtracted. Using a MoneyFormatter class, Money objects can be
 converted to and from strings.
 */

// MARK: Money implementation

public struct Money {

    private let amount: Decimal

    /**
     The metadata used to format, parse and operate upon an amount.
     */
    public let currency: Currency
    
    /**
     Initializes a Money object with an unavailable amount.
     */
    public init(unavailable currency: Currency) {
        self.amount = Decimal.nan
        self.currency = currency
    }
    
    /**
     Initializes a Money object with an amount represented by a float. Due to binary approximation errors, this
     constructor should be used sparingly, and the Decimal, NSDecimalNumber or String constructors preferred.
     - parameters:
        - float: amount represented as a Float. Float.nan indicates an unavailable amount.
        - currency: metadata used to format, parse and operate upon an amount
     */
    public init(float: Float, currency: Currency) {
        self.init(double: Double(float), currency: currency)
    }

    /**
     Initializes a Money object with an amount represented by a double. Due to binary approximation errors, this
     constructor should be used sparingly, and the Decimal, NSDecimalNumber or String constructors preferred.
     - parameters:
        - double: amount represented as a Double. Double.nan indicates an unavailable amount.
        - currency: metadata used to format, parse and operate upon an amount
     */
    public init(double: Double, currency: Currency) {
        let nf = NumberFormatter()
        nf.locale = Locale(identifier: "en_US_POSIX")
        nf.roundingMode = (double.sign == .minus) ? .floor : .ceiling
        nf.minimumFractionDigits = Int(currency.exponent)
        nf.maximumFractionDigits = Int(currency.exponent)
        let s = nf.string(from: NSNumber(value: double))
        self.init(string: s != nil ? s! : "", currency: currency)
    }
    
    /**
     Initializes a Money object with an amount represented by a String. If the amount cannot be converted to a string,
     then the Money object will be represented as unavailable. See MoneyFormatter for string formats of Money amounts.
     - parameters:
        - string: amount represented as a String.
        - currency: metadata used to format, parse and operate upon an amount
     */
    public init(string: String, currency: Currency) {
        let formatter = MoneyFormatter(currency)
        let money = formatter.parse(amount: string)
        self.amount = money.amount
        self.currency = money.currency
    }

    /**
     Initializes a Money object with an amount represented by a Decimal.
     - parameters:
        - decimal: amount represented as a Decimal. Decimal.nan indicates an unavailable amount.
        - currency: metadata used to format, parse and operate upon an amount
     */
    public init(decimal: Decimal, currency: Currency) {
        self.amount = decimal
        self.currency = currency
    }

    /**
     Initializes a Money object with an amount represented by a NSDecimalNumber.
     - parameters:
        - decimal: amount represented as a NSDecimalNumber. NSDecimalNumber.notANumber indicates an unavailable amount.
        - currency: metadata used to format, parse and operate upon an amount
     */
    public init(decimalNumber: NSDecimalNumber, currency: Currency) {
        self.amount = decimalNumber.decimalValue
        self.currency = currency
    }
    
    /**
     Money objects can either be real or unavailable. This property returns true if the amount is unavailable.
     - returns: true if unavailable amount.
     */
    public var isUnavailable: Bool {
        get {
            return amount.isNaN
        }
    }
    
    /**
     The amount of the Money object represented as a Decimal.
     - returns: The amount as a Decimal or Decimal.nan if unavailable amount.
     */
    public var decimalValue: Decimal {
        get {
            return amount;
        }
    }

    /**
     The amount of the Money object represented as a Float. Due to binary approximation errors, this
     property should be used sparingly, and the decimalValue, decimalNumber or string properties preferred.
     - returns: The amount as a Float or Float.nan if unavailable amount.
     */
    public var floatValue: Float {
        get {
            return Float(truncating: amount as NSNumber)
        }
    }

    /**
     The amount of the Money object represented as a Double. Due to binary approximation errors, this
     property should be used sparingly, and the decimalValue, decimalNumber or string properties preferred.
     - returns: The amount as a Double or Double.nan if unavailable amount.
     */
    public var doubleValue: Double {
        get {
            return Double(truncating: amount as NSNumber)
        }
    }

    /**
     The amount of the Money object represented as a NSDecimalNumber.
     - returns: The amount as a NSDecimalNumber or NSDecimalNumber.notANumber if unavailable amount.
     */
    public var decimalNumber: NSDecimalNumber {
        get {
            return NSDecimalNumber(decimal: amount)
        }
    }

    /**
     The amount of the Money object represented as a String. The returned string is formatted without prefix or
     suffix or grouping seperators. e.g. "-2402.19". Use MoneyFormatter.format(amount:prefixSuffix:grouping:negative:)
     method directly for alternate formats. Money objects that have unavailable amounts are returned as "".
     - returns: Textual representation of the amount or "" if unavailable amount.
     */
    public var stringValue: String {
        get {
            let formatter = MoneyFormatter(currency)
            return formatter.format(amount: self, symbols: false, grouping: false, negative: true)
        }
    }
    
}

// MARK: Debug string extension

extension Money: CustomDebugStringConvertible {
    
    /**
     A textual representation of this instance, suitable for debugging.
     - returns: string in the following format: "NZD -$1,234.56" OR "NZD N/A" if unavailable amount.
     */
    public var debugDescription: String {
        let formatter = MoneyFormatter(currency)
        var s = formatter.format(amount: self, symbols: true, grouping: true, negative: true)
        if s == "" {
            s = "N/A"
        }
        return "\(currency.code) \(s)"
    }
}

// MARK: Hashing & Comparing extension

extension Money: Hashable, Comparable {

    /**
     Returns a Boolean value indicating whether two Money objects are equal. Money objects with differing currencies
     return false.
     - returns: true if the Money objects are equal.
     */
    public static func == (lhs: Money, rhs: Money) -> Bool {
        return lhs.amount == rhs.amount && lhs.currency == rhs.currency
    }

    /**
     Returns a Boolean value indicating whether lhs Money object is less than the value
     of the rhs Money object. Money objects with differing currencies return false.
     - returns: true if the lhs Money object's amount is less than the rhs Money object's amount.
     */
    public static func < (lhs: Money, rhs: Money) -> Bool {
        guard lhs.currency == rhs.currency else { return false }
        return lhs.amount < rhs.amount
    }
    
    /**
     Hashes the essential components of this Money object by feeding them into the given hasher.
     */
    public func hash(into hasher: inout Hasher) {
        hasher.combine(amount)
        hasher.combine(currency.code)
    }

}

// MARK: Arithmetic extension

extension Money {

    /**
     Negates a money and returns the result. Example:
     let a = Money(5.00, Currency.NZD)
     let b = -a // value of b is -5.00
     */
    public static prefix func -(lhs: Money) -> Money {
        return Money(decimal: -lhs.amount, currency: lhs.currency)
    }
    
    /**
     Adds a money to another money using the currency of the lhs and returns the result.
     Money objects with differing currencies return an unavailable amount.
     Example:
     let a = Money(5.00, Currency.NZD)
     let b = Money(10.00, Currency.NZD)
     let c = a + b // value of c is 15.00
     */
    public static func +(lhs: Money, rhs: Money) -> Money {
        guard lhs.currency == rhs.currency else { return Money(unavailable: lhs.currency) }
        return Money(decimal: lhs.amount + rhs.amount, currency: lhs.currency)
    }

    /**
     Adds a money to another money using the currency of the lhs and stores in the lhs.
     Money objects with differing currencies return an unavailable amount.
     Example:
     var a = Money(5.00, Currency.NZD)
     let b = Money(10.00, Currency.NZD)
     a += b // value of a is now 15.00
     */
    public static func +=(lhs: inout Money, rhs: Money) {
        guard lhs.currency == rhs.currency else { return lhs = Money(unavailable: lhs.currency) }
        lhs = Money(decimal: lhs.amount + rhs.amount, currency: lhs.currency)
    }
    
    /**
     Substracts a money from another money using the currency of the lhs and returns the result.
     Money objects with differing currencies return an unavailable amount.
     Example:
     let a = Money(5.00, Currency.NZD)
     let b = Money(10.00, Currency.NZD)
     let c = a - b // value of c is -5.00
     */
    public static func -(lhs: Money, rhs: Money) -> Money {
        guard lhs.currency == rhs.currency else { return Money(unavailable: lhs.currency) }
        return Money(decimal: lhs.amount - rhs.amount, currency: lhs.currency)
    }

    /**
     Substracts a money from another money using the currency of the lhs and stores in the lhs. Example:
     var a = Money(5.00, Currency.NZD)
     let b = Money(10.00, Currency.NZD)
     a -= b // value of a is now -5.00
     */
    public static func -=(lhs: inout Money, rhs: Money) {
        guard lhs.currency == rhs.currency else { return lhs = Money(unavailable: lhs.currency) }
        lhs = Money(decimal: lhs.amount - rhs.amount, currency: lhs.currency)
    }
    
}
