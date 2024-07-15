import SwiftUI

struct EventContentView: View {
    var body: some View {
        
            VStack(alignment: .leading, spacing: 20) {
                // Header
                HStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("Hi, User")
                            .font(.headline)
                        Text("Find your Favourite Events")
                            .font(.subheadline)
                    }
                    Spacer()
                }
                .padding()

                // Search Bar
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search for events", text: .constant(""))
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)
                ScrollView {
                // Your Event's Tickets
                VStack(alignment: .leading) {
                    HStack {
                        Text("Your Event’s Tickets")
                            .font(.headline)
                        Spacer()
                        Text("See All")
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal)

                    EventTicketView()
                }

                // Event Categories
                VStack(alignment: .leading) {
                    HStack {
                        Text("Event Categories")
                            .font(.headline)
                        Spacer()
                        Text("See All")
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            ForEach(0..<3) { _ in
                                EventCategoryView()
                            }
                        }
                        .padding(.horizontal)
                    }
                }

                // Event Nearby
                VStack(alignment: .leading) {
                    HStack {
                        Text("Event Nearby")
                            .font(.headline)
                        Spacer()
                        Text("See All")
                            .foregroundColor(.blue)
                    }
                    .padding(.horizontal)

                    ForEach(0..<2) { _ in
                        EventNearbyView()
                    }
                }
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

struct EventTicketView: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "books.vertical.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("California Art Festival 2023")
                        .font(.headline)
                    Text("Dana Point 29-30")
                        .font(.subheadline)
                }
                Spacer()
            }
            .padding(.bottom, 10)
            
            Divider()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Time")
                        .font(.caption)
                    Text("10:00 PM")
                        .font(.headline)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Location")
                        .font(.caption)
                    Text("California, CA")
                        .font(.headline)
                }
                Spacer()
                Text("Premium ticket x1")
                    .padding(5)
                    .background(Color.brown)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .padding(.horizontal)
    }
}

struct EventCategoryView: View {
    var body: some View {
        VStack {
            Image(systemName: "person.3.fill")
                .resizable()
                .frame(width: 100, height: 100)
            Text("Author's Meet")
                .font(.caption)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct EventNearbyView: View {
    var body: some View {
        HStack {
            Image(systemName: "book.fill")
                .resizable()
                .frame(width: 50, height: 50)
            VStack(alignment: .leading) {
                Text("California Art Festival 2023")
                    .font(.headline)
                Text("Dana Point 29-30")
                    .font(.subheadline)
                HStack {
                    Text("July 31, 07:30 PM")
                    Spacer()
                    Text("₹299")
                        .foregroundColor(.green)
                }
                .font(.caption)
            }
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

struct EventContentView_Previews: PreviewProvider {
    static var previews: some View {
        EventContentView()
    }
}


