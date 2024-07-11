//
//  Book.swift
//  Shelves-User
//
//  Created by Anay Dubey on 11/07/24.
//

import Foundation

struct Book: Identifiable, Decodable {
    let id: UUID
    let title: String
    let author: String
    let subtitle: String
    let imageName: String
}

struct ContentSection: Identifiable, Decodable {
    let id: UUID
    let title: String
    let subtitle: String
    let books: [Book]
}

