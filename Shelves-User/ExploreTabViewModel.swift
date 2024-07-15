//
//  ExploreTabViewModel.swift
//  Shelves-User
//
//  Created by Anay Dubey on 11/07/24.
//

import Foundation

class ExploreTabViewModel: ObservableObject {
    @Published var contentSections: [ContentSection] = []
    
    init() {
        fetchContent()
    }
    
    func fetchContent() {
        // Replace with your actual API call
        let sampleBooks = [
            Book(id: UUID(), title: "The Good Guy", author: "Author Name", subtitle: "Subtitle goes here", imageName: "bookCover"),
            Book(id: UUID(), title: "Really Good, Actually", author: "Monica Heisey", subtitle: "Subtitle goes here", imageName: "bookCover"),
            Book(id: UUID(), title: "A Brief History of Time", author: "Stephen Hawking", subtitle: "From the Big Bang to Black Holes", imageName: "bookCover"),
            Book(id: UUID(), title: "Who We Are and How We", author: "David Reich", subtitle: "Ancient DNA and the New Science of Human", imageName: "bookCover")
        ]
        
        let sampleSections = [
            ContentSection(id: UUID(), title: "Recommended for you", subtitle: "We think you'll like these", books: sampleBooks),
            ContentSection(id: UUID(), title: "Fictional", subtitle: "We think you'll like these", books: sampleBooks),
            ContentSection(id: UUID(), title: "Sci-Fi", subtitle: "We think you'll like these", books: sampleBooks)
        ]
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.contentSections = sampleSections
        }
    }
}
