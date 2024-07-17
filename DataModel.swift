//
//  DataModel.swift
//  Shelves-User
//
//  Created by Jhanvi Jindal on 11/07/24.
//

import Foundation

struct Event: Identifiable {
    var id = UUID()
    var name: String
    var host: String
    var date: Date
    var time: Date
    var address: String
    var duration: String
    var description: String
    var registeredMembers: [Member]
    var tickets: Int
    var imageName: String
    var fees: Int
    var revenue: Int
    var status: String
    
    func toDictionary() -> [String: Any] {
        return [
            "name": name,
            "host": host,
            "date": date.timeIntervalSince1970, // Convert Date to TimeInterval
            "time": time.timeIntervalSince1970,
            "address": address,
            "duration": duration,
            "description": description,
            "registeredMembers": registeredMembers.map { $0.toDictionary() },
            "tickets": tickets,
            "imageName": imageName,
            "fees": fees,
            "revenue": revenue,
            "status": status
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
    var subscriptionPlan: String?
    var registeredEvents: [Event]? // Optional array of Event
    var genre: [Genre]? // Optional array of Genre

    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "email": email,
            "firstName": firstName,
            "lastName": lastName,
            "phoneNumber": phoneNumber,
            "subscriptionPlan": subscriptionPlan ?? "", // Provide a default value if nil
        ]

        // Convert genre to an array of raw values (String)
        if let genreArray = genre {
            dictionary["genre"] = genreArray.map { $0.rawValue }
        }

        // Convert registeredEvents to an array of dictionaries if not nil
        if let eventsArray = registeredEvents {
            let eventsDictionaryArray = eventsArray.map { event -> [String: Any] in
                return event.toDictionary()
            }
            dictionary["registeredEvents"] = eventsDictionaryArray
        }

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
