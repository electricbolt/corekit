/*******************************************************************************
 * String+Utilities.swift                                                      *
 * CoreKit Copyright© 2019; Electric Bolt Limited.                             *
 ******************************************************************************/

import Foundation

/**
 Utility extensions to Swift's String class.
 */

public extension String {
    
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
