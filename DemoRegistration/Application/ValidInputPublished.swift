//
//  ValidInputPublished.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 18/04/25.
//

import Combine
import Foundation

@propertyWrapper
class ValidInputPublished {
    
    private var subject: CurrentValueSubject<String, Never>
    
    var wrappedValue: String {
        get { subject.value }
        set { subject.send(newValue) }
    }
    
    var projectedValue: PublisherAndValidation {
        PublisherAndValidation(
            subject: subject.eraseToAnyPublisher(),
            isValid: Self.isValid(subject.value),
            value: subject.value
        )
    }
    
    init(wrappedValue: String = "") {
        self.subject = CurrentValueSubject(wrappedValue)
    }
    
    static func isValid(_ value: String) -> FieldError {
        return FieldError(status: value.isEmpty, message: value.isEmpty ? "This field is required" : "")
    }
}
