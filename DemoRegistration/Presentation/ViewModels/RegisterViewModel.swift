//
//  RegisterViewModel.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 18/04/25.
//

import Combine
import SwiftUI

@MainActor
final class RegisterViewModel: ObservableObject {
    
    @Published var showFlashMessage: Bool = false
    @Published var isLoading: Bool = false
    @Published var isRedirect: Bool = false
    
    // Using custom property wrappers to validate fields
    @ValidInputPublished var name: String = ""
    @ValidEmailPublished var email: String = ""
    @ValidPasswordPublished var password: String = ""
    
    @Published var nameError: FieldError = FieldError(status: false, message: "")
    @Published var emailError: FieldError = FieldError(status: false, message: "")
    @Published var passwordError: FieldError = FieldError(status: false, message: "")
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $name.subject
            .dropFirst()
            .sink { [weak self] _ in
                self?.nameError = self?.$name.isValid ?? FieldError(status: false, message: "")
            }
            .store(in: &cancellables)
        
        $email.subject
            .dropFirst()
            .sink { [weak self] _ in
                self?.emailError = self?.$email.isValid ?? FieldError(status: false, message: "")
            }
            .store(in: &cancellables)
        
        $password.subject
            .dropFirst()
            .sink { [weak self] _ in
                self?.passwordError = self?.$password.isValid ?? FieldError(status: false, message: "")
            }
            .store(in: &cancellables)
    }
    
    func register() {
        isLoading = true
        
        Task {
            try? await Task.sleep(nanoseconds: 3 * 1_000_000_000)
            
            self.isLoading = false
            self.name = ""
            self.nameError = FieldError(status: false, message: "")
            self.email = ""
            self.emailError = FieldError(status: false, message: "")
            self.password = ""
            self.passwordError = FieldError(status: false, message: "")
            
            try await splash()
        }
    }
    
    func splash() async throws {
        isRedirect = false
        showFlashMessage = true
        
        try await Task.sleep(nanoseconds: 1 * 1_000_000_000)
        self.showFlashMessage = false
        self.isRedirect = true
    }
}

struct FieldError {
    let status: Bool
    let message: String
}
