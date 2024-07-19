//
//  CustomBookView.swift
//  Shelves-User
//
//  Created by Suraj Singh on 11/07/24.
//

import SwiftUI

struct BorrowBookView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var randomColor: Color = Color.random1()
    
    var title: String
    var author: String
    var subtitle: String
    var url:String
    var rating: Double
    var genre: [String]
    var status: String
    
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
                        .fontWeight(.bold).padding(.top)
                        .foregroundColor(customColor)
                        .lineLimit(1)
                    Text(author)
                        .font(.title2)
                        .foregroundColor(customColor)
                        .lineLimit(1)
                    Text(subtitle)
                        .font(.system(size: 16))
                        .foregroundColor(customColor)
                        .lineLimit(2)
                 

                  
                }
                .padding(.horizontal, 16)
                .padding(.bottom,21) // Add padding to the bottom to avoid content being hidden behind the buttons
                HStack(alignment: .center, spacing: 42) {
                    HStack {
                        VStack {
                            Text("Borrowed On")
                              .font(
                                Font.custom("DM Sans", size: 12)
                                  .weight(.semibold)
                              )
                              .multilineTextAlignment(.center)
                              .foregroundColor(Color(red: 0.32, green: 0.23, blue: 0.06))
                            Text("July 21, 2023")
                              .font(
                                Font.custom("DM Sans", size: 20)
                                  .weight(.bold)
                              )
                              .padding(.top,5)
                              .multilineTextAlignment(.center)
                              .foregroundColor(Color(red: 0.32, green: 0.23, blue: 0.06))
                        }
                        Image("Line 35")
                            .frame(width: 32, height: 0)
                            .overlay(
                                Rectangle()
                                    .stroke(Color(red: 0.32, green: 0.23, blue: 0.06), lineWidth: 2)
                            )
                        VStack {
                            Text("To Return On")
                              .font(
                                Font.custom("DM Sans", size: 12)
                                  .weight(.semibold)
                              )
                              .multilineTextAlignment(.center)
                              .foregroundColor(Color(red: 0.32, green: 0.23, blue: 0.06))
                            Text("July 28, 2023")
                              .font(
                                Font.custom("DM Sans", size: 20)
                                  .weight(.bold)
                              )
                              .padding(.top,5)
                              .multilineTextAlignment(.center)
                              .foregroundColor(Color(red: 0.32, green: 0.23, blue: 0.06))
                        }
                    }
                    .padding([.top, .bottom], 18)
                    .padding([.leading, .trailing], 36)
                    .cornerRadius(Constants.sm)
                    .overlay(
                        RoundedRectangle(cornerRadius: Constants.sm)
                            .inset(by: 1)
                            .stroke(Color(red: 0.32, green: 0.23, blue: 0.06), lineWidth: 2)
                    )
                }.padding(.bottom,25)
                
                HStack(alignment: .center, spacing: -4) {
                    Text("Any Charges/Overdues to be Paid")
                      .font(
                        Font.custom("DM Sans", size: 20)
                          .weight(.semibold)
                      )
                      .foregroundColor(Color(red: 0.32, green: 0.23, blue: 0.06))
                      .frame(width: 192, alignment: .topLeading)
                    Text("Rs. 0")
                      .font(
                        Font.custom("DM Sans", size: 32)
                          .weight(.semibold)
                      )
                      .multilineTextAlignment(.trailing)
                      .foregroundColor(Color(red: 0.32, green: 0.23, blue: 0.06))
                      .frame(width: 147, alignment: .topTrailing)
                }
                .padding(0)
                .frame(width: 334, alignment: .trailing)
            }
            

            VStack {
                Spacer()
                HStack(spacing: 16) {
                    

                    Button(action: {
                        // Borrow now action
                    }) {
                        Text(status)
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
    static func random1() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
}



struct CustomHalfCircle1: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let radius = rect.width / 2
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addArc(center: CGPoint(x: rect.midX, y: rect.maxY), radius: radius, startAngle: .degrees(180), endAngle: .degrees(0), clockwise: false)
        path.closeSubpath()
        return path
    }
}



#Preview{
    BorrowBookView(title: "Life 3.0", author: "Max Tegmark", subtitle: "Being Human in the Age of Artifical Intelligence", url: "bookCover", rating: 0.0, genre: ["nothing"], status: "Registered")
}
