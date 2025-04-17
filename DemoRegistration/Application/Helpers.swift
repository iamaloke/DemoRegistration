//
//  Helpers.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 17/04/25.
//

import Foundation

func isValidEmail(_ email: String) -> Bool {
    let pattern =
    #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
    return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: email)
}

enum PasswordValidationError: String, CaseIterable {
    case tooShort = "Password must be at least 8 characters long"
    case missingLowercase = "It must contain at least one lowercase letter required"
    case missingUppercase = "It must contain at least one uppercase letter required"
    case missingNumber = "It must contain at least one number required"
    case missingSpecialChar = "It must contain at least one special character required"
}

func validatePassword(_ password: String) -> [PasswordValidationError] {
    var errors: [PasswordValidationError] = []
    
    if password.count < 8 {
        errors.append(.tooShort)
    }
    if password.range(of: "[a-z]", options: .regularExpression) == nil {
        errors.append(.missingLowercase)
    }
    if password.range(of: "[A-Z]", options: .regularExpression) == nil {
        errors.append(.missingUppercase)
    }
    if password.range(of: "\\d", options: .regularExpression) == nil {
        errors.append(.missingNumber)
    }
    if password.range(of: "[!@#$%^&*(),.?\":{}|<>]", options: .regularExpression) == nil {
        errors.append(.missingSpecialChar)
    }
    
    return errors
}
