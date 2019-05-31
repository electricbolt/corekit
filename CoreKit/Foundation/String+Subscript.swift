/*******************************************************************************
 * String+Subscript.swift                                                      *
 * CoreKit Copyright© 2019; Electric Bolt Limited.                             *
 ******************************************************************************/

import Foundation

/**
 Extensions to Swift's String class to provide easier and safer access to substrings (at the expense of performance).
 Easier - no String.Index manipulation is required, indexes are specified using Int's. Safer - all bounds checking is
 performed before string manipulation, and therefore no possibility of generating an uncatchable fatal error can occur.
 */

public extension String {
    
    /**
     Returns the character at the given index of the receiver. If the given index is out of bounds, then nil is returned.
     */
    subscript (index: Int) -> Character? {
        if index < 0 {
            return nil
        } else if index >= self.count {
            return nil
        } else {
            let charIndex = self.index(self.startIndex, offsetBy: index)
            return self[charIndex];
        }
    }
    
    /**
     Returns a new string containing the characters of the receiver from the one at a given index to the end. If the
     given index is out of bounds, then the index is automatically repaired to be in bounds, with the returned string
     appropriately adjusted. Example: 5...
     */
    subscript (range: PartialRangeFrom<Int>) -> String {
        let lowerBound = range.lowerBound
        if lowerBound < 0 {
            return self
        } else if lowerBound >= self.count {
            return ""
        } else {
            let startIndex = self.index(self.startIndex, offsetBy: lowerBound)
            return String(self[startIndex..<endIndex])
        }
    }
    
    /**
     Returns a new string containing the characters of the receiver up to, but not including, the one at a given index.
     If the given index is out of bounds, then the index is automatically repaired to be in bounds, with the returned
     string appropriately adjusted. Example: ..<5
     */
    subscript (range: PartialRangeUpTo<Int>) -> String {
        let upperBound = range.upperBound
        if upperBound < 0 {
            return ""
        } else if upperBound >= self.count {
            return self
        } else {
            let endIndex = self.index(self.startIndex, offsetBy: upperBound)
            return String(self[self.startIndex..<endIndex])
        }
    }
    
    /**
     Returns a new string containing the characters of the receiver up to and including, the one at a given index. If
     the given index is out of bounds, then the index is automatically repaired to be in bounds, with the returned
     string appropriately adjusted. Example: ...5
     */
    subscript (range: PartialRangeThrough<Int>) -> String {
        let upperBound = range.upperBound
        if upperBound < 0 {
            return ""
        } else if upperBound >= self.count {
            return self
        } else {
            let endIndex = self.index(self.startIndex, offsetBy: upperBound)
            return String(self[self.startIndex...endIndex])
        }
    }
    
    /**
     Returns a string object containing the characters of the receiver that lie within a given range up to and including
     the upper bound. If the given index is out of bounds, then the index is automatically repaired to be in bounds,
     with the returned string appropriately adjusted. Example: 0...5
     */
    subscript (range: ClosedRange<Int>) -> String {
        let startIndex: String.Index
        let lowerBound = range.lowerBound
        if lowerBound < 0 {
            startIndex = self.startIndex
        } else if lowerBound >= self.count {
            return ""
        } else {
            startIndex = self.index(self.startIndex, offsetBy: lowerBound)
        }

        let upperBound = range.upperBound
        if upperBound < 0 {
            return ""
        } else if upperBound >= self.count {
            return String(self[startIndex..<self.endIndex])
        } else {
            let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
            return String(self[startIndex...endIndex])
        }
    }
    
    /**
     Returns a string object containing the characters of the receiver that lie within a given range up to but not
     including the upper bound. If the given index is out of bounds, then the index is automatically repaired to be in
     bounds, with the returned string appropriately adjusted. Example: 0..<5
     */
    subscript (range: Range<Int>) -> String {
        let startIndex: String.Index
        let lowerBound = range.lowerBound
        if lowerBound < 0 {
            startIndex = self.startIndex
        } else if lowerBound >= self.count {
            return ""
        } else {
            startIndex = self.index(self.startIndex, offsetBy: lowerBound)
        }
        
        let upperBound = range.upperBound
        if upperBound < 0 {
            return ""
        } else if upperBound >= self.count {
            return String(self[startIndex..<self.endIndex])
        } else {
            let endIndex = self.index(self.startIndex, offsetBy: range.upperBound)
            return String(self[startIndex..<endIndex])
        }
    }
    
    /**
     Returns a new string containing the characters of the receiver from the one at a given index to the end. If the
     given index is out of bounds, then the index is automatically repaired to be in bounds, with the returned string
     appropriately adjusted. Example: 5...
     */
    func substring(from index: Int) -> String {
        return self[index...]
    }

    /**
     Returns a new string containing the characters of the receiver up to, but not including, the one at a given index.
     If the given index is out of bounds, then the index is automatically repaired to be in bounds, with the returned
     string appropriately adjusted. Example: ..<5
     */
    func substring(to index: Int) -> String {
        return self[..<index]
    }
    
    /**
     Returns a string object containing the characters of the receiver that lie within a given range up to but not
     including the upper bound. If the given index is out of bounds, then the index is automatically repaired to be in
     bounds, with the returned string appropriately adjusted. Example: 0..<5
     */
    func substring(from index: Int, to: Int) -> String {
        if index > to {
            return ""
        } else {
            return self[index..<to]
        }
    }
    
    /**
     Returns a string object containing the `length` lefthand most characters of the receiver. If the length is out of
     bounds, then the length is automatically repaired to be in bounds, with the returned string appropriately
     adjusted. Example: "my dog has fleas".left(6) == "my dog"
     */
    func left(_ length: Int) -> String {
        return self[..<length]
    }
    
    /**
     Returns a string object containing the `length` righthand most characters of the receiver. If the length is out of
     bounds, then the length is automatically repaired to be in bounds, with the returned string appropriately
     adjusted. Example: "my dog has fleas".left(5) == "fleas"
     */
    func right(_ length: Int) -> String {
        return self[(self.count-length)...]
    }
    
    /**
     If the receiver is longer than largestLength, the function splits the receiver into multiple strings of no more
     than splitLength. If the receiver is less than or equal to largestLength, then the string is returned as the sole
     array item. Returns an array of string objects. The behaviour of the function is undefined if splitLength >=
     largestLength. Example: if the receiver is 45 characters in length, calling the split function with (30,20), will
     return an array of 3 strings of lengths 20,20,5.
     */
    func split(largestLength: Int, splitLength: Int) -> [String] {
        if self.count <= largestLength {
            return [self]
        } else {
            var messages: [String] = [String]()
            var count = self.count / splitLength
            let rem = self.count % splitLength
            count += (rem != 0 ? 1 : 0)
            var offset = 0, len = 0
            while offset < self.count {
                len = self.count - offset
                if len > splitLength {
                    len = splitLength
                }
                messages.append(self[offset..<offset+len])
                offset += splitLength
            }
            return messages;
        }
    }
    
    /**
     If the receiver has the prefix specified, then returns the receiver with the prefix removed, otherwise returns the
     receiver.
     */
    func removePrefix(_ string: String) -> String {
        if string != "" && self.hasPrefix(string) {
            let startIndex = self.index(self.startIndex, offsetBy: string.count)
            return String(self[startIndex...])
        } else {
            return self
        }
    }

    /**
     If the receiver has the suffix specified, then returns the receiver with the suffix removed, otherwise returns the
     receiver.
     */
    func removeSuffix(_ string: String) -> String {
        if self == string {
            return ""
        } else if string != "" && self.hasSuffix(string) {
            let endIndex = self.index(self.endIndex, offsetBy: -string.count)
            return String(self[..<endIndex])
        } else {
            return self
        }
    }

}
