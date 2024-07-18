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

                SearchBarr()
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

    
    
struct SearchBarr: View {
    @StateObject private var viewModel = BooksViewModell()
    @StateObject private var speechRecognizer = SpeechRecognizer()
    @State private var isListening = false

    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search Title, author or topic", text: $viewModel.searchText)
                    .onChange(of: speechRecognizer.recognizedText) { newText in
                        viewModel.searchText = newText
                    }
                Button(action: {
                    isListening.toggle()
                    if isListening {
                        speechRecognizer.startRecording()
                    } else {
                        speechRecognizer.stopRecording()
                    }
                }) {
                    Image(systemName: isListening ? "mic.fill" : "mic")
                        .foregroundColor(isListening ? .red : .gray)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.brown, lineWidth: 2)
            )

            List(viewModel.books, id: \.id) { book in
                VStack(alignment: .leading) {
                    Text(book.volumeInfo.title)
                        .font(.headline)
                    if let authors = book.volumeInfo.authors {
                        Text(authors.joined(separator: ", "))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    if let thumbnailLink = book.volumeInfo.imageLinks?.thumbnail,
                       let thumbnailURL = URL(string: thumbnailLink) {
                        AsyncImageVieww(url: thumbnailURL)
                            .frame(width: 100, height: 150)
                            .cornerRadius(8)
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .frame(width: 100, height: 150)
                            .cornerRadius(8)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.vertical)
            }
            .listStyle(PlainListStyle())

            Spacer()
        }
        .padding()
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

