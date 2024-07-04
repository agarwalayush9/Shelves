import SwiftUI

struct ContentView: View {
    @State private var showOnboarding = true
    
    var body: some View {
        if showOnboarding {
            OnboardingView(showOnboarding: $showOnboarding)
        } else {
            MainContentView()
        }
    }
}

struct MainContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 1.0, green: 0.9, blue: 0.7), Color(red: 1.0, green: 0.8, blue: 0.5)]),
                    startPoint: .top,
                    endPoint: .bottom
                )                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Spacer()
                    
                    // Logo
                    Image("App Logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 175, height: 175)
                    
                    // App name and tagline
                    Text("Shelves.")
                        .font(.system(size: 48, weight: .heavy))
                        .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                        .padding(.top, 12)
                    
                    (Text("Browse. ")
                        .font(.system(size: 28))
                        .foregroundColor(.brown)
                    + Text("Borrow. ")
                        .font(.system(size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    + Text("Enjoy.")
                        .font(.system(size: 28))
                        .foregroundColor(.brown))
                    .padding(.top, 0)
                    
                    Spacer()
                    
                    // Get started button
                    NavigationLink(destination: SignupView()) {
                        Text("Get started")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(red: 81/255, green: 58/255, blue: 16/255))
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 10)
                    
                    // Log in text
                    HStack {
                        Text("Already have an account?")
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                        NavigationLink(destination: LoginView()) {
                            Text("Log in")
                                .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                                .underline()
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
