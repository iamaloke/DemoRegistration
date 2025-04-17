//
//  RegistrationView.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 17/04/25.
//

import SwiftUI

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


struct RegistrationView: View {
    
    @FocusState private var isFocused: FocusableField?
    
    @State private var fieldValues: [FocusableField: String] = FocusableField.emptyFieldValues()
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
                            isFocused: $isFocused,
                            field: element)
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    Button {
                        isFocused = nil
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
            .navigationTitle("Create new Account")
            .navigationBarTitleDisplayMode(.inline)
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
