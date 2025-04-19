//
//  DashboardView.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 17/04/25.
//

import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack {
            Spacer()
            
            Text("Content Area")
                .font(.title)
                .padding(.top)
            
            Spacer()
            
            CustomBottomBar()
        }
        .ignoresSafeArea(.container, edges: [.bottom])
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("Dashboard")
                    .font(.system(size: 32, weight: .bold))
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.black)
                    .padding(6)
                    .overlay(
                        RoundedRectangle(cornerRadius: 6)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .shadow(color: .gray.opacity(0.5), radius: 5, x: 0, y: 4)
            }
        }
    }
}

#Preview {
    NavigationStack {
        DashboardView()
    }
}
