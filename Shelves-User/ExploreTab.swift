import SwiftUI

struct ExploreTab: View {
    @StateObject private var viewModel = ExploreTabViewModel()
    @State private var selectedCategory: String = ""
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 20) {
                HStack(alignment: .center, spacing: 15) {
                    VStack(alignment: .leading, spacing: 7) {
                        Text("Explore")
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .bold()
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 50, height: 5)  // Adjusted height
                            .background(Color(red: 0.32, green: 0.23, blue: 0.06))
                            .alignmentGuide(.leading) { _ in 0 }
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                
                ScrollView {
                    SearchBar()
                        .padding(.horizontal)
                    
                    HStack {
                        Text("Categories")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top, 5)
                        Spacer()
                    }
                    .padding(.top)
                    
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
                    
                    ForEach(viewModel.contentSections) { section in
                        BookContentView(section: section)
                            .padding(.top)
                    }
                    
                    Spacer()
                }
                .padding(.top, 0)
                .padding(.bottom, 20)
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.87, blue: 0.7), Color.white]),
                               startPoint: .top,
                               endPoint: .bottom)
            )
            .navigationBarHidden(true)
        }
    }
}

struct SearchBar: View {
    @State private var searchText = ""
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.brown)
                .padding(.leading, 10)
            
            TextField("Search Title, author or topic", text: $searchText)
                .foregroundColor(.primary)
                .padding(10)
        }
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.brown, lineWidth: 2)
        )
    }
}

struct CategoryButton: View {
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

struct BookView: View {
    var title: String
    var author: String
    var subtitle: String
    var imageName: String
    
    var body: some View {
        NavigationLink(destination: CustomBookDetailView(title: title, author: author, subtitle: subtitle)) {
            VStack(alignment: .leading) {
                ZStack {
                    Image("Ellipse 2")
                        .frame(width: 161.58664, height: 81.00001)
                        .offset(y: 55)
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 104, height: 156)
                        .background(
                            Image("bookCover")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 104, height: 156)
                                .clipped()
                        )
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
                    
                    Text(subtitle)
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                }
            }
            .frame(width: 161)
        }
    }
}

struct ExploreTab_Previews: PreviewProvider {
    static var previews: some View {
        ExploreTab()
    }
}
