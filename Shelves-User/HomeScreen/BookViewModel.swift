import SwiftUI
import Firebase
import Combine

class BooksViewModel: ObservableObject {
    @Published var booksByGenre: [String: [GBook]] = [:]
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private let booksLimit = 10
    @Published var shelfOfTheDay: GBook? = nil

    func fetchGenresAndBooks() {
        guard let email = Auth.auth().currentUser?.email else {
            print("User is not authenticated.")
            return
        }
        
        let emailKey = email.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
        let ref = Database.database().reference().child("members").child(emailKey).child("genre")
        
        ref.observeSingleEvent(of: .value) { snapshot in
            guard let genres = snapshot.value as? [String] else {
                print("No genres found for the user.")
                return
            }
            
            self.fetchBooks(for: genres)
        }
    }
    
    private func fetchBooks(for genres: [String]) {
        let urlStrings = genres.map { genre in
            "https://www.googleapis.com/books/v1/volumes?q=subject:\(genre)&maxResults=\(booksLimit)"
        }
        
        let publishers = urlStrings.map { urlString in
            URLSession.shared.dataTaskPublisher(for: URL(string: urlString)!)
                .map { $0.data }
                .decode(type: GoogleBooksResponses.self, decoder: JSONDecoder())
                .map { $0.items.map { GBook(from: $0) } }
                .replaceError(with: [])
                .eraseToAnyPublisher()
        }
        
        Publishers.MergeMany(publishers)
            .collect()
            .map { $0.flatMap { $0 } }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] books in
                self?.booksByGenre = Dictionary(grouping: books, by: { $0.categories.first ?? "Unknown" })
                self?.selectShelfOfTheDay(from: books)
                self?.isLoading = false
            }
            .store(in: &cancellables)
        
        self.isLoading = true
    }
    
    private func selectShelfOfTheDay(from books: [GBook]) {
        // Custom logic to select the "Shelf of the Day" book
        self.shelfOfTheDay = books.randomElement() // Example: randomly selecting a book
    }
}

struct GoogleBooksResponses: Codable {
    let items: [GoogleBooks]
}

struct GoogleBooks: Codable {
    let id: String
    let volumeInfo: VolumeInfo
    
    struct VolumeInfo: Codable {
        let title: String
        let authors: [String]?
        let description: String?
        let imageLinks: ImageLinks?
        let averageRating: Double?
        let categories: [String]?
        
        struct ImageLinks: Codable {
            let thumbnail: String
        }
    }
}

struct GBook: Identifiable {
    let id: UUID
    let title: String
    let author: String
    let subtitle: String
    let imageName: String
    let rating: Double
    let categories: [String]

    init(from googleBook: GoogleBooks) {
        self.id = UUID()
        self.title = googleBook.volumeInfo.title
        self.author = googleBook.volumeInfo.authors?.joined(separator: ", ") ?? "Unknown Author"
        self.subtitle = googleBook.volumeInfo.description ?? ""
        self.imageName = googleBook.volumeInfo.imageLinks?.thumbnail ?? ""
        self.rating = googleBook.volumeInfo.averageRating ?? 0.0
        self.categories = googleBook.volumeInfo.categories ?? []
    }
}
