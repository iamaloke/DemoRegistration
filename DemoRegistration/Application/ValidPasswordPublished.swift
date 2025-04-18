//
//  ValidPasswordPublished.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 18/04/25.
//

import Combine
import Foundation

@propertyWrapper
class ValidPasswordPublished {
    
    private var subject: CurrentValueSubject<String, Never>
    
    var wrappedValue: String {
        get { subject.value }
        set { subject.send(newValue) }
    }
    
    var projectedValue: PublisherAndValidation {
        PublisherAndValidation(
            subject: subject.eraseToAnyPublisher(),
            isValid: Self.isValidPassword(subject.value),
            value: subject.value
        )
    }
    
    private enum PasswordValidationError: String, CaseIterable {
        case tooShort = "Password must be at least 8 characters long"
        case missingLowercase = "It must contain at least one lowercase letter required"
        case missingUppercase = "It must contain at least one uppercase letter required"
        case missingNumber = "It must contain at least one number required"
        case missingSpecialChar = "It must contain at least one special character required"
    }
    
    init(wrappedValue: String = "") {
        self.subject = CurrentValueSubject(wrappedValue)
    }
    
    static func isValidPassword(_ password: String) -> FieldError {
        guard !password.isEmpty else {
            return FieldError(status: true, message: "This field is required")
        }
        
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
         
        return FieldError(status: !errors.isEmpty, message: !errors.isEmpty ? errors.reduce("", { partialResult, errorCase in
            partialResult + errorCase.rawValue + ",\n"
        }) : "")
    }
}
