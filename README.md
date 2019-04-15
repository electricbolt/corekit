## CoreKit

Models, UI and other neat stuff for Swift apps. Supports Swift 5, Xcode 10.2 and above.

### Models

#### Money & Currency

A Money is an struct that represents an amount and an associated currency. Amounts either represent a real value
 (e.g. -$1927.10, ￥10, £1.56, 0.00kr.) or are unavailable (e.g. have no numerical value).

> Swift example

```swift
let NZD = CurrencyManager.shared.get(code: "NZD")!
var m = Money(decimal: Decimal(40192.49), currency: NZD)
m += Money(float: 5.0, currency: NZD) // m is now 40197.49
let f = MoneyFormatter(currency: NZD)
let s = f.format(m)                   // s is now "$40,197.49"
```

### Extensions

#### String+Subscript

Extensions to Swift's String class to provide easier and safer access to substrings (at the expense of performance). Easier - no String.Index manipulation is required, indexes are specified using Int's. Safer - all bounds checking is
 performed before string manipulation, and therefore no possibility of generating an uncatchable fatal error can occur.

> Swift example

```swift
let msg = "My dog has fleas"
let c: Character = msg[1]!            // c is now "y"
var s: String = msg[4...]             // s is now "og has fleas"
s = msg[7...35]                       // s is now "has fleas"
s = msg.removeSuffix("fleas")         // s is now "my dog has "
```
