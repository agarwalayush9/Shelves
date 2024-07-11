//
//  Events.swift
//  Shelves-User
//
//  Created by Anay Dubey on 11/07/24.
//

import SwiftUI

struct Events: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.brown)
                .frame(width: 350, height: 150)

            VStack(spacing: 10) {
                HStack(spacing: 10) {
                    Image("bookshelf") // Replace "bookshelf" with the actual name of your image file
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                    
                    VStack(alignment: .leading) {
                        Text("California Art Festival 2023")
                            .font(.headline)
                            .fontWeight(.bold)
                        Text("Dana Point 29-30")
                            .font(.subheadline)
                    }
                }
                
                Spacer()
                
                HStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Time")
                            .font(.subheadline)
                        Text("10:00 PM")
                            .font(.headline)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("Location")
                            .font(.subheadline)
                        Text("California, CA")
                            .font(.headline)
                    }
                }
                
                Spacer()
                
                Button(action: {
                    // Handle button tap here
                }) {
                    Text("Premium ticket x1")
                        .foregroundColor(.white)
                        .padding()
                        .background(.brown)
                        .cornerRadius(10)
                }
                .padding(.bottom, 10)
            }
            .padding()
            .foregroundColor(.white)
        }
    }
}

struct Events_Previews: PreviewProvider {
    static var previews: some View {
        Events()
    }
}
