## CoreKit

Models, UI and other neat stuff for Swift apps. Supports Swift 5.10, Xcode 15.4, iOS 13.0 and above.

### Models

#### Money & Currency

A Money is an struct that represents an amount and an associated currency. Amounts either represent a real value
 (e.g. -$1927.10, ￥10, £1.56, 0.00kr.) or are unavailable (e.g. have no numerical value).

> Swift example

```swift
let NZD = CurrencyManager.shared.get(code: "NZD")!
var m = Money(decimal: Decimal(40192.49), currency: NZD)
m += Money(float: 5.0, currency: NZD)           // m is now 40197.49
let f = MoneyFormatter(currency: NZD)
let s = f.format(m)                             // s is now "$40,197.49"
```

### Extensions

#### String

Extensions to Swift's String struct to provide easier and safer access to substrings (at the expense of performance). Easier - no String.Index manipulation is required, indexes are specified using Int's. Safer - all bounds checking is
 performed before string manipulation, and therefore no possibility of generating an uncatchable fatal error can occur.

> Swift example

```swift
let msg = "My dog has fleas"
let c: Character = msg[1]!                      // c is now "y"
var s: String = msg[4...]                       // s is now "og has fleas"
s = msg[7...35]                                 // s is now "has fleas"
s = msg.removeSuffix("fleas")                   // s is now "my dog has "
```

#### Data

Extensions to Swift's Data struct to provide Hex encoding and decoding. Coded for speed and between 6x to 34x faster than `map { String(format: "%02hhx", $0) }.joined()`


> Swift example

```swift
let d = Data(hexEncoded: "0fe3a9bc")            // d is now 0x0f,0xe3,0xa9,0xbc
let s = d.hexEncodedString(options: .upperCase) // s is now "0FE3A9BC"
```

