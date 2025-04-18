//
//  Helpers.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 17/04/25.
//

import Combine

struct PublisherAndValidation {
    let subject: AnyPublisher<String, Never>
    let isValid: FieldError
    let value: String
}
