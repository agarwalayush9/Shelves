//
//  GenereSelectionView.swift
//  Shelves-User
//
//  Created by Suraj Singh on 05/07/24.
//

//import SwiftUI
//
//struct GenreSelectionView: View {
//    @State private var selectedGenres: [String] = []
//    @State private var showUserHomePage = false
//
//    let genres = [
//        "Horror", "Historical Fiction", "Fiction", "Non-fiction", "Novel",
//        "Children's Literature", "Sci-Fi", "Narrative", "Biography", "Mystery",
//        "Autobiography", "Poetry", "Thriller", "Crime", "History", "Romantic",
//        "Stories", "Cookbook"
//    ]
//
//    var body: some View {
//        NavigationView {
//            ZStack {
//                // Custom Background Rectangle
//                Rectangle()
//                    .foregroundColor(.clear)
//                    .frame(width: 400, height: 300) // Adjusted height
//                    .background(Color(red: 0.32, green: 0.23, blue: 0.06).opacity(0.2))
//                    .cornerRadius(10)
//                    .blur(radius: 114.03785)
//                    .opacity(0.8)
//                    .offset(y: -30) // Move the rectangle up
//
//                LinearGradient(
//                    gradient: Gradient(colors: [Color(red: 1.0, green: 0.9, blue: 0.7), Color(red: 1.0, green: 0.8, blue: 0.5)]),
//                    startPoint: .top,
//                    endPoint: .bottom
//                )
//                .edgesIgnoringSafeArea(.all)
//
//                VStack {
//                    Text("Select Genres")
//                        .font(.largeTitle)
//                        .fontWeight(.bold)
//                        .padding(.top, 60) // Adjusted top padding
//
//                    Text("Select the type of book you enjoy reading.")
//                        .font(.subheadline)
//                        .padding(.bottom)
//
//                    VStack {
//                        LazyVGrid(columns: [
//                            GridItem(.flexible(), spacing: 10),
//                            GridItem(.flexible(), spacing: 10)
//                        ], spacing: 8) {
//                            ForEach(genres, id: \.self) { genre in
//                                GenreButton(genre: genre, isSelected: self.selectedGenres.contains(genre)) {
//                                    if self.selectedGenres.contains(genre) {
//                                        self.selectedGenres.removeAll { $0 == genre }
//                                    } else {
//                                        self.selectedGenres.append(genre)
//                                    }
//                                }
//                            }
//                        }
//                        .padding()
//                        .frame(maxWidth: .infinity, maxHeight: calculateHeight() - 20) // Adjust height
//                    }
//                    .padding()
//                    .background(
//                        LinearGradient(
//                            gradient: Gradient(colors: [Color(red: 1.0, green: 0.9, blue: 0.7), Color(red: 1.0, green: 0.8, blue: 0.5)]),
//                            startPoint: .top,
//                            endPoint: .bottom
//                        )
//                    )
//                    .padding()
//
//                    Spacer(minLength: 5) // Decreased minimum length spacer to push down the button
//
//                    Button(action: {
//                        // Action for continue button
//                        self.showUserHomePage = true
//                    }) {
//                        Text("Continue")
//                            .foregroundColor(.white)
//                            .padding()
//                            .frame(maxWidth: .infinity)
//                            .background(self.selectedGenres.count >= 3 ? Color(UIColor(red: 0.66, green: 0.46, blue: 0.28, alpha: 1.0)) : Color.gray)
//                            .cornerRadius(10)
//                    }
//                    .padding(.horizontal)
//                    .padding(.bottom, 5) // Adjusted bottom padding
//                    .disabled(self.selectedGenres.count < 3)
//                    .fullScreenCover(isPresented: $showUserHomePage) {
//                        UserHomePage()
//                    }
//
//                    Text("Select 3 or more genres to continue")
//                        .font(.subheadline)
//                        .foregroundColor(Color(UIColor(red: 0.66, green: 0.46, blue: 0.28, alpha: 1.0)))
//                        .padding(.bottom, 20) // Adjusted bottom padding
//                        .frame(maxWidth: .infinity)
//
//                    Spacer() // Added additional spacer to push content to the top
//                }
//                .padding()
//                .background(
//                    LinearGradient(
//                        gradient: Gradient(colors: [Color(red: 1.0, green: 0.9, blue: 0.7), Color(red: 1.0, green: 0.8, blue: 0.5)]),
//                        startPoint: .top,
//                        endPoint: .bottom
//                    )
//                )
//            }
//        }
//    }
//
//    private func calculateHeight() -> CGFloat {
//        let rows = (genres.count + 1) / 2 // Each row has 2 items
//        let itemHeight: CGFloat = 50
//        let spacing: CGFloat = 10 // Reduced spacing to 10
//        let totalHeight = (CGFloat(rows) * itemHeight) + (CGFloat(rows - 1) * spacing)
//        return totalHeight
//    }
//}
//
//struct GenreButton: View {
//    var genre: String
//    var isSelected: Bool
//    var action: () -> Void
//
//    var body: some View {
//        Button(action: action) {
//            HStack(alignment: .center, spacing: 8) { // Set spacing to 8
//                Text(genre)
//                    .font(.system(size: 12))
//                    .fontWeight(isSelected ? .bold : .regular)
//                    .lineLimit(1) // Ensures text is in a single line
//                    .fixedSize(horizontal: true, vertical: false) // Prevents text from shrinking
//                Image(systemName: isSelected ? "checkmark.circle.fill" : "plus.circle")
//                    .foregroundColor(isSelected ? Color(UIColor(red: 0.66, green: 0.46, blue: 0.28, alpha: 1.0)) : Color.gray) // Icon color
//            }
//            .padding(.horizontal, 16)
//            .padding(.vertical, 12)
//            .frame(height: 42, alignment: .leading)
//            .background(isSelected ? Color(UIColor(red: 0.66, green: 0.46, blue: 0.28, alpha: 0.2)) : Color.clear) // Selected background color
//            .cornerRadius(20)
//            .overlay(
//                RoundedRectangle(cornerRadius: 20)
//                    .inset(by: 1.5)
//                    .stroke(Color(red: 0.32, green: 0.23, blue: 0.06), lineWidth: 3) // Border color
//            )
//            .multilineTextAlignment(.center)
//        }
//        .foregroundColor(Color(UIColor(red: 0.66, green: 0.46, blue: 0.28, alpha: 1.0))) // Text color
//    }
//}
//
//struct GenreSelectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        GenreSelectionView()
//    }
//}
import SwiftUI

struct GenreSelectionView: View {
    @State private var selectedGenres: [String] = []
    @State private var showUserHomePage = false

    let genres = [
        "Horror", "Historical Fiction", "Fiction", "Non-fiction", "Novel",
        "Children's Literature", "Sci-Fi", "Narrative", "Biography", "Mystery",
        "Autobiography", "Poetry", "Thriller", "Crime", "History", "Romantic",
        "Stories", "Cookbook"
    ]

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(red: 1.0, green: 0.9, blue: 0.7), Color(red: 1.0, green: 0.8, blue: 0.5)]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                Rectangle()
                    .fill(Color(red: 0.32, green: 0.23, blue: 0.06).opacity(0.2))
                    .frame(width: 400, height: 300)
                    .cornerRadius(10)
                    .blur(radius: 10)
                    .opacity(10.0)
                    .offset(y: -30)

                VStack {
                    Text("Select Genres")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.top, 60)

                    Text("Select the type of book you enjoy reading.")
                        .font(.subheadline)
                        .padding(.bottom)

                    VStack {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 10),
                            GridItem(.flexible(), spacing: 10)
                        ], spacing: 8) {
                            ForEach(genres, id: \.self) { genre in
                                GenreButton(genre: genre, isSelected: self.selectedGenres.contains(genre)) {
                                    if self.selectedGenres.contains(genre) {
                                        self.selectedGenres.removeAll { $0 == genre }
                                    } else {
                                        self.selectedGenres.append(genre)
                                    }
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity, maxHeight: calculateHeight() - 20)
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(red: 1.0, green: 0.9, blue: 0.7), Color(red: 1.0, green: 0.8, blue: 0.5)]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .padding()

                    Spacer(minLength: 5) //

                    Button(action: {
                        
                        self.showUserHomePage = true
                    }) {
                        Text("Continue")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(self.selectedGenres.count >= 3 ? Color(UIColor(red: 0.66, green: 0.46, blue: 0.28, alpha: 1.0)) : Color.gray)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 5) //
                    .disabled(self.selectedGenres.count < 3)
                    .fullScreenCover(isPresented: $showUserHomePage) {
                        UserHomePage()
                    }

                    Text("Select 3 or more genres to continue")
                        .font(.subheadline)
                        .foregroundColor(Color(UIColor(red: 0.66, green: 0.46, blue: 0.28, alpha: 1.0)))
                        .padding(.bottom, 20) // Adjusted bottom padding
                        .frame(maxWidth: .infinity)

                    Spacer() 
                }
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(red: 1.0, green: 0.9, blue: 0.7), Color(red: 1.0, green: 0.8, blue: 0.5)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
        }
    }

    private func calculateHeight() -> CGFloat {
        let rows = (genres.count + 1) / 2 // Each row has 2 items
        let itemHeight: CGFloat = 50
        let spacing: CGFloat = 10 // Reduced spacing to 10
        let totalHeight = (CGFloat(rows) * itemHeight) + (CGFloat(rows - 1) * spacing)
        return totalHeight
    }
}

struct GenreButton: View {
    var genre: String
    var isSelected: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(alignment: .center, spacing: 8) { // Set spacing to 8
                Text(genre)
                    .font(.system(size: 12))
                    .fontWeight(isSelected ? .bold : .regular)
                    .lineLimit(1) // Ensures text is in a single line
                    .fixedSize(horizontal: true, vertical: false) // Prevents text from shrinking
                Image(systemName: isSelected ? "checkmark.circle.fill" : "plus.circle")
                    .foregroundColor(isSelected ? Color(UIColor(red: 0.66, green: 0.46, blue: 0.28, alpha: 1.0)) : Color.gray) // Icon color
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(height: 42, alignment: .leading)
            .background(isSelected ? Color(UIColor(red: 0.66, green: 0.46, blue: 0.28, alpha: 0.2)) : Color.clear) // Selected background color
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 1.5)
                    .stroke(Color(red: 0.32, green: 0.23, blue: 0.06), lineWidth: 3) // Border color
            )
            .multilineTextAlignment(.center)
        }
        .foregroundColor(Color(UIColor(red: 0.66, green: 0.46, blue: 0.28, alpha: 1.0))) // Text color
    }
}

struct GenreSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GenreSelectionView()
    }
}

