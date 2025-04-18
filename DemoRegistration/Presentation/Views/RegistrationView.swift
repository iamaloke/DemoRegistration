//
//  RegistrationView.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 17/04/25.
//

import SwiftUI

struct RegistrationView: View {
    
    @FocusState var isFocused: FocusableField?
    @StateObject var viewModel = RegisterViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        isFocused = nil
                    }
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text("Start by creating a free account-Its simple!")
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: .infinity)
                    
                    Spacer()
                    
                    ForEach(FocusableField.allCases, id: \.self) { element in
                        BottomBorderedTeftField(
                            text: viewModel.binding(for: element),
                            isError: viewModel.binding(for: element),
                            isFocused: $isFocused,
                            field: element)
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    Button {
                        
                        viewModel.isLoading = true
                        isFocused = nil
                        
                        Task {
                            try? await Task.sleep(nanoseconds: 3 * 1_000_000_000)
                            if viewModel.validate() {
                                
                            }
                            self.viewModel.isLoading = false
                        }
                        
                    } label: {
                        Text("Register")
                            .font(.system(size: 16, weight: .bold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(.purple)
                            .foregroundColor(.white)
                            .clipShape(.rect(cornerRadius: 8))
                    }
                    .buttonStyle(.plain)
                    .disabled(viewModel.isLoading || viewModel.fieldValues.allSatisfy { $0.value.isEmpty })
        
                }
                .padding()
                
                if viewModel.isLoading {
                    ZStack {
                        Color
                            .black
                            .opacity(0.1)
                            .ignoresSafeArea()
                        
                        ProgressView()
                    }
                }
                
                if viewModel.showFlashMessage {
                    VStack {
                        Spacer()
                        
                        Text("Splash message")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .padding(.bottom, 30)
                            .padding(.horizontal)
                            .animation(.easeIn, value: viewModel.showFlashMessage)
                    }
                }
            }
            .navigationTitle("Create new Account")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    RegistrationView()
}
