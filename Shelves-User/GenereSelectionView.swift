//
//  GenereSelectionView.swift
//  Shelves-User
//
//  Created by Suraj Singh on 05/07/24.
//

import SwiftUI
import FirebaseAuth

struct GenreSelectionView: View {
    @State private var selectedGenres: [Genre] = []
    @State private var navigateToSubscriptionView = false
    @State private var userEmail: String?

    let genres: [Genre] = [
        .Horror, .HistoricalFiction, .Fiction, .NonFiction, .Literature,
        .YoungAdult, .ScienceFiction, .Romance, .Psychology, .SelfHelp,
        .Mystery
    ]

    var body: some View {
        NavigationStack {
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
                                GenreButton(genre: genre.rawValue, isSelected: self.selectedGenres.contains(genre)) {
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
                    
                    Spacer(minLength: 5)
                    
                    if self.selectedGenres.count >= 3 {
                        NavigationLink(destination: SubscriptionView(), isActive: $navigateToSubscriptionView) {
                            EmptyView()
                        }
                        .hidden()
                        
                        Button(action: {
                                                   // Get current user's email using FirebaseAuth
                            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                                self.userEmail = userEmail
                                                       // Call updateMemberGenre function
                                    DataController.shared.updateMemberGenre(email: userEmail, selectedGenres: self.selectedGenres) { result in
                                                           switch result {
                                                           case .success:
                                                               print("Genres updated successfully.")
                                                               // Set navigateToSubscriptionView to true to navigate
                                                               self.navigateToSubscriptionView = true
                                                           case .failure(let error):
                                                               print("Failed to update genres: \(error.localizedDescription)")
                                                               // Handle error
                                                           }
                                                       }
                                                   } else {
                                                       print("User not authenticated or email not found.")
                                                       // Handle scenario where user is not authenticated
                                                   }
                        }) {
                            Text("Continue")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(UIColor(red: 0.66, green: 0.46, blue: 0.28, alpha: 1.0)))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 5)
                    } else {
                        Text("Continue")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.brown)
                            .cornerRadius(10)
                            .padding(.horizontal)
                            .padding(.bottom, 5)
                            .disabled(true)
                    }
                    
                    Text("Select 3 or more genres to continue")
                        .font(.subheadline)
                        .foregroundColor(Color(UIColor(red: 0.66, green: 0.46, blue: 0.28, alpha: 1.0)))
                        .padding(.bottom, 20)
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
            HStack(alignment: .center, spacing: 8) {
                Text(genre)
                    .font(.system(size: 12))
                    .fontWeight(isSelected ? .bold : .regular)
                    .lineLimit(1)
                    .fixedSize(horizontal: true, vertical: false)
                Image(systemName: isSelected ? "checkmark.circle.fill" : "plus.circle")
                    .foregroundColor(isSelected ? Color(UIColor(red: 0.66, green: 0.46, blue: 0.28, alpha: 1.0)) : Color.gray)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .frame(height: 42, alignment: .leading)
            .background(isSelected ? Color(UIColor(red: 0.66, green: 0.46, blue: 0.28, alpha: 0.2)) : Color.clear)
            .cornerRadius(20)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .inset(by: 1.5)
                    .stroke(Color(red: 0.32, green: 0.23, blue: 0.06), lineWidth: 3)
            )
            .multilineTextAlignment(.center)
        }
        .foregroundColor(Color(UIColor(red: 0.66, green: 0.46, blue: 0.28, alpha: 1.0)))
    }
}

struct GenreSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        GenreSelectionView()
    }
}
