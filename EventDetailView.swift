import SwiftUI


import SwiftUI

class EventDetailViewModel: ObservableObject {
    @Published var showAlert = false
    @Published var alertMessage = ""

    func registerForMember(eventId: String, newMember: Member) {
        DataController.shared.addMemberToEvent(eventId: eventId, newMember: newMember) { result in
            switch result {
            case .success:
                self.alertMessage = "Successfully registered for the event!"
            case .failure(let error):
                self.alertMessage = "Failed to register: \(error.localizedDescription)"
            }
            self.showAlert = true
        }
    }
}


struct EventDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var showAlert = false
    @State private var alertMessage = ""
    @StateObject private var viewModel = EventDetailViewModel()

    var event: Event
    var newMember: Member? = nil
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Spacer()

                    // Event Cover with Custom Half Circle Background
                    GeometryReader { geometry in
                        ZStack {
                            CustomHalfCircle()
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: geometry.size.width / 16)
                                .frame(width: 280)
                                .offset(y: geometry.size.width / 4)
                                .padding(.horizontal, 35).padding(.top, 20)

                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.clear)
                                .frame(width: geometry.size.width - 100, height: 200)
                                .overlay(
                                    Image(event.imageName) // Using event.imageName directly
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width - 100, height: 200)
                                        .cornerRadius(8)
                                )
                        }
                    }
                    .frame(height: 200)

                    Text(event.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top)
                        .foregroundColor(customColor)

                    Text(event.host)
                        .font(.title2)
                        .foregroundColor(customColor)

                    Text("Shelves Library")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    EventRatingAgeGenreView(event: event)
                        .padding(.vertical, 16)

                    Text("Event Description")
                        .foregroundColor(customColor)
                        .font(.system(size: 24))
                        .bold()

                    Text(event.description)
                        .font(.system(size: 16))
                        .foregroundColor(customColor)

                    Text("Event Hosted By")
                        .foregroundColor(customColor)
                        .font(.system(size: 24))
                        .bold()

                    Text("• \(event.host)")
                        .font(.system(size: 16))
                        .foregroundColor(customColor)

                    Text("Event Address")
                        .foregroundColor(customColor)
                        .font(.system(size: 24))
                        .bold()

                    Text(event.address)
                        .font(.system(size: 16))
                        .foregroundColor(customColor)

                    Text("Number of Users Registered")
                        .foregroundColor(customColor)
                        .font(.system(size: 24))
                        .bold()

                    Text("\(event.registeredMembers.count) Users Registered") // Using registeredMembers count
                        .font(.system(size: 16))
                        .foregroundColor(customColor)

                    Text("Ticket Price")
                        .foregroundColor(customColor)
                        .font(.system(size: 24))
                        .bold()

                    Text("\(event.fees)")
                        .font(.system(size: 16))
                        .foregroundColor(customColor)

                    Text("Event Duration")
                        .foregroundColor(customColor)
                        .font(.system(size: 24))
                        .bold()

                    Text(event.duration) // Using duration property
                        .font(.system(size: 16))
                        .foregroundColor(customColor)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 100)
            }

            VStack {
                Spacer()
                HStack(spacing: 16) {
                    Button(action: {
                        if let userEmail = UserDefaults.standard.string(forKey: "email") {
                        DataController.shared.fetchMemberByEmail(userEmail) { result in
                        switch result {
                            case .success(let member):
                            viewModel.registerForMember(eventId: event.id, newMember: member)
                            print(event.id)
                            case .failure(let error):
                                self.alertMessage = "Failed to fetch member: \(error.localizedDescription)"
                            print(alertMessage)
                                self.showAlert = true
                                }
                            }
                        } else {
                                self.alertMessage = "User email not found."
                                self.showAlert = true
                                }
                           }) {
                        Text("Register")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: 250)
                            .padding()
                            .background(customColor)
                            .cornerRadius(8)
                    }
                }
                .padding()
                .shadow(color: Color.gray.opacity(0.4), radius: 10, x: 0, y: -5)
                .padding(.horizontal)
                .padding(.bottom, 1)
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.87, blue: 0.7), Color.white]),
                           startPoint: .top,
                           endPoint: .bottom))
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Registration"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }

    var customColor: Color {
        colorScheme == .dark ? Color(red: 230/255, green: 230/255, blue: 230/255) : Color(red: 81/255, green: 58/255, blue: 16/255)
    }
}


// Event Rating, Age, and Genre View
struct EventRatingAgeGenreView: View {
    @Environment(\.colorScheme) var colorScheme
    var event: Event

    var body: some View {
        VStack(spacing: 10) {
            Divider().padding(.vertical, 1)

            HStack(spacing: 24) {
                VStack(spacing: 1) {
                    Text("Date")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                        .font(.subheadline)
                        .foregroundColor(customColor)

                    Text("\(event.date, formatter: dateFormatter)") // Using date formatter
                        .font(.subheadline)
                        .foregroundColor(customColor)
                }
                .padding(.horizontal, 1)
                .frame(height: 40)

                Divider()
                    .frame(width: 1, height: 50)
                    .background(Color.gray)

                VStack(spacing: 1) {
                    Text("Time")
                        .font(.subheadline)
                    Text("\(event.time, formatter: timeFormatter)") // Using time formatter
                        .font(.subheadline)
                        .foregroundColor(customColor)
                }
                .padding(.horizontal, 1)
                .frame(height: 40)

                Divider()
                    .frame(width: 1, height: 50)
                    .background(Color.gray)

                VStack(spacing: 1) {
                    Text("\(event.tickets) Tickets Available") // Using tickets property
                        .font(.subheadline)
                        .foregroundColor(customColor)
                }
                .padding(.horizontal, 1)
                .frame(height: 40)
            }

            Divider().padding(.vertical, 1)
        }
    }

    var customColor: Color {
        colorScheme == .dark ? Color(red: 230/255, green: 230/255, blue: 230/255) : Color(red: 81/255, green: 58/255, blue: 16/255)
    }

    // DateFormatter for displaying date
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    // DateFormatter for displaying time
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()
}



// Previews


