/*******************************************************************************
 * MoneyFormatter.swift                                                        *
 * CoreKit Copyright© 2019; Electric Bolt Limited.                             *
 ******************************************************************************/

import Foundation

/**
 A concrete implementation of a NSFormatter that creates, interprets, and validates the textual representation of
 money amounts. MoneyFormatter is thread safe.
 
 NZD formatting examples:      Parsing examples:
    nan      -> ""             "", "abc", "￥0" -> nan
    0        -> "$0.00"        "$0.00" -> 0.00
    1234.56  -> "$1,234.56"    "1234.56" -> 1234.56
    -1234.56 -> "-$1,234.56"   "-$1,234.56" -> -1234.56
 
 JPY Formatting examples:      Parsing examples:
    nan      -> ""             "", "abc", "$0.00" -> nan
    0        -> "￥0"          "￥0" -> 0
    1234     -> "￥1,234"      "1234" -> 1234
    -1234    -> "￥1,234"      "-￥1,234" -> -1234
 
 Formatted textual representations of money amounts are optimized for english locales, and for UX reasons,
 thousands grouping characters are always represented with a comma character "," and decimal place separators
 are always represented with a full stop character "." (regardless of currency).
 */

// MARK: NSFormatter implementation

public class MoneyFormatter: Formatter {
    
    /**
     Returns the currency object in use by this MoneyFormatter instance.
     */
    public private(set) var currency: Currency!

    /**
     By default, all accessibility text output from accessibilityText(amount:negative:) will have the
     currencies accessibility prefix prepended. If the currencies prefix is equal to the defaultAccessibilityPrefix,
     then the prefix will not be appended. Most financial apps have the notion of domestic currency and foreign
     currencies, it is useful in this situation to only append the prefix for foreign currencies, not to the domestic
     currency. The defaultAccessibilityPrefix currency is NZD.
     */
    public static var defaultAccessibilityPrefix: Currency? = {
        return CurrencyManager.shared.get(code: "NZD")
    }()

    private var formatter: NumberFormatter!

    private override init() {
        super.init()
    }
    
    /**
     Initializes the MoneyFormatter instance with the currency object specified.
     MoneyFormatters instances are thread safe.
     */
    public convenience init(_ currency: Currency) {
        self.init()

        self.currency = currency
        
        formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.generatesDecimalNumbers = true
        formatter.minimumFractionDigits = Int(currency.exponent)
        formatter.maximumFractionDigits = Int(currency.exponent)
        formatter.groupingSeparator = ","
        formatter.usesGroupingSeparator = true
        formatter.decimalSeparator = "."
        formatter.alwaysShowsDecimalSeparator = false
        formatter.groupingSize = 3
        formatter.isLenient = false
        formatter.minusSign = "-"
        formatter.roundingMode = .floor
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Formats a Decimal, NSDecimalNumber or Money amount using the currency object attached to the MoneyFormatter
     instance and returns the textual representation. Calls string(for:prefixSuffix:grouping:negative:)
     - Parameters:
       - obj: The Decimal, NSDecimalNumber or Money for which a textual representation is returned.
     - Returns: A String object that textually represents object for display. Returns nil if object is not of the
       correct class or there was an error formatting the string or if the amount was unavailable.
     */
    public override func string(for obj: Any?) -> String? {
        return string(for: obj, symbols: true, grouping: true, negative: true)
    }
    
    /**
     Not currently implemented - returns nil.
     */
    public override func attributedString(for obj: Any, withDefaultAttributes attrs: [NSAttributedString.Key : Any]? = nil) -> NSAttributedString? {
        return nil
    }

    internal func decimalValue(for obj: Any?) -> Decimal {
        if obj == nil {
            return Decimal.nan
        } else if obj is Decimal {
            return obj as! Decimal
        } else if obj is NSDecimalNumber {
            return (obj as! NSDecimalNumber).decimalValue
        } else if obj is Money {
            return (obj as! Money).decimalValue
        } else {
            return Decimal.nan
        }
    }
    
    /**
     Formats the Decimal, NSDecimalNumber or Money amount using the currency object attached to the MoneyFormatter
     instance and returns the textual representation.
     - Parameters:
       - obj: The Decimal, NSDecimalNumber or Money for which a textual representation is returned.
       - symbols: Specify true to prepend any symbol prefix or append any symbol suffix as specified by the currency
        object's symbolPrefix and symbolSuffix properties.
       - grouping: Specify true to seperate groups of digits using the currency objects seperator property.
       - negative: Specify true to prepend a negative sign if the amount is negative.
     - Returns: A String object that textually represents object for display. Returns "" if object is not of the
     correct class, if there was an error formatting the string or if the amount was unavailable.
     */
    public func string(for obj: Any?, symbols: Bool, grouping: Bool, negative: Bool) -> String? {
        let decimal = decimalValue(for: obj)
        
        if decimal == Decimal.nan {
            return ""
        }
        
        let formatter = self.formatter.copy() as! NumberFormatter
        formatter.negativePrefix = ""
        if decimal.isSignMinus {
            formatter.roundingMode = .ceiling
        }
        if !grouping {
            formatter.groupingSeparator = ""
            formatter.usesGroupingSeparator = false
        }
        
        var result = ""
        if negative && decimal.isSignMinus {
            result += "-";
        }
        if symbols {
            result += currency.symbolPrefix
        }
        let str = formatter.string(from: NSDecimalNumber(decimal: decimal))
        if str == nil {
            return ""
        }
        result += str!
        if symbols {
            result += currency.symbolSuffix
        }
        return result
    }

    /**
     Parses the string for a money amount using the currency object attached to the MoneyFormatter instance.
     If the string was parsed correctly, then a NSDecimalNumber is stored in obj, and true is returned. If the string
     failed to be parsed, then false is returned, and a descriptive error string is placed in error. Unless you
     require the semantics of NSFormatter.getObjectValue(_:for:errorDescription), you're better off using
     parse(amount:) instead which exposes an easier to use interface.
     - Parameters:
     - obj: If the string was parsed correctly, then a NSDecimalNumber is stored in obj.
     - errorDescription: If the string was not parsed correctly, then a descriptive error string is stored in
       errorDescription.
     - Returns: true if the string was parsed correctly, or false if an error occured.
     */
    public override func getObjectValue(_ obj: AutoreleasingUnsafeMutablePointer<AnyObject?>?, for string: String, errorDescription errorObj: AutoreleasingUnsafeMutablePointer<NSString?>?) -> Bool {
        if currency == nil {
            errorObj?.pointee = NSString(utf8String: "No currency object configured for input string '\(string)'")
            return false
        }

        do {
            var builder = try DecimalNumberBuilder(fractionalPrecision: currency.exponent, isNegative: string.hasPrefix("-"))
            var s = string.removePrefix("-")
            s = s.removePrefix(currency.symbolPrefix)
            s = s.removeSuffix(currency.symbolSuffix)

            for c in s {
                if c.isASCII && c.asciiValue! >= 0x30 && c.asciiValue! <= 0x39 {
                    try builder.addDigit(c)
                } else {
                    switch c {
                        case ",":
                            guard !builder.isFractional else {
                                errorObj?.pointee = NSString(utf8String: "Unexpected grouping seperator character ',' for input string '\(string)'")
                                return false
                            }
                        case ".":
                            try builder.setFractional()
                        default:
                            errorObj?.pointee = NSString(utf8String: "Invalid character '\(c)' for input string '\(string)'")
                            return false
                    }
                }
            }
            obj?.pointee = try builder.build() as AnyObject
            return true
        } catch DecimalNumberBuilderError.tooManyFractionalDigits {
            errorObj?.pointee = NSString(utf8String: "Too many fractional digits for input string '\(string)'")
        } catch DecimalNumberBuilderError.tooManyDigits {
            errorObj?.pointee = NSString(utf8String: "Too many digits for input string '\(string)'")
        } catch DecimalNumberBuilderError.unexpectedDecimalSeperator {
            errorObj?.pointee = NSString(utf8String: "Unexpected decimal seperator character '.' for input string '\(string)'")
        } catch DecimalNumberBuilderError.noDigits {
            errorObj?.pointee = NSString(utf8String: "Digits expected, none found for input string '\(string)'")
        } catch _ {
            errorObj?.pointee = NSString(utf8String: "Unexpected error occured for input string '\(string)'")
        }
        return false
    }
    
}

// MARK: Simple formatting & parsing

extension MoneyFormatter {
    
    /**
     Formats the Money amount using the currency object attached to the MoneyFormatter instance and returns the
     textual representation.
     - Parameters:
     - amount: The Decimal, NSDecimalNumber or Money for which a textual representation is returned.
     - symbols: Specify true to prepend any symbol prefix or append any symbol suffix as specified by the currency
       object's symbolPrefix and symbolSuffix properties. Default is true.
     - grouping: Specify true to seperate groups of digits using the currency objects seperator property. Default is true.
     - negative: Specify true to prepend a negative sign if the amount is negative. Default is true.
     - Returns: A String object that textually represents object for display. Returns "" if object is not of the
     correct class or there was an error formatting the string, or if an unavailable amount.
     */
    public func format(amount: Any, symbols: Bool = true, grouping: Bool = true, negative: Bool = true) -> String {
        let result = self.string(for: amount, symbols: symbols, grouping: grouping, negative: negative)
        if result == nil {
            return ""
        } else {
            return result!
        }
    }
    
    /**
     Parses the string for a money amount using the currency object attached to the MoneyFormatter instance.
     If the string was parsed correctly, then a Money is returned with the amount set correctly. If the string
     failed to be parsed, then Money is returned with an unavailable amount.
     - Parameters:
     - amount: The string to be parsed and converted to a Money
     - Returns: Money instance with either the amount or an unavailable amount.
     */
    public func parse(amount: String) -> Money {
        let formatter = MoneyFormatter(currency)
        let decimal: Decimal
        var obj: AnyObject?
        var error: NSString?
        if formatter.getObjectValue(&obj, for: amount, errorDescription: &error) {
            decimal = (obj as! NSDecimalNumber).decimalValue
        } else {
            decimal = Decimal.nan
        }
        return Money(decimal: decimal, currency: currency)
    }
    
}

// MARK: Accessibility

extension MoneyFormatter {
    
    /**
     Returns the textual string used for voiceover of a money amount. e.g. "-$523.84 NZD" is returned as "new zealand
     negative five hundred and twenty three dollars and eighty four cents". Zero whole and fractional amounts return
     optimized text as follows:
       0.00 is returned as "zero dollars" instead of "zero dollars and zero cents"
       1.00 is returned as "one dollar" instead of "one dollar and zero cents"
       0.15 is returned as "fifteen cents" instead of "zero dollars and fifteen cents"
     - parameters:
     - amount: The Decimal, NSDecimalNumber or Money for which a textual representation is returned.
     - negative: Specify true to prepend a "negative" text if the amount is negative. Default is true.
     - prefix: Specify true to append the currencies accessibility suffix if the currency is not the
       defaultAccessibilityPrefix. Specify false to never include the prefix.
     - returns: A String that textually represents object for voiceover. Returns "" if object is not of the
     correct class or there was an error formatting the string, or if an unavailable amount.
     */
    public func accessibilityText(amount: Any, negative: Bool = true, prefix: Bool = true) -> String {
        let decimal = decimalValue(for: amount)        
        let str = self.format(amount: decimal, symbols: false, grouping: false, negative: false)
        if str == "" {
            return ""
        }

        var result = prefix && currency != MoneyFormatter.defaultAccessibilityPrefix ? currency.prefix : ""

        result += " " + (negative && decimal.isSignMinus ? "negative " : "")

        let whole = UInt64(currency.exponent > 0 ? str.substring(to: str.count - Int(currency.exponent) - 1) : str)!
        let fractional = UInt64(currency.exponent > 0 ? str.substring(from: str.count - Int(currency.exponent)) : "0")!

        if whole == 0 && fractional == 0 {
            result += "zero " + currency.units
        } else if whole > 0 && fractional == 0 {
            result += accessibilityText(whole) + " " + (whole == 1 ? currency.unit : currency.units)
        } else if whole == 0 && fractional > 0 {
            result += accessibilityText(fractional) + " " + (fractional == 1 ? currency.subunit : currency.subunits)
        } else {
            result += accessibilityText(whole) + " " + (whole == 1 ? currency.unit : currency.units) + " and " +
                accessibilityText(fractional) + " " + (fractional == 1 ? currency.subunit : currency.subunits)
        }

        return result.trimmingCharacters(in: CharacterSet(charactersIn: " "))
    }
    
    /**
     Recursively constructs a voice over string of the provided unsigned 64-bit integer.
     */
    internal func accessibilityText(_ amount: UInt64) -> String {
        let text1To19: [String] = ["", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine",
            "ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
        let text20To99: [String] = ["", "", "twenty", "thirty", "fourty", "fifty", "sixty", "seventy", "eighty", "ninety"]
        let divisor: [(scale:UInt64,text:String)] = [(100,""), (10,"hundred"), (1000,"thousand"), (1000,"million"),
            (1000,"billion"), (1000,"trillion")]

        var amount = amount
        if amount == 0 {
            return "zero"
        }
        
        var result = ""
        var divisorIndex = 0
        while amount > 0 {
            let val = Int(amount % divisor[divisorIndex].scale)
            amount = amount / divisor[divisorIndex].scale
            if val > 0 {
                let number: String
                switch val {
                    case 0...19:
                        number = text1To19[val]
                    case 20...99:
                        number = text20To99[val / 10] + (val % 10 > 0 ? " " + text1To19[val % 10] : "")
                    default:
                        number = accessibilityText(UInt64(val))
                }
                result = (amount > 0 && divisorIndex == 0 ? "and " : "") + number + " " + divisor[divisorIndex].text + " " + result
            }
            divisorIndex += 1
        }
        
        return result.trimmingCharacters(in: CharacterSet(charactersIn: " "))
    }
}

