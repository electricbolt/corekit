/*******************************************************************************
 * CurrencyManager.swift                                                       *
 * CoreKit Copyright© 2019; Electric Bolt Limited.                             *
 ******************************************************************************/

import Foundation

/**
 CurrencyManager provides convenient access to a list of currencies. CurrencyManager is thread safe.
 CurrencyManager is prepopulated with a static list of >40 commonly used currencies.
 */

public class CurrencyManager {
    
    /**
     The shared currency manager object for the process. This method always represents the same currency manager object.
     */
    public static let shared = CurrencyManager()
        
    /**
     Returns the currency with the given code. If the given code does not exist, then nil is returned.
     */
    public func get(code: String) -> Currency? {
        defer { pthread_rwlock_unlock(&storageLock) }
        pthread_rwlock_rdlock(&storageLock)
        return storage[code]
    }
    
    /**
     Adds a currency into the list of known currencies. If the currency with the given code already exists, it is
     replaced with the given currency.
     */
    public func add(_ currency: Currency) {
        defer { pthread_rwlock_unlock(&storageLock) }
        pthread_rwlock_wrlock(&storageLock)
        storage[currency.code] = currency
    }
    
    /**
     Removes a currency from the list of known currencies. If the currency with the given code does not exist, no
     error is raised.
     */
    public func remove(code: String) {
        defer { pthread_rwlock_unlock(&storageLock) }
        pthread_rwlock_wrlock(&storageLock)
        storage.removeValue(forKey: code)
    }
    
    /**
     Removes all known currencies.
     */
    public func removeAll() {
        defer { pthread_rwlock_unlock(&storageLock) }
        pthread_rwlock_wrlock(&storageLock)
        storage.removeAll()
    }
    
    /**
     Returns a list of all known currencies sorted by currency code.
     */
    public func list() -> [Currency] {
        defer { pthread_rwlock_unlock(&storageLock) }
        pthread_rwlock_rdlock(&storageLock)
        return Array(storage.values).sorted()
    }
    
    private var storageLock = pthread_rwlock_t()
    
    private var storage: [String: Currency]
    
    internal init() {
        pthread_rwlock_init(&storageLock, nil)
        storage = [String: Currency]()
        populateWithStaticList()
    }
    
    deinit {
        pthread_rwlock_destroy(&storageLock)
    }
    
    /**
     Populates the currency manager with a hardcoded list of well known currencies. The list was compiled from the 5
     major banks in New Zealand:
     - Westpac https://www.westpac.co.nz/fx-travel-migrant/foreign-exchange-and-international/foreign-exchange-rates/
     - ANZ https://tools.anz.co.nz/foreign-exchange/fx-rates
     - BNZ https://www.bnz.co.nz/personal-banking/international/exchange-rates
     - ASB https://www.asb.co.nz/foreign-exchange/foreign-exchange-rates.html
     - Kiwibank https://www.kiwibank.co.nz/personal-banking/rates-and-fees/fx-rates/
     */
    internal func populateWithStaticList() {
        add(Currency(code: "NZD", name: "New Zealand dollar", flag: "🇳🇿", symbolPrefix: "$", symbolSuffix: "", exponent: 2, unit: "dollar", units: "dollars", subunit: "cent", subunits: "cents", prefix: "new zealand"))
        add(Currency(code: "USD", name: "United States dollar", flag: "🇺🇸", symbolPrefix: "$", symbolSuffix: "", exponent: 2, unit: "dollar", units: "dollars", subunit: "cent", subunits: "cents", prefix: "american"))
        add(Currency(code: "GBP", name: "Pound sterling", flag: "🇬🇧", symbolPrefix: "£", symbolSuffix: "", exponent: 2, unit: "pound", units: "pounds", subunit: "pence", subunits: "pence", prefix: "british"))
        add(Currency(code: "AUD", name: "Australian dollar", flag: "🇦🇺", symbolPrefix: "$", symbolSuffix: "", exponent: 2, unit: "dollar", units: "dollars", subunit: "cent", subunits: "cents", prefix: "australian"))
        add(Currency(code: "EUR", name: "Euro", flag: "🇪🇺", symbolPrefix: "€", symbolSuffix: "", exponent: 2, unit: "euro", units: "euros", subunit: "cent", subunits: "cents", prefix: "euro"))
        add(Currency(code: "JPY", name: "Japanese yen", flag: "🇯🇵", symbolPrefix: "￥", symbolSuffix: "", exponent: 0, unit: "yen", units: "yen", subunit: "", subunits: "", prefix: "japanese"))
        add(Currency(code: "CAD", name: "Canadian dollar", flag: "🇨🇦", symbolPrefix: "$", symbolSuffix: "", exponent: 2, unit: "dollar", units: "dollars", subunit: "cent", subunits: "cents", prefix: "canadian"))
        add(Currency(code: "CHF", name: "Swiss franc", flag: "🇨🇭", symbolPrefix: "Fr", symbolSuffix: "", exponent: 2, unit: "franc", units: "francs", subunit: "centime", subunits: "centimes", prefix: "swiss"))
        add(Currency(code: "XPF", name: "French Polynesia franc", flag: "🇵🇫", symbolPrefix: "₣", symbolSuffix: "", exponent: 2, unit: "franc", units: "francs", subunit: "centime", subunits: "centimes", prefix: "polynesian"))
        add(Currency(code: "DKK", name: "Danish krone", flag: "🇩🇰", symbolPrefix: "", symbolSuffix: "kr.", exponent: 2, unit: "krone", units: "kroner", subunit: "øre", subunits: "øre", prefix: "danish"))
        add(Currency(code: "FJD", name: "Fijian dollar", flag: "🇫🇯", symbolPrefix: "$", symbolSuffix: "", exponent: 2, unit: "dollar", units: "dollars", subunit: "cent", subunits: "cents", prefix: "fijian"))
        add(Currency(code: "HKD", name: "Hong Kong dollar", flag: "🇭🇰", symbolPrefix: "$", symbolSuffix: "", exponent: 2, unit: "dollar", units: "dollars", subunit: "cent", subunits: "cents", prefix: "hong kong"))
        add(Currency(code: "INR", name: "Indian rupee", flag: "🇮🇳", symbolPrefix: "₹", symbolSuffix: "", exponent: 2, unit: "rupee", units: "rupees", subunit: "paise", subunits: "paise", prefix: "indian"))
        add(Currency(code: "NOK", name: "Norwegian krone", flag: "🇳🇴", symbolPrefix: "", symbolSuffix: "kr.", exponent: 2, unit: "krone", units: "kroner", subunit: "øre", subunits: "øre", prefix: "norwegian"))
        add(Currency(code: "PKR", name: "Pakistan rupee", flag: "🇵🇰", symbolPrefix: "₨", symbolSuffix: "", exponent: 2, unit: "rupee", units: "rupees", subunit: "paisa", subunits: "paisa", prefix: "pakistan"))
        add(Currency(code: "PGK", name: "Papua New Guinean kina", flag: "🇵🇬", symbolPrefix: "K", symbolSuffix: "", exponent: 2, unit: "kina", units: "kina", subunit: "toea", subunits: "toea", prefix: "papua new guinean"))
        add(Currency(code: "PHP", name: "Philippine peso", flag: "🇵🇭", symbolPrefix: "₱", symbolSuffix: "", exponent: 2, unit: "peso", units: "pesos", subunit: "sentimo", subunits: "sentimo", prefix: "philippine"))
        add(Currency(code: "SGD", name: "Singapore dollar", flag: "🇸🇬", symbolPrefix: "$", symbolSuffix: "", exponent: 2, unit: "dollar", units: "dollars", subunit: "cent", subunits: "cents", prefix: "singaporean"))
        add(Currency(code: "SBD", name: "Solomon Islands dollar", flag: "🇸🇧", symbolPrefix: "$", symbolSuffix: "", exponent: 2, unit: "dollar", units: "dollars", subunit: "cent", subunits: "cents", prefix: "solomon islands"))
        add(Currency(code: "ZAR", name: "South African rand", flag: "🇿🇦", symbolPrefix: "R", symbolSuffix: "", exponent: 2, unit: "rand", units: "rand", subunit: "cent", subunits: "cents", prefix: "south african"))
        add(Currency(code: "LKR", name: "Sri Lankan rupee", flag: "🇱🇰", symbolPrefix: "රු.", symbolSuffix: "", exponent: 2, unit: "rupee", units: "rupees", subunit: "cent", subunits: "cents", prefix: "sri lankan"))
        add(Currency(code: "SEK", name: "Swedish krona", flag: "🇸🇪", symbolPrefix: "", symbolSuffix: "kr", exponent: 2, unit: "krona", units: "kronor", subunit: "øre", subunits: "øre", prefix: "swedish"))
        add(Currency(code: "THB", name: "Thai baht", flag: "🇹🇭", symbolPrefix: "฿", symbolSuffix: "", exponent: 2, unit: "baht", units: "baht", subunit: "satang", subunits: "satang", prefix: "thai"))
        add(Currency(code: "TOP", name: "Tongan paʻanga", flag: "🇹🇴", symbolPrefix: "T$", symbolSuffix: "", exponent: 2, unit: "paʻanga", units: "paʻanga", subunit: "seniti", subunits: "seniti", prefix: "tongan"))
        add(Currency(code: "VUV", name: "Vanuatu vatu", flag: "🇻🇺", symbolPrefix: "", symbolSuffix: "VT", exponent: 0, unit: "vatu", units: "vatu", subunit: "", subunits: "", prefix: "vanuatu"))
        add(Currency(code: "WST", name: "Samoan tālā", flag: "🇼🇸", symbolPrefix: "$", symbolSuffix: " tālā", exponent: 2, unit: "tala", units: "tala", subunit: "sene", subunits: "sene", prefix: "samoan"))
        add(Currency(code: "BHD", name: "Bahrain dinar", flag: "🇧🇭", symbolPrefix: "BD", symbolSuffix: "", exponent: 3, unit: "dinar", units: "dinars", subunit: "fils", subunits: "fils", prefix: "bahrainian"))
        add(Currency(code: "CNY", name: "Chinese yuán", flag: "🇨🇳", symbolPrefix: "￥", symbolSuffix: "", exponent: 2, unit: "yuán", units: "yuán", subunit: "fēn", subunits: "fēn", prefix: "chinese"))
        add(Currency(code: "KWD", name: "Kuwait dinar", flag: "🇰🇼", symbolPrefix: "KD", symbolSuffix: "", exponent: 2, unit: "dinar", units: "dinars", subunit: "fils", subunits: "fils", prefix: "kuwaiti"))
        add(Currency(code: "MXN", name: "Mexican peso", flag: "🇲🇽", symbolPrefix: "$", symbolSuffix: "", exponent: 2, unit: "peso", units: "pesos", subunit: "cent", subunits: "cents", prefix: "mexican"))
        add(Currency(code: "MYR", name: "Malaysian ringgit", flag: "🇲🇽", symbolPrefix: "RM", symbolSuffix: "", exponent: 2, unit: "ringgit", units: "ringgit", subunit: "sen", subunits: "sen", prefix: "malaysian"))
        add(Currency(code: "KRW", name: "South Korean won", flag: "🇰🇷", symbolPrefix: "₩", symbolSuffix: "", exponent: 0, unit: "won", units: "won", subunit: "", subunits: "", prefix: "korean"))
        add(Currency(code: "AED", name: "United Arab Emirates dirham", flag: "🇦🇪", symbolPrefix: "", symbolSuffix: "د.إ", exponent: 2, unit: "dirham", units: "dirhams", subunit: "fil", subunits: "fils", prefix: "emirates"))
        add(Currency(code: "CZK", name: "Czech Republic koruna", flag: "🇨🇿", symbolPrefix: "", symbolSuffix: "Kč", exponent: 2, unit: "koruna", units: "koruny", subunit: "haler", subunits: "haleru", prefix: "czech"))
        add(Currency(code: "HUF", name: "Hungarian forint", flag: "🇭🇺", symbolPrefix: "", symbolSuffix: "Ft", exponent: 2, unit: "forint", units: "forint", subunit: "filler", subunits: "filler", prefix: "hungarian"))
        add(Currency(code: "IDR", name: "Indonesian rupiah", flag: "🇮🇩", symbolPrefix: "Rp", symbolSuffix: "", exponent: 2, unit: "rupiah", units: "rupiahs", subunit: "sen", subunits: "sen", prefix: "indonesian"))
        add(Currency(code: "ILS", name: "Israel new shekel", flag: "🇮🇱", symbolPrefix: "₪", symbolSuffix: "", exponent: 2, unit: "shekel", units: "shekels", subunit: "agora", subunits: "agoras", prefix: "israeli"))
        add(Currency(code: "KES", name: "Kenyan shilling", flag: "🇰🇪", symbolPrefix: "K", symbolSuffix: "", exponent: 2, unit: "shilling", units: "shillings", subunit: "cent", subunits: "cents", prefix: "kenyan"))
        add(Currency(code: "PLN", name: "Polish zloty", flag: "🇵🇱", symbolPrefix: "", symbolSuffix: "zł", exponent: 2, unit: "zloty", units: "zloty", subunit: "grosz", subunits: "groszy", prefix: "polish"))
        add(Currency(code: "SAR", name: "Saudi Arabian riyal", flag: "🇸🇦", symbolPrefix: "", symbolSuffix: "SR", exponent: 2, unit: "riyal", units: "riyals", subunit: "halala", subunits: "halalas", prefix: "saudi"))
        add(Currency(code: "TRY", name: "Turkish lira", flag: "🇹🇷", symbolPrefix: "₺", symbolSuffix: "", exponent: 2, unit: "lira", units: "lira", subunit: "kurus", subunits: "kurus", prefix: "turkish"))
        add(Currency(code: "TWD", name: "Taiwanese new dollar", flag: "🇹🇼", symbolPrefix: "$", symbolSuffix: "", exponent: 2, unit: "dollar", units: "dollars", subunit: "cent", subunits: "cents", prefix: "taiwanese"))
        add(Currency(code: "VND", name: "Vietnamese dong", flag: "🇻🇳", symbolPrefix: "", symbolSuffix: "₫", exponent: 2, unit: "dong", units: "dong", subunit: "xu", subunits: "xu", prefix: "vietnamese"))
    }
    
}
