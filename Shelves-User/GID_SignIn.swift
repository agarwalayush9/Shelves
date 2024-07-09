//
//  GID_SignIn.swift
//  Shelves-User
//
//  Created by Rajeev Choudhary on 09/07/24.
//

import SwiftUI
import Firebase
import GoogleSignIn

struct GIDSignInView: View {
    var body: some View {
        VStack {
            Button(action: {
                signInWithGoogle()
            }) {
                Text("Sign in with Google")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
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
}

struct GIDSignInView_Previews: PreviewProvider {
    static var previews: some View {
        GIDSignInView()
    }
}
