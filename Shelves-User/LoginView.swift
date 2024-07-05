//
//  LoginView.swift
//  Shelves-User
//
//  Created by Anay Dubey on 04/07/24.
//

import SwiftUI

struct LoginView: View {
    var body: some View {
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
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 1) {
                    Text("Let's")
                        .font(.system(size: 52, weight: .bold))
                        .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    
                    Text("log you in")
                        .font(.system(size: 52, weight: .bold))
                        .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    
                    Text("Welcome")
                        .font(.system(size: 52, weight: .bold))
                        .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    
                    Text("back!")
                        .font(.system(size: 52, weight: .bold))
                        .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
                
                Spacer()
                
                VStack(spacing: 10) {
                    Button(action: {
                        // Action for sign in with Apple button
                    }) {
                        HStack {
                            Image(systemName: "applelogo")
                            Text("Sign in with Apple")
                        }
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.black)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    }
                    
                   NavigationLink(destination: LoginInput()) {
                        HStack {
                            Image(systemName: "envelope.fill")
                            Text("Sign in with Email")
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
                            Image("G")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            Text("Sign-up with Google")
                        }
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.black)
                        .cornerRadius(10)
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

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
