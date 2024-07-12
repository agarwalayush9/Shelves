// UserScreen.swift
// Shelves-User
//
// Created by Jhanvi Jindal on 04/07/24.
//

import SwiftUI

struct UserHomePage: View {
    @State private var selectedCategory: String = ""
    let books: [Book] = [
        Book(id: UUID(), title: "Life 3.0", author: "Max Tegmark", subtitle: "Being Human in the Age of Artificial Intelligence", imageName: "bookCover"),
        Book(id: UUID(), title: "Life 3.0", author: "Max Tegmark", subtitle: "Being Human in the Age of Artificial Intelligence", imageName: "bookCover"),
        Book(id: UUID(), title: "Life 3.0", author: "Max Tegmark", subtitle: "Being Human in the Age of Artificial Intelligence", imageName: "bookCover")
        // Add more books as needed
    ]
    let authors: [Author] = [
            Author(name: "Stephen Hawking", title: "Stephen Hawking", description: "From the Bing Bang to Black Holes", image: "bookCover"),
            Author(name: "Stephen Hawking", title: "Stephen Hawking", description: "From the Bing Bang to Black Holes", image: "bookCover"),
            Author(name: "Stephen Hawking", title: "Stephen Hawking", description: "From the Bing Bang to Black Holes", image: "bookCover"),
            // Add more authors as needed
        ]
    var body: some View {
        ScrollView{
        
        ZStack {
            // Set the background color of the entire screen
            Color("background")
                .edgesIgnoringSafeArea(.all)

            VStack {
                // Header
                HStack {
                    Text("Shelves.")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                    Text("Updated one hour ago")
                        .font(.subheadline)
                }
                .padding()

                // Overdue Book and View My Rentals Section
                HStack(spacing: 20) {
                    // Book Overdue Section
                    HStack {
                        Image("bookCover") // Replace with your book cover image
                            .resizable()
                            .frame(width: 70, height: 100)
                        
                        VStack(alignment: .leading) {
                            Text("#4235532")
                                .font(.caption)
                                .foregroundColor(.red)
                                .padding(.top, -5)
                            Text("The Good Guy")
                                .font(.title3)
                            HStack{
                                Image("clock", bundle: nil).resizable().frame(width: 18,height: 18)
                                Text("Book Overdue")
                            }
                            
                                .font(.subheadline)
                            Text("Return before 29 May, Fines applied!")
                                .font(.caption)
                                .foregroundColor(.red)
                                .frame(width: 100, height: 35)
                        }
                    }
                    .padding()
                    .background(Color("background"))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(hex: "#513A10"), lineWidth: 3)
                    )

                    // View My Rentals Section
                    VStack {
                        //Spacer()
                        Button(action: {
                            // Action for "View My Rentals"
                        }) {
                            VStack {
                                Image("bookIcon", bundle: nil).resizable()
                                    .frame(width: 50, height: 50).padding(.horizontal,10)
                                Text("View")
                                    .font(.system(size: 13,weight: .semibold))
                                    .foregroundColor(Color(hex: "#513A10")).padding(.top,10)
                                    
                                Text("My Issued")
                                    .font(.system(size: 13,weight: .bold))
                                    .foregroundColor(Color(hex: "#513A10"))
                                    
                                Text("Books")
                                    .font(.system(size: 13,weight: .bold))
                                    .foregroundColor(Color(hex: "#513A10"))
                                    
                            }
                            .background(Color("background")).frame(width: 100,height: 140)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color(hex: "#513A10"), lineWidth: 3)
                            )
                        }
                    }
                    //.padding(.bottom, 9)
                    .frame(width: 100,height: 115)
                }
                .frame(height: 100) // Adjust the height if necessary
                .padding([.leading, .trailing, .top, .bottom])

                // Shelf of the Day Section
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Shelve of the Day")
                            .font(.headline)
                        Spacer()
                        Image(systemName: "bell") // Replace with your shelf book cover image
                            .resizable()
                            .frame(width: 20, height: 20)
                            .padding(.trailing, 10)
                    }
                    Text("Selected by our curators")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Image("shelfBookCover")
                        .resizable()
                        .frame(height: 200)
                        .cornerRadius(10)
                    Text("Humanly Possible")
                        .font(.title2)
                    Text("Sarah Bakewell")
                        .font(.subheadline)
                    Text("Seven hundred Years of Humanist Freethinking, Inquiry, and Hope")
                        .font(.caption)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding([.leading, .trailing, .top])

                
                ScrollView(.horizontal, showsIndicators: false){
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
                VStack(alignment: .leading) {
                            Text("Look Out for Categories")
                                .font(.headline)
                                .padding([.leading, .top])
                            
                            Text("We think you’ll like these")
                                .font(.subheadline)
                                .padding(.leading)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 16) {
                                    ForEach(books) { book in
                                        BookView2(book: book)
                                    }
                                }
                                .padding(.horizontal)
                            }
                            
                            Spacer()
                        }
                        .padding()
                    }
                }
                
            VStack(alignment: .leading) {
                // Top Book Recommendations Section
                VStack(alignment: .leading) {
                    Text("Recommended for You")
                        .font(.title2)
                        .bold()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            BookCardView(imageName: "life3_0", title: "Life 3.0", author: "Max Tegmark", description: "From the Bing Bang to Black Holes")
                            BookCardView(imageName: "history_time", title: "A Brief History of Time", author: "Stephen Hawking", description: "Ancient DNA and the New Science of the Human Past")
                            BookCardView(imageName: "who_we_are", title: "Who We Are and How We...", author: "David Reich", description: "From the Bing Bang to Black Holes")
                        }
                    }
                }
                .padding()
                
                // Categories Section
                VStack(alignment: .leading) {
                    HStack {
                        Text("Look Out for Categories")
                            .font(.title2)
                            .bold()
                        Spacer()
                        Text("More")
                            .foregroundColor(.blue)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            CategoryCardView(title: "Must Read Books", imageName: "life3_0")
                            CategoryCardView(title: "Must Read Books", imageName: "life3_0")
                        }
                    }
                }
                .padding()
                
                // Top Authors Section
                VStack(alignment: .leading) {
                    HStack {
                        Text("Top Authors")
                            .font(.title2)
                            .bold()
                        Spacer()
                        Text("More")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                VStack(alignment: .leading) {
                    HStack {
                        Text("Top Authors")
                            .font(.headline)
                        Spacer()
                        Text("More")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                    }
                    .padding([.leading, .trailing, .top])
                    
                    Text("We think you’ll like these")
                        .font(.subheadline)
                        .padding(.leading)
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(authors) { author in
                                AuthorView(author: author)
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
                
                
        }
    }
        
    
}


  
    
    struct AuthorView: View {
        let author: Author
        
        var body: some View {
            VStack(alignment: .center) {
                ZStack(alignment: .bottomTrailing) {
                    Image(author.image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                    
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .overlay(
                            Image(systemName: "heart")
                                .foregroundColor(.black)
                        )
                        .padding(8)
                }
                .frame(width: 120, height: 120)
                
                Text(author.name)
                    .font(.headline)
                    .lineLimit(1)
                    .padding(.top, 8)
                
                Text(author.title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(author.description)
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
            }
            .frame(width: 140)
        }
    }
    
}
    


struct BookCardView: View {
    var imageName: String
    var title: String
    var author: String
    var description: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 200)
                .cornerRadius(8)
            
            Text(title)
                .font(.headline)
                .lineLimit(1)
            
            Text(author)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(description)
                .font(.caption)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .frame(width: 150)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

struct CategoryCardView: View {
    var title: String
    var imageName: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 150)
                .cornerRadius(8)
            
            Text(title)
                .font(.headline)
                .lineLimit(1)
            
            Text("Being Human in the Ag...")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(width: 150)
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

struct BookView2: View {
    let book: Book
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(book.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 150, height: 200)
                .cornerRadius(8)
            
            Text(book.title)
                .font(.headline)
                .lineLimit(1)
                .padding(.top, 8)
            
            Text(book.author)
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Text(book.subtitle)
                .font(.footnote)
                .foregroundColor(.secondary)
                .lineLimit(2)
        }
        .frame(width: 150)
    }
}
                

                // Include the BottomNavigationBar
//                CustomTabbar()
//                    .ignoresSafeArea()


struct UserHomePage_Previews: PreviewProvider {
    static var previews: some View {
        UserHomePage()
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
