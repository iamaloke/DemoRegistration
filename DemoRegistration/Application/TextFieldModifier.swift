//
//  TextFieldModifier.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 17/04/25.
//

import SwiftUI

struct TextFieldModifier: ViewModifier {
    var isFocused: Bool = false
    var borderFocusedColor: Color = .blue
    var borderUnFocusedColor: Color = .gray
    var borderErroredColor: Color = .red
    var borderFocusedWidth: CGFloat = 1.5
    var borderUnFocusedWidth: CGFloat = 1
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, 4)
            .padding(.vertical, 8)
            .padding(.horizontal, 16)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(.systemGray6))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(isFocused ? borderFocusedColor : borderUnFocusedColor, lineWidth: isFocused ? borderFocusedWidth : borderUnFocusedWidth)
                    )
            )
            .animation(.easeInOut(duration: 0.2), value: isFocused)
    }
}
