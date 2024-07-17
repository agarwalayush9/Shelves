//
//  DataModel.swift
//  Shelves-User
//
//  Created by Jhanvi Jindal on 11/07/24.
//

import Foundation

struct Event: Identifiable {
    var id: String = UUID().uuidString
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
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: Int
    var subscriptionPlan: String?
    var genre: [Genre]?

    // Additional methods or properties as needed

    var safeEmail: String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }

    func toDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "email": email,
            "phoneNumber": phoneNumber
        ]

        if let subscriptionPlan = subscriptionPlan {
            dictionary["subscriptionPlan"] = subscriptionPlan
        }

        if let genre = genre {
            dictionary["genre"] = genre.map { $0.rawValue }
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
