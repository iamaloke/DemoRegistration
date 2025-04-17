//
//  Focusable.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 17/04/25.
//

protocol Focusable: CaseIterable, Hashable, Identifiable {}

extension Focusable {
    static func emptyFieldValues() -> [Self: String] {
        Dictionary(uniqueKeysWithValues: Self.allCases.map { ($0, "") })
    }
}
