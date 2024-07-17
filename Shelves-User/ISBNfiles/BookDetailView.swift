import SwiftUI
import FirebaseDatabase

struct BookDetailView: View {
    
    let book: Books
    @State private var quantity: Int = 1
    @Environment(\.presentationMode) var presentationMode
    let dummyImage = UIImage(named: "dummyBookImage") // Add a dummy image to your assets
    @State private var showAlert = false
    @State private var alertMessage = ""
    @EnvironmentObject var authManager: AuthManager
    var customColor: Color {
        colorScheme == .dark ? Color(red: 230/255, green: 230/255, blue: 230/255) : Color(red: 81/255, green: 58/255, blue: 16/255)
    }
    @Environment(\.colorScheme) var colorScheme
    @State private var bookStatus = "Borrow Now"
    @State private var randomColor: Color = Color.random()
    
    var body: some View {
        ZStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {
                    Spacer() // Push content to the top
                    
                    // Book Cover with Custom Half Circle Background
                    GeometryReader { geometry in
                        ZStack {
                            CustomHalfCircle()
                                .fill(.gray).opacity(0.5)
                                .frame(height: geometry.size.width / 16)
                                .frame(width: 280)
                                .offset(y: geometry.size.width / 4)
                                .padding(.horizontal, 35).padding(.top, 20) // Adjust the offset to position the half-circle correctly

                            if let url = URL(string: book.bookCover) {
                                Rectangle()
                                    .fill(Color.clear)
                                    .frame(width: geometry.size.width - 100, height: 200)
                                    .background(
                                        AsyncImage(url: url) { phase in
                                            switch phase {
                                            case .empty:
                                                ProgressView()
                                                    .frame(width: 100, height: 150)
                                                    .cornerRadius(10)
                                            case .success(let image):
                                                image
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: geometry.size.width - 100, height: 200)
                                                    .cornerRadius(8)
                                            case .failure:
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: geometry.size.width - 100, height: 200)
                                                    .cornerRadius(8)
                                            @unknown default:
                                                Image(systemName: "photo")
                                                    .resizable()
                                                    .scaledToFit()
                                                    .frame(width: geometry.size.width - 100, height: 200)
                                                    .cornerRadius(8)
                                            }
                                        }
                                    )
                            }
                        }
                    }.frame(height: 200)

                    Text(book.bookTitle)
                        .font(.title)
                        .fontWeight(.bold).padding(.top)
                        .foregroundColor(customColor)
                    
                    if !book.author.isEmpty {
                        Text(book.author)
                            .font(.title2)
                            .foregroundColor(customColor)
                    }
                    
                    if let publisher = book.publisher {
                        Text(publisher)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Text("What's it about?")
                        .foregroundColor(customColor)
                        .font(.system(size: 24))
                        .bold()
                    
                    if let description = book.description {
                        Text(description)
                            .font(.system(size: 16))
                            .foregroundColor(customColor)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        requestBook()
                    }) {
                        Text(bookStatus)
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(customColor)
                            .cornerRadius(8)
                    }
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Request Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            .padding()
            
        }.background(
            LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.87, blue: 0.7), Color.white]),
                           startPoint: .top,
                           endPoint: .bottom)
        )
    }

    func requestBook() {
        guard let email = authManager.getEmail() else {
            alertMessage = "Please sign in to borrow a book."
            showAlert = true
            return
        }

        // Prepare the dictionary to be saved
        let bookDetails: [String: Any] = [
            book.bookCode: ["status": "Requested"]
        ]

        // Replace '.' in email with '-' to create a valid Firebase key
        let emailKey = email.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")

        // Reference to the Firebase Realtime Database
        let ref = Database.database().reference()

        // Create the path issue-book/emailKey/bookCode
        ref.child("issue-book").child(emailKey).updateChildValues(bookDetails) { error, ref in
            if let error = error {
                print("Data could not be saved: \(error).")
                alertMessage = "Failed to request the book. Please try again."
                showAlert = true
            } else {
                print("Data saved successfully!")
                alertMessage = "Request submitted! Please ask for the librarian's approval."
                bookStatus = "Requested"
                showAlert = true
            }
        }
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailView(book: Books(
            id: UUID(),
            bookCode: "1234567890",
            bookCover: "https://example.com/book-cover.jpg", // Add a valid URL here to preview
            bookTitle: "Sample Book",
            author: "Author One",
            genre: .Fiction,
            issuedDate: "2023-01-01",
            returnDate: "2023-02-01",
            status: "Available",
            quantity: nil,
            description: "This is a sample description of the book.",
            publisher: "Sample Publisher",
            publishedDate: "2023-01-01",
            pageCount: 300,
            averageRating: 4.5
        ))
    }
}
