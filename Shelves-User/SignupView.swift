//
//  SigninView.swift
//  Shelves-User
//
//  Created by Rajeev Choudhary on 08/07/24.
//

import SwiftUI
import GoogleSignIn
import Firebase

struct SignupView: View {
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
                    
                    NavigationLink(destination: SignupInput()) {
                        HStack {
                            Image(systemName: "envelope.fill")
                            Text("Sign-up with Email")
                        }
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color(red: 81/255, green: 58/255, blue: 16/255))
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    }
                    
                    Button(action: {
                        signInWithGoogle()
                    }) {
                        HStack {
                            Image("G")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            Text("Sign up with Google")
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

func signInWithGoogle() {
    guard let clientID = FirebaseApp.app()?.options.clientID else { return }
    
    let config = GIDConfiguration(clientID: clientID)
    
    guard let presentingViewController = UIApplication.shared.windows.first?.rootViewController else {
        return
    }
    
    GIDSignIn.sharedInstance.configuration = config
    
    GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { signResult, error in
        if let error = error {
            // Handle the error if any
            print("Error signing in: \(error.localizedDescription)")
            return
        }
        
        guard let user = signResult?.user,
              let idToken = user.idToken else { return }
        
        let accessToken = user.accessToken
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString, accessToken: accessToken.tokenString)
        
        // Use the credential to authenticate with Firebase
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                // Handle the error if any
                print("Error authenticating with Firebase: \(error.localizedDescription)")
                return
            }
            
            // User is signed in
            print("User is signed in")
            // Handle post-sign-in logic here
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
