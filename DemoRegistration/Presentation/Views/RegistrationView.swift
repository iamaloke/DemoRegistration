//
//  RegistrationView.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 17/04/25.
//

import SwiftUI

enum FocusableField: String, Hashable, Identifiable, CaseIterable {
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


struct RegistrationView: View {
    
    @FocusState private var isFocused: FocusableField?
    
    @State private var fieldValues: [FocusableField: String] = [
        .name: "",
        .email: "",
        .password: ""
    ]
    @State private var isLoading: Bool = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(FocusableField.allCases, id: \.self) { element in
                    BottomBorderedTeftField(
                        text: binding(for: element),
                        isFocused: $isFocused,
                        field: element)
                }
                
                Button("Register") {
                    isFocused = nil
                }
                .disabled(isLoading)
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
    }
    
    private func binding(for field: FocusableField) -> Binding<String> {
        Binding(
            get: { fieldValues[field, default: ""] },
            set: { fieldValues[field] = $0 }
        )
    }
}

#Preview {
    RegistrationView()
}

struct BottomBorderedTeftField: View {
    
    @Binding var text: String
    @FocusState.Binding var isFocused: FocusableField?
    
    var field: FocusableField
    var borderFocusedColor: Color = .blue
    var borderUnFocusedColor: Color = .gray
    var borderErroredColor: Color = .red
    var borderWidth: CGFloat = 1
    
    var body: some View {
        VStack {
            if field.isSecured {
                SecureField(field.rawValue, text: $text)
                    .padding(.bottom, 4)
                    .focused($isFocused, equals: field)
            } else {
                TextField(field.rawValue, text: $text)
                    .padding(.bottom, 4)
                    .focused($isFocused, equals: field)
            }
            
            Rectangle()
                .frame(height: borderWidth)
                .foregroundColor(isFocused == field ? borderFocusedColor : borderUnFocusedColor)
        }
    }
}
