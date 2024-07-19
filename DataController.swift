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
    
    
    func fetchMemberByEmail(_ email: String, completion: @escaping (Result<Member, Error>) -> Void) {
        let safeEmail = DataController.safeEmail(email: email)
        let capitalizedSafeEmail = safeEmail.prefix(1).capitalized + safeEmail.dropFirst()

        print("Fetching member with email: \(email)")
        print("Safe email generated: \(safeEmail)")
        print("Capitalized safe email for Firebase: \(capitalizedSafeEmail)")

        database.child("members").child(capitalizedSafeEmail).observeSingleEvent(of: .value) { snapshot in
            print("Firebase query initiated.")

            guard let memberDict = snapshot.value as? [String: Any] else {
                print("Snapshot value not valid or member not found.")
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Member not found."])))
                return
            }

            do {
                let member = try self.parseMember(from: memberDict)
                print("Member parsed successfully.")
                completion(.success(member))
            } catch {
                print("Error parsing member: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }


    func parseMember(from dict: [String: Any]) throws -> Member {
        guard
            let firstName = dict["firstName"] as? String,
            let lastName = dict["lastName"] as? String,
            let email = dict["email"] as? String,
            let phoneNumber = dict["phoneNumber"] as? Int
            // Add more fields as necessary
        else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid member data."])
        }

        // Optional fields
        let subscriptionPlan = dict["subscriptionPlan"] as? String
        let genreStrings = dict["genre"] as? [String] ?? []
        let genres = genreStrings.compactMap { Genre(rawValue: $0) }

        return Member(
            firstName: firstName,
            lastName: lastName,
            email: email,
            phoneNumber: phoneNumber,
            subscriptionPlan: subscriptionPlan,
            genre: genres
            // Add other fields
        )
    }

    
    func fetchAllEvents(completion: @escaping (Result<[Event], Error>) -> Void) {
        database.child("events").observeSingleEvent(of: .value) { snapshot in
            guard let eventsSnapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found or failed to cast snapshot value."])))
                return
            }
            
            var events: [Event] = []
            
            for eventSnapshot in eventsSnapshot {
                guard let eventDict = eventSnapshot.value as? [String: Any] else {
                    print("Failed to parse event data for event with ID: \(eventSnapshot.key)")
                    continue
                }
                
                do {
                    if let event = try self.parseEvent(from: eventDict, eventId: eventSnapshot.key) {
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
    
    
    private func parseEvent(from dict: [String: Any], eventId: String) throws -> Event? {
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
            print("Failed to parse event data. Missing or invalid key.")
            return nil
        }

        // Parse date and time
        let date = Date(timeIntervalSince1970: dateInterval)
        let time = Date(timeIntervalSince1970: timeInterval)

        // Parse registered members
        var registeredMembers: [Member] = []
        if let registeredMembersDict = dict["registeredMembers"] as? [String: [String: Any]] {
            for (_, memberDict) in registeredMembersDict {
                guard
                    let firstName = memberDict["firstName"] as? String,
                    let lastName = memberDict["lastName"] as? String,
                    let email = memberDict["email"] as? String,
                    let phoneNumber = memberDict["phoneNumber"] as? Int
                else {
                    print("Failed to parse registered member data.")
                    continue
                }
                let member = Member(firstName: firstName, lastName: lastName, email: email, phoneNumber: phoneNumber)
                registeredMembers.append(member)
            }
        }

        // Return Event object
        return Event(
            id: eventId,
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

    
    
    func addMemberToEvent(eventId: String, newMember: Member, completion: @escaping (Result<Void, Error>) -> Void) {
        let eventRef = database.child("events").child(eventId).child("registeredMembers")

        // Fetch the current list of registered members
        eventRef.observeSingleEvent(of: .value) { snapshot in
            var registeredMembers: [[String: Any]] = []

            // If there are existing members, fetch them
            if let membersArray = snapshot.value as? [[String: Any]] {
                registeredMembers = membersArray
            }

            // Convert the new member to a dictionary and add to the list
            let newMemberDict = newMember.toDictionary()
            registeredMembers.append(newMemberDict)

            // Update the registered members list in Firebase
            eventRef.setValue(registeredMembers) { error, _ in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }

    
    func fetchRegisteredEvents(for email: String, completion: @escaping (Result<[Event], Error>) -> Void) {
        let safeEmail = DataController.safeEmail(email: email)
        database.child("members").child(safeEmail).child("registeredEvents").observe(.value) { snapshot in
            guard let eventsSnapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No registered events found."])))
                return
            }

            var events: [Event] = []
            for eventSnapshot in eventsSnapshot {
                guard let eventDict = eventSnapshot.value as? [String: Any] else {
                    print("Failed to parse event data for event with snapshot: \(eventSnapshot)")
                    continue
                }

                do {
                    if let eventId = eventDict["id"] as? String,
                       let event = try self.parseEvent(from: eventDict, eventId: eventId) {
                        events.append(event)
                    } else {
                        print("Event id not found for event: \(eventDict)")
                    }
                } catch {
                    print("Failed to parse event data: \(error.localizedDescription)")
                }
            }

            completion(.success(events))
        }
    }



    
    func fetchEventById(_ eventId: String, completion: @escaping (Result<Event, Error>) -> Void) {
           database.child("events").child(eventId).observeSingleEvent(of: .value) { snapshot in
               guard let eventDict = snapshot.value as? [String: Any] else {
                   completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Event not found."])))
                   return
               }

               do {
                   if let event = try self.parseEvent(from: eventDict, eventId: eventId) {
                       completion(.success(event))
                   } else {
                       completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to parse event data."])))
                   }
               } catch {
                   completion(.failure(error))
               }
           }
       }
    
    func updateRegisteredEvents(email: String, newEvent: Event, completion: @escaping (Result<Void, Error>) -> Void) {
            let safeEmail = DataController.safeEmail(email: email)

            // Fetch the existing registered events
        database.child("members").child(safeEmail).child("registeredEvents").observeSingleEvent(of: .value) { snapshot in
                var registeredEvents: [[String: Any]] = []

                // Check if there are already registered events
                if let existingEvents = snapshot.value as? [[String: Any]] {
                    registeredEvents = existingEvents
                }

                // Add the new event
                registeredEvents.append(newEvent.toDictionary())

                // Update the registered events in the database
                self.database.child("members").child(safeEmail).child("registeredEvents").setValue(registeredEvents) { error, _ in
                    if let error = error {
                        print("Failed to update registered events: \(error.localizedDescription)")
                        completion(.failure(error))
                    } else {
                        print("Registered events updated successfully.")
                        completion(.success(()))
                    }
                }
            }
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

