//
//  RegisterViewModel.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 18/04/25.
//

import SwiftUI

@MainActor
final class RegisterViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var fieldValues: [FocusableField: String] = FocusableField.emptyFieldValues("")
    @Published var fieldErrors: [FocusableField: FieldError] = FocusableField.emptyFieldValues(FieldError(status: false, message: ""))
    
    func validate() -> Bool {
        var isValid = true
        
        FocusableField.allCases.forEach { field in
            fieldErrors[field] = FieldError(status: false, message: "")
            
            if let value = fieldValues[field], value.isEmpty {
                isValid = false
                fieldErrors[field] = FieldError(status: true, message: "Please enter \(field.rawValue)")
            } else if field == .email, let value = fieldValues[field], !isValidEmail(value) {
                isValid = false
                fieldErrors[field] = FieldError(status: true, message: "Please enter valid email")
            } else if field == .password, let value = fieldValues[field] {
                isValid = false
                let issues = validatePassword(value)
                if !issues.isEmpty {
                    fieldErrors[field] = FieldError(status: true, message: issues.reduce("", { partialResult, errorCase in
                        partialResult + errorCase.rawValue + ",\n"
                    }))
                }
            }
        }
        
        return isValid
    }
    
    func binding(for field: FocusableField) -> Binding<String> {
        Binding(
            get: { self.fieldValues[field] ?? "" },
            set: { self.fieldValues[field] = $0 }
        )
    }
    
    func binding(for field: FocusableField) -> Binding<FieldError> {
        Binding(
            get: { self.fieldErrors[field] ?? FieldError(status: false, message: "") },
            set: { self.fieldErrors[field] = $0 }
        )
    }
}

struct FieldError {
    let status: Bool
    let message: String
}
