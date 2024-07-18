////
////  BookContentView.swift
////  Shelves-User
////
////  Created by Anay Dubey on 11/07/24.
////
//
//import SwiftUI
//
//struct BookContentView: View {
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 10) {
//            HStack {
//                VStack(alignment: .leading) {
//                    Text(section.title)
//                        .font(.headline)
//                    Text(section.subtitle)
//                        .font(.footnote)
//                        .foregroundColor(.secondary)
//                }
//                Spacer()
//                NavigationLink(destination: DetailedBookListView(title: section.title, books: section.books)) {
//                    Text("Show all")
//                        .font(.subheadline)
//                        .foregroundColor(.brown)
//                }
//            }
//            .padding(.horizontal)
//            
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 20) {
//                    ForEach(section.books) { book in
//                        BookView(title: book.title, author: book.author, subtitle: book.subtitle, imageName: book.imageName)
//                    }
//                }
//                .padding(.horizontal, 10)
//            }
//        }
//    }
//}
