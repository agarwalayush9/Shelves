import SwiftUI

struct Constants {
    static let sm: CGFloat = 12
    static let meta: CGFloat = 4
}

struct Book1: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let details: String
    let coverImageName: String
}

struct BorrowBooks: View {
    let borrowedBooks = [
        Book1(title: "Who We Are and How We...", author: "David Reich", details: "Ancient DNA and the New Science of the Human Past", coverImageName: "bookCover"),
        Book1(title: "Book 2", author: "Author 2", details: "Details of Book 2", coverImageName: "bookCover"),
        Book1(title: "Book 3", author: "Author 3", details: "Details of Book 3", coverImageName: "bookCover"),
        Book1(title: "Book 4", author: "Author 4", details: "Details of Book 4", coverImageName: "bookCover")
    ]
    
    let reservedBooks = [
        Book1(title: "Really Good, Actually", author: "Monica Heisey", details: "A story of a woman navigating life after divorce.", coverImageName: "bookCover"),
        Book1(title: "Book 2", author: "Author 2", details: "Details of Book 2", coverImageName: "bookCover"),
        Book1(title: "Book 3", author: "Author 3", details: "Details of Book 3", coverImageName: "bookCover"),
        Book1(title: "Book 4", author: "Author 4", details: "Details of Book 4", coverImageName: "bookCover")
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.87, blue: 0.7), Color.white]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 16) {
                    HeaderView()
                    ScrollView(showsIndicators: false) {
                        SubHeaderView()
                        BorrowedBooksSection(books: borrowedBooks)
                        ReservationsSection(books: reservedBooks)
                    }
                }
                .padding([.leading, .trailing], 16)
            }
            .navigationBarHidden(true) // Hide the navigation bar to match the design
        }
    }
}

struct HeaderView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 15) {
            VStack(alignment: .leading, spacing: 7) {
                Text("My Bookshelf")
                    .font(.largeTitle)
                    .foregroundColor(.black)
                    .bold()
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 50, height: Constants.meta)
                    .background(Color(red: 0.32, green: 0.23, blue: 0.06))
                    .frame(alignment: .leading)
                
            }
            Spacer()
            NavigationLink(destination: ContentWiew()) {
                Image(systemName: "qrcode.viewfinder")
                    .resizable()
                    .frame(width: 40, height: 40)
                    .padding(.trailing)
                    .foregroundColor(.black)
            }
        }
        .padding(.vertical)
    }
}

struct SubHeaderView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 42) {
            HStack {
                VStack {
                    Text("Overdue Charges")
                        .font(.subheadline)
                    Text("Rs. 0")
                        .font(.title2)
                }
                Image("Line 35")
                    .frame(width: 32, height: 0)
                    .overlay(
                        Rectangle()
                            .stroke(Color(red: 0.32, green: 0.23, blue: 0.06), lineWidth: 2)
                    )
                VStack {
                    Text("Reading limit")
                        .font(.subheadline)
                    Text("4 of 5")
                        .font(.title2)
                }
            }
            .padding([.top, .bottom], 18)
            .padding([.leading, .trailing], 36)
            .cornerRadius(Constants.sm)
            .overlay(
                RoundedRectangle(cornerRadius: Constants.sm)
                    .inset(by: 1)
                    .stroke(Color(red: 0.32, green: 0.23, blue: 0.06), lineWidth: 2)
            )
        }
    }
}

struct BorrowedBooksSection: View {
    let books: [Book1]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Your Borrowed Books")
                    .font(.title2)
                    .bold()
                Spacer()
                NavigationLink(destination: BooksGridView1(title: "Borrowed Books", books: books)) {
                    Text("See All")
                        .font(Font.custom("DM Sans", size: 14).weight(.medium))
                        .foregroundColor(Color(red: 0.32, green: 0.23, blue: 0.06))
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(books) { book in
                        BookView1(book: book)
                    }
                }
            }
        }
        .padding(.vertical)
    }
}

struct ReservationsSection: View {
    let books: [Book1]
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Your Reservations")
                    .font(.title2)
                    .bold()
                Spacer()
                NavigationLink(destination: BooksGridView1(title: "Reservations", books: books)) {
                    Text("See All")
                        .font(Font.custom("DM Sans", size: 14).weight(.medium))
                        .foregroundColor(Color(red: 0.32, green: 0.23, blue: 0.06))
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(books) { book in
                        BookView1(book: book)
                    }
                }
            }
        }
        .padding(.vertical)
    }
}

struct BookView1: View {
    let book: Book1
    
    var body: some View {
        NavigationLink(destination: CustomBookDetailView(title: book.title, author: book.author, subtitle: book.details)){
            VStack(alignment: .leading) {
                ZStack {
                    Image("Ellipse 2")
                        .frame(width: 161.58664, height: 81.00001)
                        .offset(y: 55)
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 104, height: 156)
                        .background(
                            Image(book.coverImageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 104, height: 156)
                                .clipped()
                        )
                }
                .padding(.bottom, 20)
                
                Text(book.title)
                    .font(.headline)
                    .lineLimit(1)
                    .foregroundColor(.black)
                Text(book.author)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text(book.details)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            .frame(width: 161)
            
        }
    }
}

struct BooksGridView1: View {
    let title: String
    let books: [Book1]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.87, blue: 0.7), Color.white]),
                           startPoint: .top,
                           endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150), spacing: 16)], spacing: 16) {
                        ForEach(books) { book in
                            BookView1(book: book)
                        }
                    }
                    .padding()
                }
            }
        }
        .navigationTitle(title)
    }
}

struct CContentView: View {
    var body: some View {
        Text("This is the ContentView")
    }
}

#Preview {
    BorrowBooks()
}
