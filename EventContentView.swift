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
    let events = [
        LibraryEvent(name: "California Art Festival 2023", host: "Art Society", date: Date(), time: Date(), address: "234, 4th Street, Noida, Xyz", duration: "2hr 30 min", description: "A premier event showcasing contemporary art.", registeredMembers: "123 members registered", tickets: 100, imageName: "authormeet", fees: 499, revenue: 0, status: "Open"),
        LibraryEvent(name: "Music Concert", host: "Music Club", date: Date(), time: Date(), address: "123 Music Ave, Noida", duration: "3hr", description: "Join us for an unforgettable night.", registeredMembers: "123 members registered", tickets: 50, imageName: "musicconcert", fees: 399, revenue: 0, status: "Open"),
        LibraryEvent(name: "Book Reading Event", host: "Literary Society", date: Date(), time: Date(), address: "456 Reader St, Noida", duration: "1hr", description: "An evening with local authors.", registeredMembers: "123 members registered", tickets: 75, imageName: "bookreading", fees: 200, revenue: 0, status: "Open"),
        LibraryEvent(name: "Tech Talk", host: "Tech Innovators", date: Date(), time: Date(), address: "789 Tech Blvd, Noida", duration: "2hr", description: "Discussion on emerging technologies.", registeredMembers: "123 members registered", tickets: 30, imageName: "techtalk", fees: 350, revenue: 0, status: "Open"),
        LibraryEvent(name: "Art Workshop", host: "Art Academy", date: Date(), time: Date(), address: "321 Art Lane, Noida", duration: "4hr", description: "Hands-on workshop for budding artists.", registeredMembers: "123 members registered", tickets: 20, imageName: "artworkshop", fees: 700, revenue: 0, status: "Open"),
        LibraryEvent(name: "Children's Story Hour", host: "Library Staff", date: Date(), time: Date(), address: "111 Library St, Noida", duration: "1hr", description: "Stories and fun activities for kids.", registeredMembers: "123 members registered", tickets: 50, imageName: "storyhour", fees: 0, revenue: 0, status: "Open"),
        LibraryEvent(name: "Film Screening", host: "Cinema Club", date: Date(), time: Date(), address: "222 Film Ave, Noida", duration: "2hr", description: "Screening of classic films.", registeredMembers: "123 members registered", tickets: 40, imageName: "film", fees: 300, revenue: 0, status: "Open"),
    ]

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
    var event: LibraryEvent

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
