import SwiftUI

// Updated Library Event Model
struct LibraryEvent:Identifiable {
    var id = UUID()
    var name: String
    var host: String
    var date: Date
    var time: Date
    var address: String
    var duration: String
    var description: String
    var registeredMembers: String
    var tickets: Int
    var imageName: String // Used for image name directly
    var fees: Int
    var revenue: Int
    var status: String
}

// Main Event Content View
struct EventContentView: View {
    
    @State private var events: [Event] = []
    
    private func fetchEvents() async {
        await DataController.shared.fetchAllEvents { result in
            switch result {
            case .success(let fetchedEvents):
                self.events = fetchedEvents
            case .failure(let error):
                print("Failed to fetch books: \(error.localizedDescription)")
            }
        }
    }


    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                // Header
                VStack(alignment: .leading, spacing: 16) {
                    HStack(alignment: .center, spacing: 15) {
                        VStack(alignment: .leading, spacing: 7) {
                            Text("Library Events")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .bold()
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: 50, height: 10)
                                .background(Color(red: 0.32, green: 0.23, blue: 0.06))
                        }
                        Spacer()
                        NavigationLink(destination: ContentView()) {
                            Image(systemName: "calendar.badge.clock")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.top)
                }
                .padding(.horizontal)

                // Search Bar
                ZStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.brown)
                            .padding(.leading, 10)

                        TextField("Search Library Events", text: .constant(""))
                            .foregroundColor(.primary)
                            .padding(10)
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.brown, lineWidth: 2))
                }
                .padding(.horizontal)

                ScrollView {
                    // Your Event's Tickets
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Your Event’s Tickets")
                                .font(.headline)
                            Spacer()
                            Text("See All").foregroundColor(.blue)
                        }
                        .padding(.top)
                        .padding(.horizontal)

                        EventTicketView()
                    }

                    // Event Categories
                    VStack(alignment: .leading) {
                        HStack {
                            Text("Event Categories").font(.headline)
                        }
                        .padding(.horizontal)

                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(events) { event in
                                EventCategoryView(event: event)
                            }
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top)
                }
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.87, blue: 0.7), Color.white]),
                               startPoint: .top,
                               endPoint: .bottom)
            )
            .navigationBarHidden(true)
            .onAppear()
            {
                Task {
                    await fetchEvents()
                }

            }
        }
    }
}

// Event Ticket View
struct EventTicketView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(systemName: "book.pages")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                        .padding(.trailing)
                    VStack(alignment: .leading, spacing: 5) {
                        Text("California Art Festival 2023").font(.headline)
                        Text("Dana Point 29-30").font(.subheadline)
                    }
                    Spacer()
                }
                .padding(.bottom, 4)

                DottedDivider()
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .foregroundColor(.brown)
                    .frame(height: 1)
                    .padding(.vertical, 4)

                HStack {
                    VStack(alignment: .leading) {
                        Text("Time").font(.caption)
                        Text("10:00 PM").font(.subheadline)
                    }
                    Spacer()
                    VStack(alignment: .leading) {
                        Text("Location").font(.caption)
                        Text("California, CA").font(.subheadline)
                    }
                }
            }
            .padding()
            .cornerRadius(15)
            .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.brown, lineWidth: 2))
        }
        .padding(.horizontal)
    }
}

// Event Category View
struct EventCategoryView: View {
    var event: Event

    var body: some View {
        NavigationLink(destination: EventDetailView(event: event)) {
            VStack {
                Image(event.imageName) // Use imageName directly
                    .resizable()
                    .frame(width: 150, height: 150)
                    .cornerRadius(8)
                Text(event.name)
                    .font(.subheadline)
                    .bold()
                    .padding(.top, 4)
                Text("Date: \(event.date, formatter: dateFormatter)")
                Text("\(event.tickets) tickets available")
            }
            .foregroundColor(.brown)
            .bold()
        }
    }

    // DateFormatter for displaying date
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
}

struct DottedDivider: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

#Preview{
    EventContentView()
}
