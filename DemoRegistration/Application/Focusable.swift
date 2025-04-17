//
//  Focusable.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 17/04/25.
//

protocol Focusable: CaseIterable, Hashable, Identifiable {}

extension Focusable {
    static func emptyFieldValues<T>(_ defaultValue: T) -> [Self: T] {
        Dictionary(uniqueKeysWithValues: Self.allCases.map { ($0, defaultValue) })
    }
}

enum FocusableField: String, Focusable {
    case name = "Name"
    case email = "Email"
    case password = "Password"
    
    var isSecured: Bool {
        switch self {
            case .password: return true
            default: return false
        }
    }
    
    var id: FocusableField {
        self
    }
}
