//
//  ValidEmailPublished.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 18/04/25.
//

import Combine
import Foundation

@propertyWrapper
class ValidEmailPublished {
    
    private var subject: CurrentValueSubject<String, Never>
    
    var wrappedValue: String {
        get { subject.value }
        set { subject.send(newValue) }
    }
    
    var projectedValue: PublisherAndValidation {
        PublisherAndValidation(
            subject: subject.eraseToAnyPublisher(),
            isValid: Self.isValidEmail(subject.value),
            value: subject.value
        )
    }
    
    init(wrappedValue: String = "") {
        self.subject = CurrentValueSubject(wrappedValue)
    }
    
    static func isValidEmail(_ email: String) -> FieldError {
        guard !email.isEmpty else {
            return FieldError(status: true, message: "This field is required")
        }
        
        let regex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let result = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: email)
        return FieldError(status: !result, message: !result ? "Enter valid email" : "")
    }
}

