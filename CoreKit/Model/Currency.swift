/*******************************************************************************
 * Currency.swift                                                              *
 * CoreKit Copyright© 2019; Electric Bolt Limited.                             *
 ******************************************************************************/

import Foundation

// MARK: Currency implementation

public struct Currency {
    
    /**
     3 character ISO-4217 currency code. e.g. "NZD"
     */
    private(set) public var code: String
    
    /**
     Name of the currency used for display purposes. e.g. "New Zealand dollar"
     */
    private(set) public var name: String

    /**
     Flag of currencies country. Unicode compatible. e.g. "🇳🇿"
     */
    private(set) public var flag: Character
    
    /**
     Formatted money amount symbol prefix. Currencies have a symbolPrefix or symbolSuffix, but not both.
     Unicode compatible. e.g. "$"
     */
    private(set) public var symbolPrefix: String
    
    /**
     Formatted money amount symbol suffix. Currencies have a symbolPrefix or symbolSuffix, but not both.
     Unicode compatible. e.g. "kr".
     */
    private(set) public var symbolSuffix: String
    
    /**
     Number of fractional digits of the subunit. Range is 0..4. e.g. Most currencies have 2. JPY has 0, KWR has 3.
     */
    private(set) public var exponent: UInt
        
    /**
     Name of the unit used for accessibility purposes. e.g. "dollar"
     */
    private(set) public var unit: String

    /**
     Plural name of the unit used for accessibility purposes. e.g. "dollars"
     */
    private(set) public var units: String

    /**
     Name of the subunit used for accessibility purposes. e.g. "cent"
     */
    private(set) public var subunit: String
    
    /**
     Plural name of the subunit used for accessibility purposes. e.g. "cents"
     */
    private(set) public var subunits: String
    
    /**
     Currency country to prepend as a prefix for accessibility purposes. e.g. "australian"
     */
    private(set) public var prefix: String
    
    public init(code: String, name: String, flag: Character, symbolPrefix: String, symbolSuffix: String,
        exponent: UInt, unit: String, units: String, subunit: String, subunits: String, prefix: String) {
        self.code = code
        self.name = name
        self.flag = flag
        self.symbolPrefix = symbolPrefix
        self.symbolSuffix = symbolSuffix
        self.exponent = exponent
        self.unit = unit
        self.units = units
        self.subunit = subunit
        self.subunits = subunits
        self.prefix = prefix
    }
}

// MARK: Debug string extension

extension Currency: CustomDebugStringConvertible {
    
    /**
     A textual representation of this instance, suitable for debugging.
     - returns: string in the following format: "NZD,$,New Zealand dollar,2DP"
     */
    public var debugDescription: String {
        let prefixSuffix = symbolPrefix.count != 0 ? symbolPrefix : symbolSuffix
        return "\(code),\(prefixSuffix),\(name),\(exponent)DP"
    }
}

// MARK: Hashing & Comparing extension

extension Currency: Hashable, Comparable {
    
    /**
     Returns a Boolean value indicating whether two Currency objects are equal.
     - returns: true if the Currency objects code properties are equal.
     */
    public static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.code == rhs.code
    }
    
    /**
     Returns a Boolean value indicating whether lhs Currency object is less than the rhs Currency object.
     - returns: true if the lhs Currency objects code property is less than the rhs Currency objects code property.
     */
    public static func < (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.code < rhs.code
    }
    
    /**
     Hashes the essential components of this Currency object by feeding them into the given hasher.
     */
    public func hash(into hasher: inout Hasher) {
        hasher.combine(code)
    }

}

