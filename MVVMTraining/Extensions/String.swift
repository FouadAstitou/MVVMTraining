//
//  String.swift
//  MVVMTraining
//
//  Created by Fouad Astitou on 15-09-17.
//  Copyright © 2017 Nerdvana. All rights reserved.
//

import Foundation

extension String {
    func isEmptyAndContainsNoWhitespace() -> Bool {
        guard self.isEmpty, self.trimmingCharacters(in: .whitespaces).isEmpty
            else {
                return false
        }
        return true
    }
}
