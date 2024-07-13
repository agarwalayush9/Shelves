//
//  DataController.swift
//  Shelves-User
//
//  Created by Sahil Raj on 08/07/24.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class DataController
{
    static let shared = DataController() // singleton
    let database = Database.database().reference()
    
    static func safeEmail(email: String) -> String {
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
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

