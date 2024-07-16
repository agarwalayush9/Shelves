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
struct Books: Identifiable, Codable, Equatable {
    var id = UUID()
    var bookCode: String
    var bookCover: String
    var bookTitle: String
    var author: String
    var genre: Genre
    var issuedDate: String
    var returnDate: String
    var status: String
    var quantity: Int?
    var description: String?
    var publisher: String?
    var publishedDate: String?
    var pageCount: Int?
    var averageRating: Double?

    func toDictionary() -> [String: Any] {
        return [
            "id": id.uuidString,
            "bookCode": bookCode,
            "bookCover": bookCover,
            "bookTitle": bookTitle,
            "author": author,
            "genre": genre.rawValue,
            "issuedDate": issuedDate,
            "returnDate": returnDate,
            "status": status,
            "quantity": quantity ?? 0,
            "description": description ?? "",
            "publisher": publisher ?? "",
            "publishedDate": publishedDate ?? "",
            "pageCount": pageCount ?? 0,
            "averageRating": averageRating ?? 0.0,
        ]
    }

    // Conformance to Equatable
    static func == (lhs: Books, rhs: Books) -> Bool {
        return lhs.id == rhs.id
    }
}
enum Genre: String, Codable, CaseIterable {
    case Horror
    case Mystery
    case Fiction
    case Finance
    case Fantasy
    case Business
    case Romance
    case Psychology
    case YoungAdult
    case SelfHelp
    case HistoricalFiction
    case NonFiction
    case ScienceFiction
    case Literature
}

struct ContentSection: Identifiable, Decodable {
    let id: UUID
    let title: String
    let subtitle: String
    let books: [Book]
}

