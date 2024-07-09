//
//  ExploreTab.swift
//  Shelves-User
//
//  Created by Anay Dubey on 05/07/24.
//

import SwiftUI

struct ExploreTab: View {
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
                        .frame(width: 80, height: 2)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                    SearchBar()
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    Text("Categories")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 15) {
                            CategoryButton(title: "Trending", icon: "flame.fill", isSelected: true)
                            CategoryButton(title: "5-Minutes Read", icon: "clock.fill", isSelected: false)
                            CategoryButton(title: "Quick Listen", icon: "headphones", isSelected: false)
                        }
                        .padding(.horizontal)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Recommended for you")
                                .font(.headline)
                            Spacer()
                            Button(action: {}) {
                                Text("Show all")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                BookView(title: "A Brief History of Time", author: "Stephen Hawking", subtitle: "From the Big Bang to Black Holes")
                                BookView(title: "Who We Are and How We", author: "David Reich", subtitle: "Ancient DNA and the New Science of Human")
                                BookView(title: "The Good Guy", author: "Author Name", subtitle: "Subtitle goes here")
                                BookView(title: "Really Good, Actually", author: "Monica Heisey", subtitle: "Subtitle goes here")
                            }
                            .padding(.horizontal)
                        }
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        HStack {
                            Text("Recommended for you")
                                .font(.headline)
                            Spacer()
                            Button(action: {}) {
                                Text("Show all")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.horizontal)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 20) {
                                BookView(title: "A Brief History of Time", author: "Stephen Hawking", subtitle: "From the Big Bang to Black Holes")
                                BookView(title: "Who We Are and How We", author: "David Reich", subtitle: "Ancient DNA and the New Science of Human")
                                BookView(title: "Do Epic Shit", author: "Author Name", subtitle: "Subtitle goes here")
                                BookView(title: "Really Good, Actually", author: "Monica Heisey", subtitle: "Subtitle goes here")
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    Spacer()
                }
            }
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
                .stroke(Color.brown, lineWidth: 1)
        )
        .padding(.horizontal, 10)
    }
}

struct CategoryButton: View {
    var title: String
    var icon: String
    var isSelected: Bool
    
    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(isSelected ? .white : .brown)
                Text(title)
                    .foregroundColor(isSelected ? .white : .brown)
            }
            .padding()
            .background(isSelected ? Color.brown : Color.white)
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
            
            Text(title)
                .font(.headline)
                .lineLimit(2)
            
            Text(author)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(subtitle)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(3)
        }
        .frame(width: 140)
    }
}

struct ExploreTab_Previews: PreviewProvider {
    static var previews: some View {
        ExploreTab()
    }
}
