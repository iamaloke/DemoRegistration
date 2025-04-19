//
//  Menu.swift
//  DemoRegistration
//
//  Created by Alok Kumar on 19/04/25.
//

import Foundation

enum Menu: CaseIterable, Identifiable {
    case home
    case location
    case health
    case profile
    
    var id: Menu {
        self
    }
    
    var icon: String {
        switch self {
            case .home: return "house"
            case .location: return "mappin"
            case .health: return "heart"
            case .profile: return "person"
        }
    }
}
