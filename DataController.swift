//
//  DataController.swift
//  Shelves-User
//
//  Created by Sahil Raj on 08/07/24.
//

import Foundation
import FirebaseAuth
class DataController
{
    static let shared = DataController() // singleton
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
                            }            }
        }
}
