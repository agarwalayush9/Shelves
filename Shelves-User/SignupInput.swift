//
//  SignupInput.swift
//  Shelves-User
//
//  Created by Anay Dubey on 05/07/24.
//

import SwiftUI

struct SignupInput: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var acceptTerms: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                RadialGradient(
                    gradient: Gradient(colors: [Color.orange.opacity(0.6), Color.yellow.opacity(0.3)]),
                    center: .init(x: 0.2, y: 0.3),
                    startRadius: 10,
                    endRadius: 400
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    HStack {
                        Text("Sign Up")
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                            .padding(.leading, 20)
                        Spacer()
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Username")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                        
                        TextField("Enter Your username", text: $username)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        
                        Text("Email ID")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                        
                        TextField("Enter your Email", text: $email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        
                        Text("Password")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                        
                        SecureField("Create your password", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        
                        HStack {
                            Button(action: {
                                acceptTerms.toggle()
                            }) {
                                Image(systemName: acceptTerms ? "checkmark.square.fill" : "square")
                                    .foregroundColor(acceptTerms ? .black : .gray)
                            }
                            
                            Text("I accept the terms and privacy policy")
                                .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                                .font(.system(size: 16))
                        }
                    }
                    .padding(.horizontal, 25)
                    
                    Spacer()
                    
                    Button(action: {
                        // Action for sign up button
                    }) {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.black)
                            .cornerRadius(10)
                            .padding(.horizontal, 15)
                    }
                    .padding(.bottom, 60)
                    
                    Text("by continuing, you agree with")
                        .font(.system(size: 12))
                        .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                        .padding(.bottom, 2)
                    
                    HStack {
                        Text("Terms & Conditions and Privacy Policy")
                            .font(.system(size: 12))
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                            .underline()
                    }
                    .padding(.bottom, 30)
                }
            }
        }
    }
}

struct SignupInput_Previews: PreviewProvider {
    static var previews: some View {
        SignupInput()
    }
}

