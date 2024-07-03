//
//  ContentView.swift
//  User UI
//
//  Created by Anay Dubey on 03/07/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            // Background Gradient
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 1.0, green: 0.9, blue: 0.7), Color(red: 1.0, green: 0.8, blue: 0.5)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                // Logo
                Image("AppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 175, height: 175)
                
                // App name and tagline
                Text("Shelves.")
                    .font(.system(size: 48, weight: .heavy)) // Increase font size and make it heavier
                    .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1)) // Dark brown color
                    .padding(.top, 12)
                
                // Tagline with bold 'Borrow'
                (Text("Browse. ")
                    .font(.system(size: 28)) // Increase font size
                    .foregroundColor(.brown)
                + Text("Borrow. ")
                    .font(.system(size: 28)) // Increase font size
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                + Text("Enjoy.")
                    .font(.system(size: 28)) // Increase font size
                    .foregroundColor(.brown))
                .padding(.top, 0)
                
                Spacer()
                
                // Get started button
                Button(action: {
                    // Action for get started button
                }) {
                    Text("Get started")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(red: 0.4, green: 0.2, blue: 0.1))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                }
                .padding(.bottom, 10)
                
                // Log in text
                HStack {
                    Text("Already have an account?")
                        .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                    Button(action: {
                        // Action for log in button
                    }) {
                        Text("Log in")
                            .foregroundColor(Color(red: 0.4, green: 0.2, blue: 0.1))
                            .underline()
                    }
                }
                .padding(.bottom, 20)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
