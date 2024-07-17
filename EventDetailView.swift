//
//  EventDetailView.swift
//  Shelves-User
//
//  Created by Suraj Singh on 11/07/24.
//

import SwiftUI

struct EventDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var randomColor: Color = Color.random()

    var title: String
    var host: String
    var location: String
    var eventDuration = "2hr 30 min"
    
    var body: some View {
        
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Spacer() // Push content to the top

                    // Event Cover with Custom Half Circle Background
                    GeometryReader { geometry in
                        ZStack {
                            CustomHalfCircle()
                                .fill(.gray).opacity(0.5)
                                .frame(height: geometry.size.width / 16)
                                .frame(width: 280)
                                .offset(y: geometry.size.width / 4)
                                .padding(.horizontal, 35).padding(.top,20) // Adjust the offset to position the half-circle correctly

                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.clear)
                                .frame(width: geometry.size.width - 100, height: 200) // Adjust width if necessary
                                .overlay(
                                    Image("eventCover")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width - 100, height: 200)
                                        .cornerRadius(8)
                                )
                        }
                    }
                    .frame(height: 200) // Adjust the height to match the image height
                    
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold).padding(.top)
                        .foregroundColor(customColor)

                    Text(host)
                        .font(.title2)
                        .foregroundColor(customColor)

                    Text(location)
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    EventRatingAgeGenreView()
                        .padding(.vertical, 16)

                    Text("Event Description")
                        .foregroundColor(customColor)
                        .font(.system(size: 24))
                        .bold()

                    Text("""
                        The California Art Festival 2023 is a premier event showcasing the best in contemporary art. Join us for a weekend of exhibitions, workshops, and live performances.
                        """)
                        .font(.system(size: 16))
                        .foregroundColor(customColor)

                    Text("Event Hosted By")
                        .foregroundColor(customColor)
                        .font(.system(size: 24))
                        .bold()

                    Text("""
                        • Ak Roy
                        """)
                        .font(.system(size: 16))
                        .foregroundColor(customColor)

                    Text("Event Adress")
                        .foregroundColor(customColor)
                        .font(.system(size: 24))
                        .bold()

                    Text("""
                        234,4th street, Noida, Xyz
                        """)
                        .font(.system(size: 16))
                        .foregroundColor(customColor)
                    
                    Text("Number of User registered")
                        .foregroundColor(customColor)
                        .font(.system(size: 24))
                        .bold()

                    Text("""
                        67 User Registered
                        """)
                        .font(.system(size: 16))
                        .foregroundColor(customColor)
                    Text("Ticket Price")
                        .foregroundColor(customColor)
                        .font(.system(size: 24))
                        .bold()

                    Text("""
                        Rs 499 only
                        """)
                        .font(.system(size: 16))
                        .foregroundColor(customColor)
                    Text("Event Duration")
                        .foregroundColor(customColor)
                        .font(.system(size: 24))
                        .bold()
                    Text("""
                        \(eventDuration)
                        """)
                        .font(.system(size: 16))
                        .foregroundColor(customColor)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 100) // Add padding to the bottom to avoid content being hidden behind the buttons
            }

            VStack {
                Spacer()
                HStack(spacing: 16) {
                    Button(action: {
                        // Buy Tickets action
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
                .padding(.bottom, 1) // Add bottom padding to keep buttons above bottom edge
            }
        }.background(
            LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.87, blue: 0.7), Color.white]),
                           startPoint: .top,
                           endPoint: .bottom))
    }

    var customColor: Color {
        colorScheme == .dark ? Color(red: 230/255, green: 230/255, blue: 230/255) : Color(red: 81/255, green: 58/255, blue: 16/255)
    }
}


struct EventThumbnailView: View {
    var title: String
    var host: String
    var location: String
    var imageName: String // Add imageName parameter

    var body: some View {
        VStack(alignment: .leading) {
            Image(imageName) // Use imageName parameter here
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120, height: 180)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .lineLimit(2)
                
                Text(host)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                Text(location)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
        .frame(width: 140)
    }
}




struct EventRatingAgeGenreView: View {
    @Environment(\.colorScheme) var colorScheme
    let rating: Double = 4.8 // Example rating value, you can replace this with your actual rating

    var body: some View {
        VStack(spacing: 10) {
            Divider().padding(.vertical, 1)

            HStack(spacing: 24) {
                VStack(spacing: 1) {
                    Text("Date")
                        .multilineTextAlignment(.center).padding(.horizontal,38)
                        .font(.subheadline)
                        .foregroundColor(customColor)
                        .frame(maxWidth: .infinity, alignment: .leading) // Ensure the text spans full width
                        .layoutPriority(1) // Give this text higher priority to prevent truncation

                    Text("12.07.24") // Display rating with one decimal place
                        .font(.subheadline)
                        .foregroundColor(customColor)

                }
                .padding(.horizontal, 1)
                .frame(height: 40) // Ensure the VStack height is 50 points

                Divider()
                    .frame(width: 1, height: 50)
                    .background(Color.gray)

                VStack(spacing: 1) {
                    Text("Time")
                        .font(.subheadline)
                    Text("10:00 am")
                        .font(.subheadline)
                        .foregroundColor(customColor)
                }
                .padding(.horizontal, 1)
                .frame(height: 40) // Ensure the VStack height is 50 points

                Divider()
                    .frame(width: 1, height: 50)
                    .background(Color.gray)

                VStack(spacing: 1) {
                    Text(" 200 Ticket Avaliable")
                        .font(.subheadline)
                        .foregroundColor(customColor)
                    
                    
                }
                .padding(.horizontal, 1)
                .frame(height: 40) // Ensure the VStack height is 50 points
            }

            Divider().padding(.vertical, 1)
        }
    }

    var customColor: Color {
        colorScheme == .dark ? Color(red: 230/255, green: 230/255, blue: 230/255) : Color(red: 81/255, green: 58/255, blue: 16/255)
    }
}

#Preview{
    EventDetailView(title: "Book event", host: "Ak Roy", location: "Shelves library")
}
