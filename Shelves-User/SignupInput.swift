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
    @State private var navigateToGenreSelection: Bool = false
    @State private var showAlert = false
    @State private var alertMessage = ""

    var isFormValid: Bool {
        return !firstname.isEmpty &&
               !lastname.isEmpty &&
               !email.isEmpty &&
               !password.isEmpty &&
               !confirmPassword.isEmpty &&
               acceptTerms
    }

    var body: some View {
        NavigationView {
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
                                    .foregroundStyle(Color(red: 81/255, green: 58/255, blue: 16/255))

                                TextField("Your First Name", text: $firstname)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    .frame(width: 165)
                            }

                            VStack(alignment: .leading) {
                                Text("Last Name")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(Color(red: 81/255, green: 58/255, blue: 16/255))

                                TextField("Your Last Name", text: $lastname)
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.gray, lineWidth: 1)
                                    )
                                    .frame(width: 165)
                            }
                        }

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

                        Text("Confirm Password")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))

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
                        
                        // Check if email is already in use
                        DataController.shared.isEmailAlreadyInUse(email: email) { exists in
                            if exists {
                                // Email is already in use, show appropriate alert
                                alertMessage = "Email is already in use by another user"
                                showAlert = true
                            } else {
                                register()
                                //showDialog = true
                            }
                        }
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
                    .disabled(!isFormValid)
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

                if showDialog {
                    Color.black.opacity(0.4)
                        .edgesIgnoringSafeArea(.all)

                    VStack(spacing: 20) {
                        Text("Sign Up Successful")
                            .font(.title)
                            .fontWeight(.semibold)

                        Button(action: {
                            showDialog = false
                            navigateToGenreSelection = true // Navigate to GenreSelectionView
                        }) {
                            Text("Close")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(red: 81/255, green: 58/255, blue: 16/255))
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .frame(height: 200)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(radius: 20)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray.opacity(0.2), lineWidth: 1))
                    .padding(.horizontal, 40)
                }
            }
            .fullScreenCover(isPresented: $navigateToGenreSelection) {
                GenreSelectionView()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Registration"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    func validateAndRegister() -> Bool {
        guard isFormValid else {
            alertMessage = "Please fill in all fields."
            return false
        }

        if !isValidFirstName(firstname) {
            alertMessage = "First name should contain only letters."
            return false
        }

        if !isValidLastName(lastname) {
            alertMessage = "Last name should contain only letters."
            return false
        }

        if !isValidEmail(email) {
            alertMessage = "Please enter a valid email address."
            return false
        }

        if !isValidPassword(password) {
            alertMessage = "Password must be at least 8 characters long and contain both digits and special characters."
            return false
        }

        if password != confirmPassword {
            alertMessage = "Passwords do not match."
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
            }
        }
    }

    // Validation functions
    func isValidFirstName(_ name: String) -> Bool {
        let nameRegex = "^[A-Za-z]+$"
        return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: name)
    }

    func isValidLastName(_ name: String) -> Bool {
        let nameRegex = "^[A-Za-z]+$"
        return NSPredicate(format: "SELF MATCHES %@", nameRegex).evaluate(with: name)
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
