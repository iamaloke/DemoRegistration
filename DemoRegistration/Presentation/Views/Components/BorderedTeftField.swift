//
//  BorderedTeftField.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 17/04/25.
//

import SwiftUI

struct BorderedTeftField: View {
    
    @Binding var text: String
    @Binding var isError: FieldError
    @FocusState.Binding var isFocused: FocusableField?
    
    var field: FocusableField
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text(field.rawValue)
                .font(.system(size: 16, weight: .medium))
                .padding(.bottom, 8)
            
            if field.isSecured {
                SecureField(field.rawValue, text: $text)
                    .focused($isFocused, equals: field)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .modifier(TextFieldModifier(isFocused: isFocused == field))
            } else {
                TextField(field.rawValue, text: $text)
                    .focused($isFocused, equals: field)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .modifier(TextFieldModifier(isFocused: isFocused == field))
            }
            
            Text(isError.status ? isError.message : "")
                .font(.caption)
                .foregroundStyle(.red)
                .animation(.easeIn, value: isError.status)
                .padding(.top, 4)
        }
    }
}
