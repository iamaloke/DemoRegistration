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
    
    var isError: Bool {
        viewModel.isLoading ||
        viewModel.name.isEmpty ||
        viewModel.email.isEmpty ||
        viewModel.password.isEmpty ||
        viewModel.nameError.status ||
        viewModel.emailError.status ||
        viewModel.passwordError.status
    }
    
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
                    
                    BorderedTeftField(text: $viewModel.name, isError: $viewModel.nameError, isFocused: $isFocused, field: .name)
                    
                    BorderedTeftField(text: $viewModel.email, isError: $viewModel.emailError, isFocused: $isFocused, field: .email)
                    
                    BorderedTeftField(text: $viewModel.password, isError: $viewModel.passwordError, isFocused: $isFocused, field: .password)
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    
                    Button {
                        isFocused = nil
                        viewModel.register()
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
                    .disabled(isError)
        
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
                        Spacer()
                        
                        Text("Registration Successful!")
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.black.opacity(0.8))
                            .padding(.bottom, 30)
                            .padding(.horizontal)
                            .animation(.easeIn, value: viewModel.showFlashMessage)
                        
                        Spacer()
                    }
                }
            }
            .navigationTitle("Create new Account")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(isPresented: $viewModel.isRedirect) {
                DashboardView()
            }
        }
    }
}

#Preview {
    RegistrationView()
}
