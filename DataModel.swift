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

    func toDictionary() -> [String: Any] {
        return [
            "id": id.uuidString,
            "title": title,
            "date": date,
            "time": time,
            "location": location,
            "price": price,
            "imageName": imageName
        ]
    }
}


struct Author: Identifiable {
    let id = UUID()
    let name: String
    let title: String
    let description: String
    let image: String
}

struct Member {
    var email: String
    var firstName: String
    var lastName: String
    var phoneNumber: Int
    var subscriptionPlan: String
    var registeredEvents: [Event]
    var genre: [Genre]

    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "email": email,
            "firstName": firstName,
            "lastName": lastName,
            "phoneNumber": phoneNumber,
            "subscriptionPlan": subscriptionPlan,
            "genre": genre.map { $0.rawValue } // Convert Genre enum to raw values (String)
        ]

        // Convert registeredEvents to an array of dictionaries
        let eventsArray = registeredEvents.map { event -> [String: Any] in
            return event.toDictionary()
        }
        dictionary["registeredEvents"] = eventsArray

        return dictionary
    }
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

enum Genre: String, Codable {
    case Horror
    case Mystery
    case Fiction
    case Finance
    case Fantasy
    case Business
    case Romance
    case Psychology
    case YoungAdult
    case SelfHelp
    case HistoricalFiction
    case NonFiction
    case ScienceFiction
    case Literature
}
