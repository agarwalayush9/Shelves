//
//  Tab.swift
//  Shelves-User
//
//  Created by Sahil Raj on 06/07/24.
//

import Foundation

enum Tab: String, CaseIterable
{
    case forYou = "For You"
    case explore = "Explore"
    case myLibrary = "My BookShelf"
    case profile = "Profile"
    
    var systemImage: String
    {
        switch self{
        case .explore:
            return "magnifyingglass"
            
        case .myLibrary:
            return "book"
            
        case .forYou:
            return "house"
            
        case .profile:
            return "person"
        }
    }
    var index: Int{
        return Tab.allCases.firstIndex(of: self) ?? 0
    }
}
