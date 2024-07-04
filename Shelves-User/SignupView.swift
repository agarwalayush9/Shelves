//
//  SigninView.swift
//  Shelves-User
//
//  Created by Anay Dubey on 04/07/24.
//

import SwiftUI

struct SignupView: View {
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
                
                VStack(alignment: .leading, spacing: 1) {
                    Text("Let's sign")
                        .font(.system(size: 52, weight: .bold))
                        .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    
                    Text("up and")
                        .font(.system(size: 52, weight: .bold))
                        .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    
                    Text("borrow")
                        .font(.system(size: 52, weight: .bold))
                        .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    
                    Text("books")
                        .font(.system(size: 52, weight: .bold))
                        .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                
                Spacer()
                
                VStack(spacing: 10) {
                    Button(action: {
                        // Action for sign in with Google button
                    }) {
                        HStack {
                            Image(systemName: "applelogo")
                            Text("Sign-up with Apple")
                        }
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    }
                    
                    Button(action: {
                        // Action for sign in with mobile number button
                    }) {
                        HStack {
                            Image(systemName: "phone.fill")
                            Text("Sign-up with Mobile Number")
                        }
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color(red: 81/255, green: 58/255, blue: 16/255))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    }
                    
                    Button(action: {
                        // Action for sign in with email button
                    }) {
                        HStack {
                            Image(systemName: "envelope.fill")
                            Text("Sign-up with Email")
                        }
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(red: 81/255, green: 58/255, blue: 16/255), lineWidth: 2)
                        )
                        .padding(.horizontal, 20)
                    }
                }
                
                Spacer()
                
                Text("By continuing, you agree with")
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    .padding(.bottom, 2)
                
                HStack {
                    Text("Terms & Conditions and Privacy Policy")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                        .underline()
                }
                .padding(.bottom, 20)
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
