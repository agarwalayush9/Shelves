//
//  UserScreen.swift
//  Shelves-User
//
//  Created by Jhanvi Jindal on 04/07/24.
//

import Foundation
import SwiftUI

struct UserHomePage: View {
    var body: some View {
        ZStack {
            // Set the background color of the entire screen
            Color("background")
                .edgesIgnoringSafeArea(.all)

            VStack {
                // Header
                HStack {
                    Text("Shelves.")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Text("Updated one hour ago")
                        .font(.subheadline)
                }
                .padding()

                // Overdue Book and View My Rentals Section
                HStack(spacing: 10) {
                    // Book Overdue Section
                    HStack {
                        Image("bookCover") // Replace with your book cover image
                            .resizable()
                            .frame(width: 70, height: 100)
                        VStack(alignment: .leading) {
                            Text("#4235532")
                                .font(.caption)
                                .foregroundColor(.black)
                                .padding(.top, 2)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 1)
                                        .frame(width: 70)
                                )
                            Text("The Good Guy")
                                .font(.title3)
                                .fixedSize()
                                .fontWeight(.bold)
                            HStack(spacing: 0){
                                Image(systemName: "clock")
                                Text("Book Overdue")
                                    .font(.system(size: 13))
                                    .frame(width: 100)
                                    .fontWeight(.medium)
                                    
                            }
                            
                            Text("Return before 29 May, Fines applied!")
                                .font(.footnote)
                                .foregroundColor(.black)
                                .frame(width:120,height: 35)
                        }
                        .frame(width: 140)
                    }
                    .padding()
                    .background(Color("background"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.black, lineWidth: 1)
                    )

                    // View My Rentals Section
                    VStack {
                        Spacer()
                        Button(action: {
                            // Action for "View My Rentals"
                        }) {
                            VStack {
                                Image(systemName: "list.bullet")
                                    .imageScale(.large)
                                    .frame(width: 80, height: 85)
                                Text("View My Rentals")
                                    .font(.system(size: 13))
                                    .foregroundColor(.black)
                                    
                                    .frame(width: 100,height: 20)
                            }
                            .frame(width: 85)
                            .padding(10)
                            .background(Color("background"))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black, lineWidth: 1)
                            )
                            
                        }
                        
                    }.padding(.bottom, 9)
                    .frame(width: 100)
                }
                .frame(height: 100)// Adjust the height if necessary
                .padding([.leading, .trailing,.top,.bottom])

                // Shelf of the Day Section
                VStack(alignment: .leading, spacing: 10) {
                    HStack{
                        Text("Shelve of the Day")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "bell") // Replace with your shelf book cover image
                            .resizable()
                            .frame(width:20,height:20)
                            .padding(.trailing,10)
                    }
                    Text("Selected by our curators")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Image("homepageImage")
                        .resizable()
                        .frame(height:200)
                        .cornerRadius(10)
                    Text("Humanly Possible")
                        .font(.title2)
                    Text("Sarah Bakewell")
                        .font(.subheadline)
                    Text("Seven hundered Years of Humanist Freethinking, Inquiry, and Hope")
                        .font(.caption)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding([.leading, .trailing, .top])

                Spacer()

                // Bottom Navigation
                HStack {
                    Button(action: {
                        // Home action
                    }) {
                        Image(systemName: "house")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    Spacer()
                    Button(action: {
                        // Search action
                    }) {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                    Spacer()
                    Button(action: {
                        // User profile action
                    }) {
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .frame(width: 25, height: 25)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
            }
        }
    }
}

struct UserHomePage_Previews: PreviewProvider {
    static var previews: some View {
        UserHomePage()
    }
}
