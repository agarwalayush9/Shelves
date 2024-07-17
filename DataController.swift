//
//  DataController.swift
//  Shelves-User
//
//  Created by Sahil Raj on 08/07/24.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseDatabaseInternal

class DataController
{
    static let shared = DataController() // singleton
    let database = Database.database().reference()
    
    static func safeEmail(email: String) -> String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
    
    
    func addMember(_ member: Member, completion: @escaping (Result<Void, Error>) -> Void) {
        let safeEmail = DataController.safeEmail(email: member.email)

        // Check if the member email already exists
        database.child("members").child(safeEmail).observeSingleEvent(of: .value) { snapshot in
            if snapshot.exists() {
                // Member email already exists
                completion(.failure(NSError(domain: "", code: 1, userInfo: [NSLocalizedDescriptionKey: "Email is already in use."])))
            } else {
                // Add the member to the database
                self.saveMemberToDatabase(member) { result in
                    completion(result)
                }
            }
        }
    }

    private func saveMemberToDatabase(_ member: Member, completion: @escaping (Result<Void, Error>) -> Void) {
        let safeEmail = DataController.safeEmail(email: member.email)
        
        var memberDictionary: [String: Any] = [
            "email": member.email,
            "firstName": member.firstName,
            "lastName": member.lastName,
            "phoneNumber": member.phoneNumber,
            "subscriptionPlan": member.subscriptionPlan ?? "" // Provide a default value if nil
        ]

        // Convert genre to an array of raw values (String)
        if let genreArray = member.genre {
            memberDictionary["genre"] = genreArray.map { $0.rawValue }
        }

        // Convert registeredEvents to an array of dictionaries if not nil
        if let eventsArray = member.registeredEvents {
            var eventsDictionaryArray: [[String: Any]] = []
            for event in eventsArray {
                let eventDictionary = event.toDictionary()
                eventsDictionaryArray.append(eventDictionary)
            }
            memberDictionary["registeredEvents"] = eventsDictionaryArray
        }

        // Save member to database
        database.child("members").child(safeEmail).setValue(memberDictionary) { error, _ in
            if let error = error {
                print("Failed to save member: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Member saved successfully.")
                completion(.success(()))
            }
        }
    }

    
    func fetchAllEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
            database.child("events").observeSingleEvent(of: .value) { snapshot in
                guard let eventsDict = snapshot.value as? [String: [String: Any]] else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found or failed to cast snapshot value."])))
                    return
                }

                var events: [Event] = []

                for (_, dict) in eventsDict {
                    do {
                        if let event = try self.parseEvent(from: dict) {
                            events.append(event)
                        }
                    } catch {
                        print("Failed to parse event data: \(error.localizedDescription)")
                    }
                }

                print("Fetched \(events.count) events.")
                completion(.success(events))
            }
        }
    
    
    private func parseEvent(from dict: [String: Any]) throws -> Event? {
        // Extract values with conditional binding
        guard
            let name = dict["name"] as? String,
            let host = dict["host"] as? String,
            let dateInterval = dict["date"] as? TimeInterval,
            let timeInterval = dict["time"] as? TimeInterval,
            let address = dict["address"] as? String,
            let duration = dict["duration"] as? String,
            let description = dict["description"] as? String,
            let tickets = dict["tickets"] as? Int,
            let imageName = dict["imageName"] as? String,
            let fees = dict["fees"] as? Int,
            let revenue = dict["revenue"] as? Int,
            let status = dict["status"] as? String
        else {
            // Print missing or invalid keys
            let keyMissing = [
                "name": dict["name"],
                "host": dict["host"],
                "dateInterval": dict["dateInterval"],
                "timeInterval": dict["timeInterval"],
                "address": dict["address"],
                "duration": dict["duration"],
                "description": dict["description"],
                "tickets": dict["tickets"],
                "imageName": dict["imageName"],
                "fees": dict["fees"],
                "revenue": dict["revenue"],
                "status": dict["status"]
            ]
            
            print("Failed to parse event data. Missing or invalid key/value: \(keyMissing)")
            return nil
        }

        // Parse date and time
        let date = Date(timeIntervalSince1970: dateInterval)
        let time = Date(timeIntervalSince1970: timeInterval)

        // Parse registered members if available
        var registeredMembers: [Member] = []
        if let registeredMembersArray = dict["registeredMembers"] as? [[String: Any]] {
            for memberDict in registeredMembersArray {
                guard
                    let name = memberDict["name"] as? String,
                    let email = memberDict["email"] as? String,
                    let lastName = memberDict["lastName"] as? String,
                    let phoneNumber = memberDict["phoneNumber"] as? Int
                else {
                    print("Failed to parse registered member data.")
                    continue
                }
                let user = Member(email: email, firstName: name, lastName: lastName, phoneNumber: phoneNumber)
                registeredMembers.append(user)
            }
        }

        // Return Event object
        return Event(
            name: name,
            host: host,
            date: date,
            time: time,
            address: address,
            duration: duration,
            description: description,
            registeredMembers: registeredMembers,
            tickets: tickets,
            imageName: imageName,
            fees: fees,
            revenue: revenue,
            status: status
        )
    }


    func updateMemberGenre(email: String, selectedGenres: [Genre], completion: @escaping (Result<Void, Error>) -> Void) {
        let safeEmail = DataController.safeEmail(email: email)

        // Convert selected genres to an array of raw values (Strings)
        let updatedProperties = ["genre": selectedGenres.map { $0.rawValue }]

        // Update member properties in the database
        database.child("members").child(safeEmail).updateChildValues(updatedProperties) { error, _ in
            if let error = error {
                print("Failed to update member genre properties: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Member genre properties updated successfully.")
                completion(.success(()))
            }
        }
    }

    func updateSubscriptionPlan(email: String, newSubscriptionPlan: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let safeEmail = DataController.safeEmail(email: email)

        let updatedProperties = ["subscriptionPlan": newSubscriptionPlan]

        // Update member properties in the database
        database.child("members").child(safeEmail).updateChildValues(updatedProperties) { error, _ in
            if let error = error {
                print("Failed to update member subscription plan: \(error.localizedDescription)")
                completion(.failure(error))
            } else {
                print("Member subscription plan updated successfully.")
                completion(.success(()))
            }
        }
    }

    
    func isEmailAlreadyInUse(email: String, completion: @escaping (Bool) -> Void) {
        Auth.auth().fetchSignInMethods(forEmail: email) { methods, error in
            if let error = error {
                print("Error fetching sign in methods: \(error.localizedDescription)")
                completion(false) // Assume email is not in use if error occurs
                return
            }
            
            // Check if methods array is empty or nil
            if let methods = methods, !methods.isEmpty {
                // Email exists (methods array is not empty)
                completion(true)
            } else {
                // Email does not exist
                completion(false)
            }
        }
    }
    
    func fetchBronzeSubscription(completion: @escaping (Result<BronzeSubscription, Error>) -> Void) {
        database.child("subscriptions").child("bronze").observeSingleEvent(of: .value) { snapshot in
            guard let subscriptionData = snapshot.value as? [String: Any] else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found or failed to cast snapshot value for Bronze subscription."])))
                return
            }
            
            guard let monthly = subscriptionData["monthly"] as? Int,
                  let yearly = subscriptionData["yearly"] as? Int,
                  let activeUsers = subscriptionData["activeUsers"] as? Int
            else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse Bronze subscription data."])))
                return
            }
            
            let bronzeSubscription = BronzeSubscription(monthly: monthly, yearly: yearly, activeUsers: activeUsers)
            completion(.success(bronzeSubscription))
        }
    }

    func fetchSilverSubscription(completion: @escaping (Result<SilverSubscription, Error>) -> Void) {
        database.child("subscriptions").child("silver").observeSingleEvent(of: .value) { snapshot in
            guard let subscriptionData = snapshot.value as? [String: Any] else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found or failed to cast snapshot value for Silver subscription."])))
                return
            }
            
            guard let monthly = subscriptionData["monthly"] as? Int,
                  let yearly = subscriptionData["yearly"] as? Int,
                  let activeUser = subscriptionData["activeUser"] as? Int
            else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse Silver subscription data."])))
                return
            }
            
            let silverSubscription = SilverSubscription(monthly: monthly, yearly: yearly, activeUser: activeUser)
            completion(.success(silverSubscription))
        }
    }

    func fetchGoldSubscription(completion: @escaping (Result<GoldSubscription, Error>) -> Void) {
        database.child("subscriptions").child("gold").observeSingleEvent(of: .value) { snapshot in
            guard let subscriptionData = snapshot.value as? [String: Any] else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found or failed to cast snapshot value for Gold subscription."])))
                return
            }
            
            guard let monthly = subscriptionData["monthly"] as? Int,
                  let yearly = subscriptionData["yearly"] as? Int,
                  let activeUsers = subscriptionData["activeUsers"] as? Int
            else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse Gold subscription data."])))
                return
            }
            
            let goldSubscription = GoldSubscription(monthly: monthly, yearly: yearly, activeUsers: activeUsers)
            completion(.success(goldSubscription))
        }
    }

    func updateBronzeSubscription(monthly: Int, yearly: Int, activeUsers: Int, completion: @escaping (Result<Void, Error>) -> Void) {
            let updatedProperties: [String: Any] = [
                "monthly": monthly,
                "yearly": yearly,
                "activeUsers": activeUsers
            ]
            
            database.child("subscriptions").child("bronze").updateChildValues(updatedProperties) { error, _ in
                if let error = error {
                    print("Failed to update bronze subscription: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    print("Bronze subscription updated successfully.")
                    completion(.success(()))
                }
            }
        }
        
        func updateSilverSubscription(monthly: Int, yearly: Int, activeUser: Int, completion: @escaping (Result<Void, Error>) -> Void) {
            let updatedProperties: [String: Any] = [
                "monthly": monthly,
                "yearly": yearly,
                "activeUser": activeUser
            ]
            
            database.child("subscriptions").child("silver").updateChildValues(updatedProperties) { error, _ in
                if let error = error {
                    print("Failed to update silver subscription: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    print("Silver subscription updated successfully.")
                    completion(.success(()))
                }
            }
        }
        
        func updateGoldSubscription(monthly: Int, yearly: Int, activeUsers: Int, completion: @escaping (Result<Void, Error>) -> Void) {
            let updatedProperties: [String: Any] = [
                "monthly": monthly,
                "yearly": yearly,
                "activeUsers": activeUsers
            ]
            
            database.child("subscriptions").child("gold").updateChildValues(updatedProperties) { error, _ in
                if let error = error {
                    print("Failed to update gold subscription: \(error.localizedDescription)")
                    completion(.failure(error))
                } else {
                    print("Gold subscription updated successfully.")
                    completion(.success(()))
                }
            }
        }
    

    }

