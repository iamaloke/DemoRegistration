//
//  CustomBottomBar.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 19/04/25.
//

import SwiftUI

struct CustomBottomBar: View {
    
    @State var bottomMenu: Menu = .home
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack(spacing: 20) {
                    ForEach(Menu.allCases, id: \.self) { item in
                        BottomBarButtonView(activeMenu: $bottomMenu, item: item) {
                            bottomMenu = item
                            print("imt", bottomMenu)
                        }
                        .frame(maxWidth: .infinity)
                        
                        if item == .location {
                            Spacer()
                            Spacer()
                        }
                    }
                }
                .offset(y: -10)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .background(
                RoundedRectangle(cornerRadius: 35, style: .continuous)
                    .fill(Color.white)
                    .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
            )
            
            Button(action: {
                print("Center + tapped")
            }) {
                VStack {
                    ZStack {
                        VStack(spacing: 0) {
                            Text("")
                                .frame(width: 80, height: 40)
                                .background(Color.clear)
                            
                            Text("")
                                .frame(width: 80, height: 40)
                                .background(Color.black.opacity(0.1))
                        }
                        .clipShape(Circle())
                        
                        Image(systemName: "plus")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 64, height: 64)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(color: Color.blue, radius: 4, y: 4)
                    }
                }
            }
            .offset(y: -50)
            .buttonStyle(.plain)
        }
    }
}

#Preview {
    CustomBottomBar()
}
