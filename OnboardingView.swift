
import SwiftUI


extension Color {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var opacity: CGFloat = 0
        UIColor(self).getRed(&red, green: &green, blue: &blue, alpha: &opacity)
        return (red, green, blue, opacity)
    }
}


func interpolateColor(from startColor: Color, to endColor: Color, at position: CGFloat) -> Color {
    let t = min(max(position, 0), 1)
    let startComponents = startColor.components
    let endComponents = endColor.components
    
    let interpolatedColor = Color(
        red: (1 - t) * startComponents.red + t * endComponents.red,
        green: (1 - t) * startComponents.green + t * endComponents.green,
        blue: (1 - t) * startComponents.blue + t * endComponents.blue
    )
    
    return interpolatedColor
}

struct OnboardingView: View {
    @Binding var showOnboarding: Bool
    @State private var currentIndex = 0
    private let totalSteps = 3
    private let animationDuration: Double = 0.1 // Increase duration for slower animation

    // Define the gradient colors
    private let startColor = Color(red: 1.0, green: 0.9, blue: 0.7)
    private let endColor = Color(red: 1.0, green: 0.8, blue: 0.5)

    var body: some View {
        ZStack {
            
            LinearGradient(
                gradient: Gradient(colors: [startColor, endColor]),
                startPoint: .top,
                endPoint: .bottom
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                TabView(selection: $currentIndex) {
                    OnboardingStepView(
                        image: "bookshelf", 
                        title: "Explore Unlimited Books",
                        description: "Find your next favorite read"
                    )
                    .tag(0)
                    
                    OnboardingStepView(
                        image: "books", // Replace with your image name
                        title: "One-Click Borrowing",
                        description: "Instantly get your favorite books"
                    )
                    .tag(1)
                    
                    OnboardingStepView(
                        image: "reading", // Replace with your image name
                        title: "Reserve Your Reads",
                        description: "Save books for later pickup"
                    )
                    .tag(2)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Disable default page indicator

                // Page Control
                PageControl(numberOfPages: totalSteps, currentPage: $currentIndex)
                    .padding(.bottom, 20)

                Spacer()

                HStack {
                    if currentIndex == 1 {
                        Button(action: {
                            showOnboarding = false
                        }) {
                            Text("Skip")
                                .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255)).bold()
                                .padding()
                                .frame(width: 120, height: 65)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [startColor, endColor]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    )
                                )
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color(red: 0.4, green: 0.2, blue: 0.1), lineWidth: 2)
                                )
                        }
                        Spacer()
                            .frame(width: 16) // Adjust this width value to reduce/increase padding

                        Button(action: {
                            withAnimation(.easeInOut(duration: animationDuration)) {
                                currentIndex += 1
                            }
                        }) {
                            Text("Next")
                                .foregroundColor(.white)
                                .padding().bold()
                                .frame(width: 180, height: 65)
                                .background(Color(red: 81/255, green: 58/255, blue: 16/255))
                                .cornerRadius(10)
                        }
                    } else {
                        Spacer()
                        Button(action: {
                            withAnimation(.easeInOut(duration: animationDuration)) {
                                if currentIndex < totalSteps - 1 {
                                    currentIndex += 1
                                } else {
                                    showOnboarding = false
                                }
                            }
                        }) {
                            Text(currentIndex < totalSteps - 1 ? "Next" : "Finish")
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 205, height: 65)
                                .background(Color(red: 81/255, green: 58/255, blue: 16/255))
                                .cornerRadius(10)
                        }
                        Spacer()
                    }
                }
                .padding()
            }
        }
    }
}

struct OnboardingStepView: View {
    var image: String
    var title: String
    var description: String
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
            Text(description)
                .font(.subheadline)
                .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
            Spacer()
        }
        .padding()
    }
}

