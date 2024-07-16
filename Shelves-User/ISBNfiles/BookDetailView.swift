import SwiftUI

struct BookDetailView: View {
    let book: Books
    @State private var quantity: Int = 1
    @Environment(\.presentationMode) var presentationMode
    let dummyImage = UIImage(named: "dummyBookImage") // Add a dummy image to your assets
    @State private var showAlert = false
    @State private var alertMessage = ""
    var customColor: Color {
        colorScheme == .dark ? Color(red: 230/255, green: 230/255, blue: 230/255) : Color(red: 81/255, green: 58/255, blue: 16/255)
    }
    @Environment(\.colorScheme) var colorScheme
    @State private var randomColor: Color = Color.random()
    var body: some View {
        ZStack{
            ScrollView {
                
                VStack(alignment: .leading, spacing: 10) {
                    Spacer() // Push content to the top
                    
                    // Book Cover with Custom Half Circle Background
                    if let imageUrl = URL(string: book.bookCover)  {
                        AsyncImage(url: imageUrl) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            case .failure:
                                Image(systemName: "book.pages.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                            @unknown default:
                                EmptyView()
                            }
                        }.frame(width: 200, height: 200)
                            .frame(alignment: .center)
                            .padding(.trailing)
                            .padding(.leading)// Adjust the height to match the image height
                    }
                        
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
                            // Borrow now action
                        }) {
                            Text("Borrow Now")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(customColor)
                                .cornerRadius(8)
                        }
                }
            }
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
        }.background(
            LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.87, blue: 0.7), Color.white]),
                           startPoint: .top,
                           endPoint: .bottom))
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
