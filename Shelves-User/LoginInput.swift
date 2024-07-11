//
//  LoginInput.swift
//  Shelves-User
//
//  Created by Anay Dubey on 05/07/24.
//

import SwiftUI
import FirebaseAuth

struct LoginInput: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showUserHomePage: Bool = false
    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var showForgotPassword: Bool = false

    // Validation state
    @State private var isEmailValid: Bool = true
    @State private var isPasswordValid: Bool = true

    var isFormValid: Bool {
        return isEmailValid && isPasswordValid && !email.isEmpty && !password.isEmpty
    }

    var body: some View {
        NavigationStack {
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
                        Text("Sign In")
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                            .padding(.leading, 20)
                        Spacer()
                    }
                    .padding(.top, 40)
                    
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Email")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                        
                        TextField("Enter Your email", text: $email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(isEmailValid ? Color.gray : Color.red, lineWidth: 1)
                            )
                            .onChange(of: email) { newValue in
                                validateEmail()
                            }
                        
                        if !isEmailValid {
                            Text("Invalid email format.")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        
                        Text("Password")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                        
                        SecureField("Enter Your password", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(isPasswordValid ? Color.gray : Color.red, lineWidth: 1)
                            )
                            .onChange(of: password) { newValue in
                                validatePassword()
                            }
                        
                        if !isPasswordValid {
                            Text("Password must be at least 8 characters, with 1 uppercase, 1 lowercase, 1 number, and 1 special character.")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    .padding(.horizontal, 25)
                    
                    Spacer()
                    
                    Button(action: {
                        login()
                    }) {
                        Text("Sign In")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isFormValid ? Color.black : Color.gray)
                            .cornerRadius(10)
                            .padding(.horizontal, 15)
                    }
                    .disabled(!isFormValid)
                    .padding(.bottom, 10)

                    Button(action: {
                        showForgotPassword.toggle()
                    }) {
                        Text("Forgot Password?")
                            .font(.system(size: 16))
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    }
                    .padding(.bottom, 60)
                    .sheet(isPresented: $showForgotPassword) {
                        ForgotPasswordView()
                    }
                    
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
                    .padding(.bottom, 30)
                }
            }
            .fullScreenCover(isPresented: $showUserHomePage) {
                UserHomePage()
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Login Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }
    }

    struct ForgotPasswordView: View {
        @State private var email: String = ""
        @State private var message: String = ""
        @State private var showingAlert = false
        @Environment(\.dismiss) private var dismiss
            
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
                    .navigationBarBackButtonHidden(true)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button {
                                print("P/w forgot cancelled")
                                // 2
                                dismiss()

                            } label: {
                                HStack {
                                    Image(systemName: "chevron.backward")
                                    Text("Back")
                                }
                            }
                        }
                    }
                    VStack {
                        HStack {
                            Text("Forgot Password")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                                .padding(.leading, 20)
                            Spacer()
                        }
                        .padding(.top, 40)
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 15) {
                            Text("Email")
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                            
                            TextField("Enter Your email", text: $email)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 1)
                                )
                            
                            Text(message)
                                .foregroundColor(.red)
                                .padding()
                                .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal, 25)
                        
                        Spacer()
                        
                        Button(action: sendPasswordReset) {
                            Text("Send Password Reset Email")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 81/255, green: 58/255, blue: 16/255))
                                .cornerRadius(10)
                                .padding(.horizontal, 15)
                        }
                        .padding(.bottom, 10)
                    }
                }
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Password Reset"), message: Text(message), dismissButton: .default(Text("OK")))
                }
            }
        }

        func sendPasswordReset() {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    self.message = error.localizedDescription
                } else {
                    self.message = "A password reset email has been sent to \(email)."
                }
                self.showingAlert = true
            }
        }
    }

    struct ForgotPasswordView_Previews: PreviewProvider {
        static var previews: some View {
            ForgotPasswordView()
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if let error = error {
                self.alertMessage = error.localizedDescription
                self.showAlert = true
                print("Login error: \(error.localizedDescription)")
            } else {
                // Handle successful login
                self.showUserHomePage = true
                print("Login success")
            }
        }
    }

    private func validateEmail() {
        isEmailValid = isValidEmail(email)
    }

    private func validatePassword() {
        let passwordRegex = [
            ("^(?=.*[A-Z]).{1,}$", "At least 1 uppercase letter"),
            ("^(?=.*[a-z]).{1,}$", "At least 1 lowercase letter"),
            ("^(?=.*\\d).{1,}$", "At least 1 number"),
            ("^(?=.*[#$^+=!*()@%&]).{1,}$", "At least 1 special character"),
            (".{8,}", "Minimum 8 characters")
        ]

        for (regex, _) in passwordRegex {
            let pred = NSPredicate(format: "SELF MATCHES %@", regex)
            isPasswordValid = pred.evaluate(with: password)
            if !isPasswordValid {
                break
            }
        }
    }

    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

struct LoginInput_Previews: PreviewProvider {
    static var previews: some View {
        LoginInput()
    }
}
