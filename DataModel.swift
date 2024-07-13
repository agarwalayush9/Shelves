//
//  DataModel.swift
//  Shelves-User
//
//  Created by Jhanvi Jindal on 11/07/24.
//

import Foundation
struct Event: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let time: String
    let location: String
    let price: String
    let imageName: String
}


struct Author: Identifiable {
    let id = UUID()
    let name: String
    let title: String
    let description: String
    let image: String
}


struct BronzeSubscription {
    
    var monthly: Int
    var yearly: Int
    var activeUsers: Int
    
    func toDictionary() -> [String: Any] {
        return [
            "monthly": monthly,
            "yearly": yearly,
            "activeUsers": activeUsers
        ]
    }
}

struct SilverSubscription {
    
    var monthly: Int
    var yearly: Int
    var activeUser: Int
    
    func toDictionary() -> [String: Any] {
        return [
            "monthly": monthly,
            "yearly": yearly,
            "activeUsers": activeUser
        ]
    }
}

struct GoldSubscription {
    var monthly: Int
    var yearly: Int
    var activeUsers: Int
    
    func toDictionary() -> [String: Any] {
        return [
            "monthly": monthly,
            "yearly": yearly,
            "activeUsers": activeUsers
        ]
    }
}
