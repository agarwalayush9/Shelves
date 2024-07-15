import SwiftUI

struct Constant {
    static let meta: CGFloat = 4
      static let Black: Color = .black
}


struct UserHomePage: View {
    @State private var selectedIndex = 0
    @State private var selectedCategory: String = ""
    let books: [Book] = [
        Book(id: UUID(), title: "Life 3.0", author: "Max Tegmark", subtitle: "Being Human in the Age of Artificial Intelligence", imageName: "bookCover"),
        Book(id: UUID(), title: "Life 3.0", author: "Max Tegmark", subtitle: "Being Human in the Age of Artificial Intelligence", imageName: "bookCover"),
        Book(id: UUID(), title: "Life 3.0", author: "Max Tegmark", subtitle: "Being Human in the Age of Artificial Intelligence", imageName: "bookCover")
    ]
    let authors: [Author] = [
        Author(name: "Stephen Hawking", title: "Stephen Hawking", description: "From the Bing Bang to Black Holes", image: "bookCover"),
        Author(name: "Stephen Hawking", title: "Stephen Hawking", description: "From the Bing Bang to Black Holes", image: "bookCover"),
        Author(name: "Stephen Hawking", title: "Stephen Hawking", description: "From the Bing Bang to Black Holes", image: "bookCover")
    ]
    
    var body: some View {
        HomeView(selectedCategory: $selectedCategory, books: books, authors: authors)
    }
}
struct HomeView: View {
    
    @Binding var selectedCategory: String
    let books: [Book]
    let authors: [Author]

    var body: some View {
        NavigationView(){
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.87, blue: 0.7), Color.white]),
                               startPoint: .top,
                               endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
               
                    
                    VStack {
                        // Header
                        HStack(alignment: .center, spacing: 15) {
                            VStack(alignment: .leading, spacing: 7) {
                                Text("Shelves")
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
                        }
                        .padding()
                        
                        // Overdue Book and View My Rentals Section
                        //                    HStack(spacing: 20) {
                        //                        OverdueBookView()
                        //                        ViewMyRentalsView()
                        //                    }
                        //                    .frame(height: 100)
                        //                    .padding()
                        ScrollView {
                        // Shelf of the Day Section
                        ShelfOfTheDayView()
                            .padding(.top,0)
                            .padding(.leading)
                            .padding(.bottom)
                            .padding(.trailing)
                        
                        // Categories Section
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 15) {
                                CategoryButton(
                                    title: "Trending",
                                    icon: "flame.fill",
                                    isSelected: selectedCategory == "Trending",
                                    backgroundColor: selectedCategory == "Trending" ? Color(red: 86/255, green: 63/255, blue: 39/255) : .white,
                                    textColor: selectedCategory == "Trending" ? .white : Color(red: 86/255, green: 63/255, blue: 39/255),
                                    action: {
                                        selectedCategory = "Trending"
                                    }
                                )
                                CategoryButton(
                                    title: "5-Minutes Read",
                                    icon: "book.fill",
                                    isSelected: selectedCategory == "5-Minutes Read",
                                    backgroundColor: selectedCategory == "5-Minutes Read" ? Color(red: 86/255, green: 63/255, blue: 39/255) : .white,
                                    textColor: selectedCategory == "5-Minutes Read" ? .white : Color(red: 86/255, green: 63/255, blue: 39/255),
                                    action: {
                                        selectedCategory = "5-Minutes Read"
                                    }
                                )
                                CategoryButton(
                                    title: "Quick Listen",
                                    icon: "headphones",
                                    isSelected: selectedCategory == "Quick Listen",
                                    backgroundColor: selectedCategory == "Quick Listen" ? Color(red: 86/255, green: 63/255, blue: 39/255) : .white,
                                    textColor: selectedCategory == "Quick Listen" ? .white : Color(red: 86/255, green: 63/255, blue: 39/255),
                                    action: {
                                        selectedCategory = "Quick Listen"
                                    }
                                )
                            }
                            .padding(.horizontal)
                        }
                        
                        // Recommended for You Section
                        
                        RecommendedForYouView()
                            .padding()
                        
                      
                    }
                }
            }
        }
    }
}

struct OverdueBookView: View {
    var body: some View {
        HStack {
            Image("bookCover") // Replace with your book cover image
                .resizable()
                .frame(width: 70, height: 100)
            VStack(alignment: .leading) {
                Text("#4235532")
                    .font(.caption)
                    .foregroundColor(.red)
                Text("The Good Guy")
                    .font(.title3)
                HStack {
                    Image("clock").resizable().frame(width: 18, height: 18)
                    Text("Book Overdue")
                }
                .font(.subheadline)
                Text("Return before 29 May, Fines applied!")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
        .padding()
        .background(Color("background"))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("#513A10"), lineWidth: 3))
    }
}

struct ViewMyRentalsView: View {
    var body: some View {
        VStack {
            Button(action: {
                // Action for "View My Rentals"
            }) {
                VStack {
                    Image("bookIcon").resizable().frame(width: 50, height: 50).padding(.horizontal, 10)
                    Text("View").font(.system(size: 13, weight: .semibold)).foregroundColor(Color("#513A10")).padding(.top, 10)
                    Text("My Issued").font(.system(size: 13, weight: .bold)).foregroundColor(Color("#513A10"))
                    Text("Books").font(.system(size: 13, weight: .bold)).foregroundColor(Color("#513A10"))
                }
                .background(Color("background"))
                .frame(width: 100, height: 140)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color("#513A10"), lineWidth: 3))
            }
        }
        .frame(width: 100, height: 115)
    }
}

struct ShelfOfTheDayView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Shelf of the Day")
                    .font(.headline)
                Spacer()
                Image(systemName: "bell").resizable().frame(width: 20, height: 20).padding(.trailing, 10)
            }
            Text("Selected by our curators")
                .font(.subheadline)
                .foregroundColor(.gray)
            Image("shelfBookCover").resizable().frame(height: 200).cornerRadius(10)
            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: Constant.meta) {
                    Text("Humanly Possible")
                      .font(
                        Font.custom("DM Sans", size: 16)
                          .weight(.bold)
                      )
                      .foregroundColor(Constant.Black)
                    Text("Sarah Bakewell")
                      .font(
                        Font.custom("DM Sans", size: 14)
                          .weight(.medium)
                      )
                      .foregroundColor(Constant.Black)
                    
                }
                Spacer()
                Image("fe_share")
                  .frame(width: 24, height: 24)
                
            }
            .frame(width: .infinity, alignment: .center)
            Text("Seven hundred Years of Humanist Freethinking, Inquiry, and Hope")
              .font(
                Font.custom("DM Sans", size: 14)
                  .weight(.medium)
              )
              .foregroundColor(Constant.Black)
              .frame(width: .infinity, alignment: .leading)
        }
        .cornerRadius(10)
    }
}

struct RecommendedForYouView: View {
    @StateObject private var viewModel = ExploreTabViewModel()
    var body: some View {
        ForEach(viewModel.contentSections) { section in
            BookContentView(section: section)
        }
        
    }
}

//struct LookOutForCategoriesView: View {
//    let books: [Book]
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text("Look Out for Categories")
//                .font(.title2)
//                .bold()
//            Text("We think you’ll like these")
//                .font(.subheadline)
//                .foregroundColor(.gray)
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 16) {
//                    ForEach(books) { book in
//                        BookView2(book: book)
//                    }
//                }
//                .padding(.horizontal)
//            }
//        }
//    }
//}

//struct TopAuthorsView: View {
//    let authors: [Author]
//
//    var body: some View {
//        VStack(alignment: .leading) {
//            HStack {
//                Text("Top Authors")
//                    .font(.title2)
//                    .bold()
//                Spacer()
//                Text("Show all")
//                    .foregroundColor(Color("#765511"))
//                    .underline()
//            }
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 16) {
//                    ForEach(authors) { author in
//                        AuthorView(author: author)
//                    }
//                }
//                .padding(.horizontal)
//            }
//        }
//    }
//}

// Models


// Supporting Views

struct BookCardView: View {
    let imageName: String
    let title: String
    let author: String
    let description: String

    var body: some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .frame(width: 100, height: 150)
                .cornerRadius(10)
            Text(title)
                .font(.headline)
            Text(author)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(description)
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(2)
        }
        .frame(width: 120)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct BookView2: View {
    let book: Book

    var body: some View {
        VStack(alignment: .leading) {
            Image(book.imageName)
                .resizable()
                .frame(width: 100, height: 150)
                .cornerRadius(10)
            Text(book.title)
                .font(.headline)
            Text(book.author)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(book.subtitle)
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(2)
        }
        .frame(width: 120)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct AuthorView: View {
    let author: Author

    var body: some View {
        VStack {
            Image(author.image)
                .resizable()
                .frame(width: 100, height: 100)
                .clipShape(Circle())
            Text(author.name)
                .font(.headline)
            Text(author.title)
                .font(.subheadline)
                .foregroundColor(.gray)
            Text(author.description)
                .font(.caption)
                .foregroundColor(.gray)
                .lineLimit(2)
        }
        .frame(width: 120)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

// Category Button


// Hex Color Extension

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0

        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let red = Double((rgbValue & 0xff0000) >> 16) / 255.0
        let green = Double((rgbValue & 0xff00) >> 8) / 255.0
        let blue = Double(rgbValue & 0xff) / 255.0

        self.init(red: red, green: green, blue: blue)
    }
}

#Preview{
    UserHomePage()
}
