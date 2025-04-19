//
//  BottomBarButtonView.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 19/04/25.
//

import SwiftUI

struct BottomBarButtonView: View {
    
    @Binding var activeMenu: Menu
    
    var item: Menu
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .center) {
                Image(systemName: item.icon)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(activeMenu == item ? .blue : .gray)
                
                Circle()
                    .fill(activeMenu == item ? Color.blue : Color.clear)
                    .frame(width: 4, height: 4)
            }
        }
        .buttonStyle(.plain)
        .padding()
    }
}

#Preview {
    NavigationStack {
        BottomBarButtonView(activeMenu: .constant(.home), item: .home) {
            
        }
    }
}
