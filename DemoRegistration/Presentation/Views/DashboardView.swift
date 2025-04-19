//
//  DashboardView.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 17/04/25.
//

import SwiftUI

struct DashboardView: View {
    
    @State var stepper: Double = 1
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                Text("January")
                    .font(.system(size: 18, weight: .bold))
                    .padding(15)
                
                HStack {
                    Text("$ 500")
                        .font(.system(size: 36, weight: .heavy))
                    
                    Spacer()
                    
                    Image(systemName: "chart.bar.xaxis.ascending")
                        .font(.system(size: 24, weight: .medium))
                }
                .padding(.horizontal, 15)
                
                HStack {
                    ProgressView(value: 0.6)
                        .progressViewStyle(LinearProgressViewStyle())
                        .tint(.white)
                        .background(.white.opacity(0.3))
                        .clipShape(.capsule)
                    
                    Spacer()
                    
                    Text("60%")
                }
                .padding(.horizontal, 15)
                .padding(.top, 15)
                
                Text("Daily Spend Target: $16.76")
                    .padding(.horizontal, 15)
                    .padding(.vertical, 15)
            }
            .background(Color.blue)
            .clipShape(.rect(cornerRadius: 15))
            .padding(15)
            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 2, y: 4)
            .foregroundStyle(Color.white)
            
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
