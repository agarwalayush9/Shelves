//
//  AppDelegate.swift
//  Shelves-User
//
//  Created by Rajeev Choudhary on 09/07/24.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
      
      @available(iOS 17.0, *)
          func application(_ application: UIApplication, open url: URL,
                           options: [UIApplication.OpenURLOptionsKey: Any])
            -> Bool {
            return GIDSignIn.sharedInstance.handle(url)
          }
    return true
  }
}

@main
struct Shelves_UserApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            
            ContentView()
        }
    }
}
