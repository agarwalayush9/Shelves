import SwiftUI
import URLImage

struct Constant {
    static let meta: CGFloat = 4
    static let Black: Color = .black
}

struct UserHomePage: View {
    @StateObject private var viewModel = BooksViewModel()
    @State private var selectedIndex = 0
    @State private var selectedCategory: String = ""

    var body: some View {
        NavigationView {
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
                                .frame(width: 50, height: Constant.meta)
                                .background(Color(red: 0.32, green: 0.23, blue: 0.06))
                                .frame(alignment: .leading)
                        }
                        Spacer()
                    }
                    .padding()
                    
                    ScrollView {
                        if let shelfOfTheDay = viewModel.shelfOfTheDay {
                            
                            ShelfOfTheDayView(book: shelfOfTheDay)
                                .padding([.top, .leading, .bottom, .trailing])
                        }

                        // Recommended for You Section
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            ForEach(viewModel.booksByGenre.keys.sorted(), id: \.self) { genre in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Text(genre)
                                            .font(.title2)
                                            .padding(.leading)
                                        Spacer()
                                        NavigationLink(destination: GenreBooksView(genre: genre, books: viewModel.booksByGenre[genre] ?? [])) {
                                            Text("Show More")
                                                .font(.subheadline)
                                                .padding(.trailing)
                                        }
                                    }
                                    ScrollView(.horizontal) {
                                        HStack {
                                            ForEach(viewModel.booksByGenre[genre] ?? []) { book in
                                                VStack {
                                                    if let url = URL(string: book.imageName) {
                                                        NavigationLink(destination: CustomBookDetailView(title: book.title, author: book.author, subtitle: book.subtitle, url: book.imageName, rating: book.rating, genre: book.categories)) {
                                                            AsyncImage(url: url)
                                                                .frame(width: 100, height: 150)
                                                                .cornerRadius(8)
                                                        }
                                                    }
                                                    Text(book.title)
                                                        .font(.caption)
                                                        .frame(width: 100)
                                                        .multilineTextAlignment(.center)
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                    }.padding(.bottom)
                                }
                            }
                        }
                    }
                    .refreshable {
                        viewModel.fetchGenresAndBooks()
                    }
                }
            }
            .onAppear {
                viewModel.fetchGenresAndBooks()
            }
        }
    }
}

struct ShelfOfTheDayView: View {
    let book: GBook

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text("Shelf of the Day")
                    .font(.headline)
                Spacer()
                NavigationLink(destination: CustomBookDetailView(title: book.title, author: book.author, subtitle: book.subtitle, url: book.imageName, rating: book.rating, genre: book.categories)) {
                    Image(systemName: "chevron.right")
                }
                    
            }
            Text("Selected by our curators")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            GeometryReader { geometry in
                ZStack {
                    CustomHalfCircle()
                        .fill(.gray).opacity(0.5)
                        .frame(height: geometry.size.width / 16)
                        .frame(width: 280)
                        .offset(y: geometry.size.width / 4)
                        .padding(.horizontal, 35).padding(.top,20) // Adjust the offset to position the half-circle correctly

                    if let url = URL(string: book.imageName) {
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
                                
                                  
                            )}
                }
            }
            .frame(height: 200)
            .padding(.bottom)
            .padding(.top)

            HStack(alignment: .center) {
                VStack(alignment: .leading, spacing: Constant.meta) {
                    Text("\(book.title)")
                        .font(.headline)
                        .foregroundColor(Constant.Black)
                    Text("by~ \(book.author)")
                        .font(.custom("DM Sans", size: 14).weight(.medium))
                        .foregroundColor(Constant.Black)
                }
                Spacer()
//                Image(systemName: "chevron.right")
//                    .frame(width: 24, height: 24)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            Text(book.subtitle)
                .font(.custom("DM Sans", size: 14).weight(.medium))
                .foregroundColor(Constant.Black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .lineLimit(4)
        }
        .cornerRadius(10)
    }
}

struct RecommendedForYouView: View {
    let books: [GBook]
    
    var body: some View {
        ForEach(books) { book in
            BookCardView(
                imageName: book.imageName,
                title: book.title,
                author: book.author,
                description: book.subtitle,
                rating: book.rating
                , genre: book.categories
                
            )
        }
    }
}

struct CategoryButton1: View {
    var title: String
    var icon: String
    var isSelected: Bool
    var backgroundColor: Color
    var textColor: Color
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(textColor)
                Text(title)
                    .foregroundColor(textColor)
            }
            .padding()
            .background(backgroundColor)
            .cornerRadius(35)
            .overlay(
                RoundedRectangle(cornerRadius: 35)
                    .stroke(Color.brown, lineWidth: 1)
            )
        }
    }
}

struct GenreBooksView: View {
    let genre: String
    let books: [GBook]

    let columns = [
           GridItem(.flexible()),
           GridItem(.flexible())
       ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(books) { book in
                    BookCardView(
                        imageName: book.imageName,
                        title: book.title,
                        author: book.author,
                        description: book.subtitle,
                        rating: book.rating,
                        genre: book.categories
                    )
                }
            }
            .padding()
        }
        .navigationTitle(genre)
    }
}

struct UserHomePage_Previews: PreviewProvider {
    static var previews: some View {
        UserHomePage()
    }
}

struct BookCardView: View {
    let imageName: String
    let title: String
    let author: String
    let description: String
    let rating: Double
    let genre: [String]
    
    var body: some View {
        NavigationLink(destination: CustomBookDetailView(title: title, author: author, subtitle: description, url: imageName,rating: rating, genre: genre)) {
            VStack(alignment: .leading) {
                ZStack {
                    Image("Ellipse 2")
                        .frame(width: 161.58664, height: 81.00001)
                        .offset(y: 55)
                    if let url = URL(string: imageName) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 104, height: 156)
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
                                            .cornerRadius(10)
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 104, height: 156)
                                            .clipped()
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .cornerRadius(10)
                                            .aspectRatio(contentMode: .fill)
                                            .frame(width: 104, height: 156)
                                            .clipped()
                                    @unknown default:
                                        Image(systemName: "photo")
                                            .cornerRadius(10)
                                            .frame(width: 104, height: 156)
                                            .clipped()
                                    }
                                }
                            )
                    }
                }
                .padding(.bottom, 20)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.headline)
                        .lineLimit(1)
                        .foregroundColor(.black)
                    
                    Text(author)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            .frame(width: 161)
        }
    }
}
