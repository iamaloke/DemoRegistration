//
//  RegistrationView.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 17/04/25.
//

import SwiftUI

struct FieldError {
    let status: Bool
    let message: String
}

struct RegistrationView: View {
    
    @FocusState private var isFocused: FocusableField?
    
    @State private var fieldValues: [FocusableField: String] = FocusableField.emptyFieldValues("")
    @State private var fieldErrors: [FocusableField: FieldError] = FocusableField.emptyFieldValues(FieldError(status: false, message: ""))
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text("Start by creating a free account-Its simple!")
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    ForEach(FocusableField.allCases, id: \.self) { element in
                        BottomBorderedTeftField(
                            text: binding(for: element),
                            isError: binding(for: element),
                            isFocused: $isFocused,
                            field: element)
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    Button {
                        isFocused = nil
                        
                        if validate() {
                            
                        }
                    } label: {
                        Text("Register")
                            .font(.system(size: 16, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 10)
                            .background(.purple)
                            .foregroundColor(.white)
                            .clipShape(.rect(cornerRadius: 8))
                    }
                    .buttonStyle(.plain)
                    .disabled(isLoading || fieldValues.allSatisfy { $0.value.isEmpty })
        
                }
                .padding()
                
                if isLoading {
                    ZStack {
                        Color
                            .black
                            .opacity(0.1)
                            .ignoresSafeArea()
                        
                        ProgressView()
                    }
                }
            }
            .navigationTitle("Create new Account")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    private func validate() -> Bool {
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
    
    private func binding(for field: FocusableField) -> Binding<String> {
        Binding(
            get: { fieldValues[field] ?? "" },
            set: { fieldValues[field] = $0 }
        )
    }
    
    private func binding(for field: FocusableField) -> Binding<FieldError> {
        Binding(
            get: { fieldErrors[field] ?? FieldError(status: false, message: "") },
            set: { fieldErrors[field] = $0 }
        )
    }
}

#Preview {
    RegistrationView()
}
