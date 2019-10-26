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

}
