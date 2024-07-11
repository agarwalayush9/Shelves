//
//  ExploreTab.swift
//  Shelves-User
//
//  Created by Anay Dubey on 05/07/24.
//

import SwiftUI

struct ExploreTab: View {
    @State private var selectedCategory: String = "Trending"
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Explore")
                        .font(.largeTitle)
                        .bold()
                        .padding(.horizontal)
                        .padding(.top, 20)
                    
                    Rectangle()
                        .frame(width: 80, height: 5)
                        .foregroundColor(.brown)
                        .padding(.horizontal)
                        .cornerRadius(10)
                    
                    SearchBar()
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    Text("Categories")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.top, 5)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            CategoryButton(
                                title: "Trending",
                                icon: "flame.fill",
                                isSelected: selectedCategory == "Trending",
                                backgroundColor: selectedCategory == "Trending" ? Color(red: 86/255, green: 63/255, blue: 39/255) : .white,
                                textColor: selectedCategory == "Trending" ? .white : Color(red: 86/255, green: 63/255, blue: 39/255),
                                action: {
                                    selectedCategory = "Trending"
                                }
                            )
                            CategoryButton(
                                title: "5-Minutes Read",
                                icon: "book.fill",
                                isSelected: selectedCategory == "5-Minutes Read",
                                backgroundColor: selectedCategory == "5-Minutes Read" ? Color(red: 86/255, green: 63/255, blue: 39/255) : .white,
                                textColor: selectedCategory == "5-Minutes Read" ? .white : Color(red: 86/255, green: 63/255, blue: 39/255),
                                action: {
                                    selectedCategory = "5-Minutes Read"
                                }
                            )
                            CategoryButton(
                                title: "Quick Listen",
                                icon: "headphones",
                                isSelected: selectedCategory == "Quick Listen",
                                backgroundColor: selectedCategory == "Quick Listen" ? Color(red: 86/255, green: 63/255, blue: 39/255) : .white,
                                textColor: selectedCategory == "Quick Listen" ? .white : Color(red: 86/255, green: 63/255, blue: 39/255),
                                action: {
                                    selectedCategory = "Quick Listen"
                                }
                            )
                        }
                        .padding(.horizontal)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Recommended for you")
                                    .font(.headline)
                                Text("We think you'll like these")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Button(action: {}) {
                                Text("Show all")
                                    .font(.subheadline)
                                    .foregroundColor(.brown)
                            }
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                BookView(title: "The Good Guy", author: "Author Name", subtitle: "Subtitle goes here")
                                BookView(title: "Really Good, Actually", author: "Monica Heisey", subtitle: "Subtitle goes here")
                                BookView(title: "A Brief History of Time", author: "Stephen Hawking", subtitle: "From the Big Bang to Black Holes")
                                BookView(title: "Who We Are and How We", author: "David Reich", subtitle: "Ancient DNA and the New Science of Human")
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text("Fictional")
                                    .font(.headline)
                                Text("We think you'll like these")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                            }
                            Spacer()
                            Button(action: {}) {
                                Text("Show all")
                                    .font(.subheadline)
                                    .foregroundColor(.brown)
                            }
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                BookView(title: "Futurama", author: "Matt Groening", subtitle: "Fictional Universe")
                                BookView(title: "Really Good, Actually", author: "Monica Heisey", subtitle: "A Novel")
                                BookView(title: "A Brief History of Time", author: "Stephen Hawking", subtitle: "From the Big Bang to Black Holes")
                                BookView(title: "Who We Are and How We", author: "David Reich", subtitle: "Ancient DNA and the New Science of Human")
                            }
                            .padding(.horizontal, 10)
                        }
                    }
                    
                    Spacer()
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

struct SearchBar: View {
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.brown)
                .padding(.leading, 10)
            
            TextField("Search Title, author or topic", text: $searchText)
                .foregroundColor(.primary)
                .padding(10)
        }
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.brown, lineWidth: 2)
        )
        .padding(.horizontal, 10)
    }
}

struct CategoryButton: View {
    var title: String
    var icon: String
    var isSelected: Bool
    var backgroundColor: Color
    var textColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(textColor)
                Text(title)
                    .foregroundColor(textColor)
            }
            .padding()
            .background(backgroundColor)
            .cornerRadius(35)
            .overlay(
                RoundedRectangle(cornerRadius: 35)
                    .stroke(Color.brown, lineWidth: 1)
            )
        }
    }
}

struct BookView: View {
    var title: String
    var author: String
    var subtitle: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Rectangle()
                .fill(Color.gray)
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

struct ExploreTab_Previews: PreviewProvider {
    static var previews: some View {
        ExploreTab()
    }
}
