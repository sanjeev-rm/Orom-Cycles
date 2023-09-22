//
//  ValidityAndError.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 03/07/23.
//

import Foundation

/// Structure to represent whether something is valid or not
/// - isValid
///     - true if valid and false otherwise
/// - error
///     - The error message that can be used when the isValid is false
///     - Always give a default value to use when it's set to false
struct ValidityAndError<Error> {
    var isValid: Bool
    var error: Error
    
    /// Set the item's validity to valid
    mutating func setValid() {
        self.isValid = true
    }
    
    /// Set the item's validity to invalid with error
    mutating func setInvalid(withError error: Error) {
        self.isValid = false
        self.error = error
    }
}
