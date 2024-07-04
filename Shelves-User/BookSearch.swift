//
//  BookSearch.swift
//  Shelves-User
//
//  Created by Sahil Raj on 04/07/24.
//


import SwiftUI

struct Books: Identifiable, Codable {
    var id = UUID()
    var title: String
}

struct BookSearch: View {
    
    @State private var books: [Books] = [
        Books(title: "Mdzs"),
        Books(title: "The Catcher in the Rye"),
        Books(title: "To Kill a Mockingbird"),
        Books(title: "1984"),
        Books(title: "Pride and Prejudice"),
        Books(title: "The Great Gatsby"),
        Books(title: "The Hobbit"),
        Books(title: "Harry Potter and the Sorcerer's Stone")
    ]
    
    @State private var searchTerm = ""
    
    private var filteredBooks: [Books] {
        guard !searchTerm.isEmpty else { return books }
        return books.filter { $0.title.localizedCaseInsensitiveContains(searchTerm) }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(filteredBooks) { book in
                    HStack(spacing: 20) {
                        Text(book.title).font(.title3).fontWeight(.medium)
                    }
                }
                .navigationTitle("Books")
                .searchable(text: $searchTerm, prompt: "Search Books")
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    BookSearch()
}
