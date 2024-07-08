import SwiftUI
import FirebaseAuth

struct LoginInput: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showUserHomePage: Bool = false

    var isFormValid: Bool {
        return !email.isEmpty && !password.isEmpty
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
                            .font(.system(size: 60, weight: .bold)) // Adjusted size for better adaptability
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                            .padding(.leading, 20)
                        Spacer()
                    }
                    .padding(.top, 40) // Adjusted top padding
                    
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
                        
                        Text("Password")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                        
                        SecureField("Enter Your password", text: $password)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
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
            .fullScreenCover(isPresented: $showUserHomePage) {
                UserHomePage()
            }
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { firebaseResult, error in
            if error != nil {
                print("Invalid Password")
            } else {
                // Handle successful login
                self.showUserHomePage = true
                print("Login success")
            }
        }
    }
}

struct LoginInput_Previews: PreviewProvider {
    static var previews: some View {
        LoginInput()
    }
}
