//
//  SearchAsset.swift
//  Shelves-User
//
//  Created by Mohit Kumar Gupta on 17/07/24.
//

import SwiftUI
import Combine

struct BookSear: Codable, Identifiable {
    let id: String
    let volumeInfo: VolumeInfoo
}

struct VolumeInfoo: Codable {
    let title: String
    let authors: [String]?
    let imageLinks: ImageLinkss?
}

struct ImageLinkss: Codable {
    let thumbnail: String?
}

class ImageLoaderr: ObservableObject {
    @Published var image: UIImage?
    private var cancellable: AnyCancellable?

    func loadImage(from url: URL) {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: self)
    }

    func cancel() {
        cancellable?.cancel()
    }
}

class BooksViewModell: ObservableObject {
    @Published var books: [BookSear] = []
    @Published var searchText: String = ""
    private var cancellables: Set<AnyCancellable> = []

    
    init() {
            $searchText
                .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
                .removeDuplicates()
                .sink(receiveValue: { [weak self] value in
                    self?.fetchBooks(query: value)
                })
                .store(in: &cancellables)
        }
    
    func fetchBooks(query: String) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "https://www.googleapis.com/books/v1/volumes?q=\(encodedQuery)&maxResults=10") else {
            return
        }

        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: BookListResponses.self, decoder: JSONDecoder())
            .replaceError(with: BookListResponses(items: []))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { response in
                self.books = response.items ?? []
            })
            .store(in: &cancellables)
    }
}

//struct SearchBarr: View {
//    @StateObject private var viewModel = BooksViewModell()
//    @State private var searchText = ""
//    @State private var debouncedText = ""
//    private var debouncer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
//
//    var body: some View {
//        VStack {
//            HStack {
//                Image(systemName: "magnifyingglass")
//                TextField("Search...", text: $searchText)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .onChange(of: searchText, perform: { value in
//                        debouncedText = value
//                    })
//            }
//            .padding()
//
//            List(viewModel.books, id: \.id) { book in
//                VStack(alignment: .leading) {
//                    Text(book.volumeInfo.title)
//                        .font(.headline)
//                    if let authors = book.volumeInfo.authors {
//                        Text(authors.joined(separator: ", "))
//                            .font(.subheadline)
//                            .foregroundColor(.secondary)
//                    }
//                    AsyncImageVieww(url: imageURL(for: book))
//                        .frame(width: 100, height: 150)
//                        .cornerRadius(8)
//                }
//                .padding(.vertical)
//            }
//            .listStyle(PlainListStyle())
//
//            Spacer()
//        }
//        .padding()
//        .onReceive(debouncer) { _ in
//            viewModel.fetchBooks(query: debouncedText)
//        }
//    }
//
//    private func imageURL(for book: BookSear) -> URL {
//        guard let thumbnailLink = book.volumeInfo.imageLinks?.thumbnail,
//              let thumbnailURL = URL(string: thumbnailLink) else {
//            return URL(string: "https://example.com/placeholder.jpg")! // Replace with a placeholder URL or handle differently
//        }
//        return thumbnailURL
//    }
//}



struct BookListResponses: Codable {
    let items: [BookSear]?
}

struct AsyncImageVieww: View {
    @StateObject private var imageLoader = ImageLoaderr()
        var url: URL

        var body: some View {
            Image(uiImage: imageLoader.image ?? UIImage(systemName: "photo")!)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 150)
                .cornerRadius(8)
                .onAppear {
                    imageLoader.loadImage(from: url)
                }
                .onDisappear {
                    imageLoader.cancel()
                }
        }
}
