//
//  CustomBookView.swift
//  Shelves-User
//
//  Created by Suraj Singh on 11/07/24.
//

import SwiftUI

struct CustomBookDetailView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var randomColor: Color = Color.random()

    var title: String
    var author: String
    var subtitle: String
    var url:String
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 10) {
                    Spacer() // Push content to the top

                    // Book Cover with Custom Half Circle Background
                    GeometryReader { geometry in
                        ZStack {
                            CustomHalfCircle()
                                .fill(.gray).opacity(0.5)
                                .frame(height: geometry.size.width / 16)
                                .frame(width: 280)
                                .offset(y: geometry.size.width / 4)
                                .padding(.horizontal, 35).padding(.top,20) // Adjust the offset to position the half-circle correctly

                            if let url = URL(string: url) {
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(width: geometry.size.width - 100, height: 200)
                                    .background(
                                        
                                        AsyncImage(url: url) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                                    .frame(width: 100, height: 150)
                                                    .cornerRadius(10)
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: geometry.size.width - 100, height: 200)
                                                    .cornerRadius(8)
                                            case .failure:
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: geometry.size.width - 100, height: 200)
                                                    .cornerRadius(8)
                                            @unknown default:
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: geometry.size.width - 100, height: 200)
                                                    .cornerRadius(8)
                                            }
                                        }
                                        
                                          
                                    )}
                        }
                    }
                    .frame(height: 200) // Adjust the height to match the image height
                    
                    Text(title)
                        .font(.title)
                        .fontWeight(.bold).padding(.top,0)
                        .foregroundColor(customColor)

                    Text(author)
                        .font(.title2)
                        .foregroundColor(customColor)

                   

                    RatingAgeGenreView()
                        .padding(.vertical, 16)

                    Text("What's it about?")
                        .foregroundColor(customColor)
                        .font(.system(size: 24))
                        .bold()

                    Text(subtitle)
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
                        // Save action
                    }) {
                        Image(systemName: "bookmark.fill")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 55, height: 55)
                            .background(customColor)
                            .cornerRadius(8)
                    }

                    Button(action: {
                        // Borrow now action
                    }) {
                        Text("Borrow Now")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
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

extension Color {
    static func random() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
}
struct CustomBookView: View {
    var title: String
    var author: String
    var subtitle: String
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
                
                Text(author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }
        }
        .frame(width: 140)
    }
}


struct CustomHalfCircle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = rect.width / 2
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.maxY), radius: radius, startAngle: .degrees(180), endAngle: .degrees(0), clockwise: false)
        path.closeSubpath()
        return path
    }
}

struct RatingAgeGenreView: View {
    @Environment(\.colorScheme) var colorScheme
    let rating: Double = 4.8 // Example rating value, you can replace this with your actual rating

    var body: some View {
        VStack(spacing: 16) {
            Divider().padding(.vertical, 1)

            HStack(spacing: 24) {
                VStack(spacing: 1) {
                    Text("10K RATINGS")
                        .multilineTextAlignment(.leading)
                        .font(.caption)
                        .foregroundColor(customColor)
                        .frame(maxWidth: .infinity, alignment: .leading) // Ensure the text spans full width
                        .layoutPriority(1) // Give this text higher priority to prevent truncation

                    Text("\(rating, specifier: "%.1f")") // Display rating with one decimal place
                        .font(.title)
                        .foregroundColor(customColor)

                    HStack(spacing: 1) {
                        ForEach(0..<5) { index in // Change to 5 stars
                            Image(systemName: index < Int(rating) ? "star.fill" : "star")
                                .foregroundColor(customColor)
                                .font(.caption)
                        }
                    }
                }
                .padding(.horizontal, 2)
                .frame(height: 50) // Ensure the VStack height is 50 points

                Divider()
                    .frame(width: 1, height: 50)
                    .background(Color.gray)

                VStack(spacing: 1) {
                    Text("AGE")
                        .font(.caption)
                        .foregroundColor(customColor)
                    Text("12+")
                        .font(.title)
                        .foregroundColor(customColor)
                    Text("Years Old")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 16)
                .frame(height: 50) // Ensure the VStack height is 50 points

                Divider()
                    .frame(width: 1, height: 50)
                    .background(Color.gray)

                VStack(spacing: 1) {
                    Text("GENRE")
                        .font(.caption)
                        .foregroundColor(customColor)
                    Image(systemName: "book.fill")
                        .font(.title)
                        .foregroundColor(customColor)
                    Text("Fictional")
                        .font(.caption)
                        .foregroundColor(customColor)
                }
                .padding(.horizontal, 16)
                .frame(height: 50) // Ensure the VStack height is 50 points
            }

            Divider().padding(.vertical, 1)
        }
    }

    var customColor: Color {
        colorScheme == .dark ? Color(red: 230/255, green: 230/255, blue: 230/255) : Color(red: 81/255, green: 58/255, blue: 16/255)
    }
}


