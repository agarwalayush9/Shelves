//
//  AccountView.swift
//  Shelves-User
//
//  Created by Anay Dubey on 14/07/24.
//

import SwiftUI

struct AccountView: View {
    @EnvironmentObject var authManager: AuthManager
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ProfileHeader()
                    
                    PlanInfoCard()
                    
                    VStack(spacing: 0) {
                        NavigationLink(destination: Text("Profile Details View")) {
                            AccountNavigationItem(title: "Your Profile details", icon: "person.fill")
                        }
                        NavigationLink(destination: UpdateSubscriptionView()) {
                            AccountNavigationItem(title: "Change Plan", icon: "star.fill")
                        }
                        NavigationLink(destination: Text("Saved by You View")) {
                            AccountNavigationItem(title: "Saved by You", icon: "bookmark.fill")
                        }
                        NavigationLink(destination: Text("Your Payments View")) {
                            AccountNavigationItem(title: "Your Payments", icon: "creditcard.fill")
                        }
                        NavigationLink(destination: Text("Your Event Bookings View")) {
                            AccountNavigationItem(title: "Your Event Bookings", icon: "book.fill")
                        }
                        NavigationLink(destination: Text("Contact Librarian View")) {
                            AccountNavigationItem(title: "Contact Librarian", icon: "questionmark.circle.fill")
                        }
                        
                        AccountNavigationItem(title: "Logout", icon: "arrow.backward.circle.fill").onTapGesture {
                            authManager.signOut()
                        }
                        
                    }
//                    .padding(.horizontal)
                }
                .padding()
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.87, blue: 0.7), Color.white]),
                               startPoint: .top,
                               endPoint: .bottom)
            )
            .navigationBarHidden(true)
        }
    }
}

struct ProfileHeader: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                VStack(alignment: .leading) {
                    Text("Hi, User")
                        .font(.headline)
                    Text("Manage your account")
                        .font(.subheadline)
                }
                Spacer()
            }
            .padding()

        }
    }
}

struct PlanInfoCard: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Bronze")
                    .font(.title2)
                    .bold()
                Spacer()
                HStack {
                    Image(systemName: "star.circle.fill")
                        .foregroundColor(.purple)
                    Text("Current Plan")
                        .foregroundColor(.brown)
                        .bold()
                }
                .padding(5)
                .background(Color.brown.opacity(0.1))
                .cornerRadius(5)
                .overlay(
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.brown, lineWidth: 2)
                )
            }
            
                Text("""
- Starting Plan offered by Shelve's Library.
- Extended Reading limit is 5.
- Access denied for events.
""")
                    .font(.subheadline)
            
            HStack {
                Text("₹0/month")
                    .font(.title3)
                    .bold()
                Spacer()
               
            }
        }
        .padding()
        .background(Color.brown.opacity(0.1))
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.brown, lineWidth: 3)
        )
    }
}

struct AccountNavigationItem: View {
    var title: String
    var icon: String
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(Color.brown)
                    .frame(width: 40, height: 40)
                Image(systemName: icon)
                    .foregroundColor(.white)
            }
            Text(title)
                .foregroundColor(.brown)
                .padding(.leading, 10)
            Spacer()
            Image(systemName: "chevron.right")
                .foregroundColor(.brown)
        }
        .padding(.horizontal)
        .padding(.vertical, 7)
        .background(Color.clear)
        .cornerRadius(10)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
