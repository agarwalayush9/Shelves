import SwiftUI
import Firebase
import Combine

class BooksViewModel: ObservableObject {
    @Published var booksByGenre: [String: [GBook]] = [:]
    @Published var borrowedBooks: [GBook] = []
    @Published var isLoading: Bool = false
    private var cancellables = Set<AnyCancellable>()
    private let booksLimit = 15
    @Published var shelfOfTheDay: GBook? = nil
    let database = Database.database().reference()

    func fetchGenresAndBooks() {
        guard let email = Auth.auth().currentUser?.email else {
            print("User is not authenticated.")
            return
        }

        let emailKey = email.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
        let ref = database.child("members").child(emailKey).child("genre")

        ref.observeSingleEvent(of: .value) { snapshot in
            guard let genres = snapshot.value as? [String] else {
                print("No genres found for the user.")
                return
            }

            self.fetchBooks(for: genres)
        }
    }

    func fetchIsbnCodes(completion: @escaping (Result<[String: String], Error>) -> Void) {
        guard let userEmail = Auth.auth().currentUser?.email else {
            completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "User is not logged in."])))
            return
        }

        let safeEmail = userEmail.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
        database.child("issue-book").child(safeEmail).observeSingleEvent(of: .value) { snapshot in
            guard let isbnDict = snapshot.value as? [String: [String: Any]] else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data found or failed to cast snapshot value for ISBN status."])))
                return
            }

            var isbnStatusDict: [String: String] = [:]
            for (isbn, statusDict) in isbnDict {
                if let status = statusDict["status"] as? String {
                    isbnStatusDict[isbn] = status
                }
            }

            completion(.success(isbnStatusDict))
        }
    }

    func fetchBooks(completion: @escaping (Result<[GBook], Error>) -> Void) {
        fetchIsbnCodes { result in
            switch result {
            case .success(let isbnStatusDict):
                let isbnCodes = Array(isbnStatusDict.keys)
                self.fetchBooksFromGoogleAPI(isbnCodes: isbnCodes, isbnStatusDict: isbnStatusDict, completion: completion)

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    
    func fetchBooksFromGoogleAPI(isbnCodes: [String], isbnStatusDict: [String: String], completion: @escaping (Result<[GBook], Error>) -> Void) {
        let group = DispatchGroup()
        var books: [GBook] = []
        var errors: [Error] = []

        for isbn in isbnCodes {
            group.enter()
            let urlString = "https://www.googleapis.com/books/v1/volumes?q=isbn:\(isbn)"
            
            guard let url = URL(string: urlString) else {
                errors.append(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL for ISBN: \(isbn)"]))
                group.leave()
                continue
            }

            URLSession.shared.dataTask(with: url) { data, response, error in
                defer { group.leave() }

                if let error = error {
                    errors.append(error)
                    return
                }

                guard let data = data else {
                    errors.append(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data returned for ISBN: \(isbn)"]))
                    return
                }

                do {
                    let bookResponse = try JSONDecoder().decode(GoogleBookResponses.self, from: data)
                    if let googleBook = bookResponse.items.first {
                        if let status = isbnStatusDict[isbn] {
                            let book = GBook(from: googleBook, status: status)
                            books.append(book)
                        } else {
                            errors.append(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Status not found for ISBN: \(isbn)"]))
                        }
                    }
                } catch {
                    errors.append(error)
                }
            }.resume()
        }

        group.notify(queue: .main) {
            if errors.isEmpty {
                completion(.success(books))
            } else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch some or all books."])))
            }
        }
    }


    func fetchBorrowedBooks() {
        fetchBooks { result in
            switch result {
            case .success(let books):
                DispatchQueue.main.async {
                    self.borrowedBooks = books
                }
            case .failure(let error):
                print("Failed to fetch borrowed books: \(error)")
            }
        }
    }

    private func fetchBooks(for genres: [String]) {
        let urlStrings = genres.map { genre in
            "https://www.googleapis.com/books/v1/volumes?q=subject:\(genre)&maxResults=\(booksLimit)"
        }

        let publishers = urlStrings.map { urlString in
            URLSession.shared.dataTaskPublisher(for: URL(string: urlString)!)
                .map { $0.data }
                .decode(type: GoogleBookResponses.self, decoder: JSONDecoder())
                .map { $0.items.map { GBook(from: $0, status: "none") } }
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

struct GoogleBookResponses: Codable {
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
    let status: String // Add status parameter

    init(from googleBook: GoogleBooks, status: String) {
        self.id = UUID()
        self.title = googleBook.volumeInfo.title
        self.author = googleBook.volumeInfo.authors?.joined(separator: ", ") ?? "Unknown Author"
        self.subtitle = googleBook.volumeInfo.description ?? ""
        self.imageName = googleBook.volumeInfo.imageLinks?.thumbnail ?? ""
        self.rating = googleBook.volumeInfo.averageRating ?? 0.0
        self.categories = googleBook.volumeInfo.categories ?? []
        self.status = status
    }
}

