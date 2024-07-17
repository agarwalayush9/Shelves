//
//  SignupInput.swift
//  Shelves-User
//
//  Created by Anay Dubey on 04/07/24.
//

import SwiftUI
import FirebaseAuth

struct SignupInput: View {
    @State private var firstname: String = ""
    @State private var lastname: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var acceptTerms: Bool = false
    @State private var showDialog: Bool = false
    @State private var showGenreSelection: Bool = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var firstnameError: String = ""
    @State private var lastnameError: String = ""
    @State private var emailError: String = ""
    @State private var passwordError: String = ""
    @State private var confirmPasswordError: String = ""

    var isFormValid: Bool {
        return !email.isEmpty && !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword &&
        password.count >= 8 &&
        acceptTerms
    }

    var body: some View {
        NavigationStack {
            ZStack {
                RadialGradient(
                    gradient: Gradient(colors: [Color.orange.opacity(0.6), Color.yellow.opacity(0.3)]),
                    center: .init(x: 0.2, y: 0.3),
                    startRadius: 10,
                    endRadius: 400
                )
                .edgesIgnoringSafeArea(.all)
                .blur(radius: showDialog ? 10 : 0)

                VStack {
                    HStack {
                        Text("Sign Up")
                            .font(.system(size: 60, weight: .bold))
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                            .padding(.leading, 20)
                        Spacer()
                    }
                    .padding(.top, 40)

                    Spacer()

                    VStack(alignment: .leading, spacing: 15) {

                        HStack {
                            VStack(alignment: .leading) {
                                Text("First Name")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))

                                TextField("Your First Name", text: $firstname)
                                    .onChange(of: firstname) { newValue in
                                        firstnameError = ""
                                        if newValue.isEmpty {
                                            firstnameError = "First name is required."
                                        } else if !isValidFirstName(newValue) {
                                            firstnameError = "First name should contain only letters."
                                        }
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    .frame(width: 165)
                            }
                            if !firstnameError.isEmpty {
                                Text(firstnameError)
                                    .font(.system(size: 12))
                                    .foregroundColor(.red)
                            }

                            VStack(alignment: .leading) {
                                Text("Last Name")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))

                                TextField("Your Last Name", text: $lastname)
                                    .onChange(of: lastname) { newValue in
                                        lastnameError = ""
                                        if newValue.isEmpty {
                                            lastnameError = "Last name is required."
                                        } else if !isValidLastName(newValue) {
                                            lastnameError = "Last name should contain only letters."
                                        }
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    .frame(width: 165)
                            }
                            if !lastnameError.isEmpty {
                                Text(lastnameError)
                                    .font(.system(size: 12))
                                    .foregroundColor(.red)
                            }
                        }

                        Text("Email ID")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))

                        TextField("Enter your Email", text: $email)
                            .onChange(of: email) { newValue in
                                emailError = ""
                                if !newValue.isEmpty && !isValidEmail(newValue) {
                                    emailError = "Please enter a valid email address."
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        if !emailError.isEmpty {
                            Text(emailError)
                                .font(.system(size: 12))
                                .foregroundColor(.red)
                        }

                        Text("Password")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))

                        SecureField("Create your password", text: $password)
                            .onChange(of: password) { newValue in
                                passwordError = ""
                                if !newValue.isEmpty && !isValidPassword(newValue) {
                                    passwordError = "Password must be at least 8 characters long and contain both digits and special characters."
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )

                        SecureField("Confirm your password", text: $confirmPassword)
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
                        guard validateAndRegister() else {
                            showAlert = true
                            return
                        }
                        
                         //Check if email is already in use
                        DataController.shared.isEmailAlreadyInUse(email: email) { exists in
                            if exists {
                                
                                alertMessage = "Email is already in use by another user"
                                showAlert = true
                            } else {
                                register()
                                
                                
                            }}
                    }) {
                        Text("Sign Up")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(isFormValid ? Color.black : Color.gray)
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
            
//            NavigationLink(destination: GenreSelectionView(), isActive: $showGenreSelection)
//            {
//                EmptyView()
//            }.navigationBarBackButtonHidden()
            .fullScreenCover(isPresented: $showGenreSelection) {
                            GenreSelectionView()
                        
                        }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Registration"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func validateAndRegister() -> Bool {
        firstnameError = ""
        lastnameError = ""
        emailError = ""
        passwordError = ""
        confirmPasswordError = ""

        guard isFormValid else {
            alertMessage = "Please fill in all fields and accept terms."
            return false
        }

        if !isValidFirstName(firstname) {
            firstnameError = "First name should contain only letters."
            return false
        }

        if !isValidLastName(lastname) {
            lastnameError = "Last name should contain only letters."
            return false
        }

        if !isValidEmail(email) {
            emailError = "Please enter a valid email address."
            return false
        }

        if !isValidPassword(password) {
            passwordError = "Password must be at least 8 characters long and contain both digits and special characters."
            return false
        }

        if password != confirmPassword {
            confirmPasswordError = "Passwords do not match."
            return false
        }

        return true
    }

    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { (authResult, error) in
            if let error = error {
                print("Error signing up: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    showAlert = true
                    alertMessage = "Failed to register user. \(error.localizedDescription)"
                }
            } else {
                print("User signed up successfully")
                
                // Save member details to database
                let newMember = Member(email: email,
                                       firstName: firstname, // You can add first name if available
                                       lastName: lastname, // You can add last name if available
                                       phoneNumber: 0, // You can add phone number if available
                                       subscriptionPlan: "bronze",
                                       registeredEvents: [], genre: [])// Empty array for default events
                   
                
                DataController.shared.addMember(newMember) { result in
                    switch result {
                    case .success:
                        print("Member details saved to database.")
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        UserDefaults.standard.set(email, forKey: "email")
                        showGenreSelection = true // Assuming this flag is used to proceed to genre selection
                    case .failure(let error):
                        print("Failed to save member details to database: \(error.localizedDescription)")
                        DispatchQueue.main.async {
                            showAlert = true
                            alertMessage = "Failed to save member details to database."
                        }
                        // Optionally, handle retry or other UI logic here
                    }
                }
            }
        }
    }


    // Validation functions
    func isValidFirstName(_ name: String) -> Bool {
        let nameRegex = "^[A-Za-z]+$"
        return !name.isEmpty && NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: name)
    }

    func isValidLastName(_ name: String) -> Bool {
        let nameRegex = "^[A-Za-z]+$"
        return !name.isEmpty && NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: name)
    }

    func isValidEmail(_ email: String) -> Bool {
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegex = "^(?=.{1,64}@.{4,64}$)(?=.{6,100}$)[A-Za-z0-9](?:[A-Za-z0-9._%+-]*[A-Za-z0-9])?@[A-Za-z0-9](?:[A-Za-z0-9.-]*[A-Za-z0-9])?\\.[A-Za-z]{2,64}$"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: trimmedEmail)
    }

    func isValidPassword(_ password: String) -> Bool {
        let passwordRegex = "^(?=.*[0-9])(?=.*[!@#$%^&*])[a-zA-Z0-9!@#$%^&*]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
}

struct SignupInput_Previews: PreviewProvider {
    static var previews: some View {
        SignupInput()
    }
}
