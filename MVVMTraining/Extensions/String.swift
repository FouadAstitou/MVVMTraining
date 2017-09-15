//
//  String.swift
//  MVVMTraining
//
//  Created by Fouad Astitou on 15-09-17.
//  Copyright © 2017 Nerdvana. All rights reserved.
//

import Foundation

extension String {
    /// Checks if the string is empty and doesn't contain whitespaces
    func isEmptyAndContainsNoWhitespace() -> Bool {
        guard self.isEmpty, self.trimmingCharacters(in: .whitespaces).isEmpty
            else {
                return false
        }
        return true
    }
    
    /// Uses the string as a key to return a localized string.
    func localizedString() -> String {
        return NSLocalizedString(self, comment: "")
    }
}
