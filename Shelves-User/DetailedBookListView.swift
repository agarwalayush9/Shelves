//
//  DetailedBookListView.swift
//  Shelves-User
//
//  Created by Anay Dubey on 12/07/24.
//

import SwiftUI

struct DetailedBookListView: View {
    var title: String
    var books: [Book]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(title)
                    .font(.largeTitle)
                    .bold()
                    .padding(.horizontal)
                    .padding(.top, 20)
                
                Text("Select the type of book you enjoy reading.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                    ForEach(books, id: \.id) { book in
                        BookView(title: book.title, author: book.author, subtitle: book.subtitle, imageName: book.imageName)
                            .padding(.horizontal)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.top, 20)
            .padding(.bottom, 20)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.87, blue: 0.7), Color.white]),
                           startPoint: .top,
                           endPoint: .bottom)
        )
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailedBookListView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedBookListView(
            title: "Sample Title",
            books: [
                Book(id: UUID(), title: "Sample Book 1", author: "Author 1", subtitle: "Subtitle 1", imageName: "book1"),
                Book(id: UUID(), title: "Sample Book 2", author: "Author 2", subtitle: "Subtitle 2", imageName: "book2")
            ]
        )
    }
}
