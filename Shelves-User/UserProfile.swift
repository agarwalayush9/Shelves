//
//  UserProfile.swift
//  Shelves-User
//
//  Created by Jhanvi Jindal on 08/07/24.
//

import Foundation
import SwiftUI

struct UserProfile: View {
    var body: some View {
        NavigationView {
            VStack {
                ProfileHeader()
                ProfileOptions()
                Spacer()
                HelpButton()
            }
            .navigationTitle("Account")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}
struct ProfileHeader: View {
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .padding()
            
            VStack(alignment: .leading) {
                Text("Jhanvi Jindal")
                    .font(.headline)
                Text("An Avid Reader")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            BadgeView()
                .padding()
        }
    }
}

struct BadgeView: View {
    var body: some View {
        HStack {
            Image(systemName: "star.fill")
                .foregroundColor(.white)
                .padding(3)
                .background(Color.bronze)
                .clipShape(Circle())
            
            Text("Bronze")
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding(10)
        .background(Color.bronze)
        .clipShape(Capsule())
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.black, lineWidth: 3)
                .frame(width: 100)
        )
    }
}

extension Color {
    static let bronze = Color(red: 205 / 255, green: 127 / 255, blue: 50 / 255)
}

struct ProfileOptions: View {
    var body: some View {
        List {
            NavigationLink(destination: Text("Profile Details View")) {
                OptionRow(icon: "person.crop.circle", text: "Profile details")
            }
            NavigationLink(destination: Text("Payment View")) {
                OptionRow(icon: "creditcard", text: "Payment")
            }
            NavigationLink(destination: Text("Subscription View")) {
                OptionRow(icon: "star", text: "Subscription")
            }
            NavigationLink(destination: Text("FAQs View")) {
                OptionRow(icon: "questionmark.circle", text: "FAQs")
            }
            NavigationLink(destination: Text("Logout View")) {
                OptionRow(icon: "arrowshape.turn.up.left", text: "Logout")
            }
        }
        .listStyle(GroupedListStyle())
    }
}

struct OptionRow: View {
    var icon: String
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.gray)
            Text(text)
                .foregroundColor(.black)
        }
        .padding()
    }
}
struct HelpButton: View {
    var body: some View {
        Button(action: {
            // Help action here
        }) {
            HStack {
                Image(systemName: "headphones")
                Text("Feel free to ask, We are here to help")
                    .font(.footnote)
            }
            .padding()
            .foregroundColor(.white)
            .background(.brown)
            .cornerRadius(8)
        }
        .padding(.bottom, 20)
    }
}

extension Color {
    static let brown = Color(red: 101 / 255, green: 67 / 255, blue: 33 / 255)
}


struct ContentView:View {
     var body: some View{
        NavigationView{
            VStack{
                ProfileHeader()
                ProfileOptions()
                Spacer()
                HelpButton()
            }
            
            .navigationTitle("Account")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
#Preview(){
    UserProfile()
}
