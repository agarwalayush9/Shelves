//
//  BorrowConfirmation.swift
//  Shelves-User
//
//  Created by Suraj Singh on 14/07/24.
//

import SwiftUI

struct BorrowConfirmationView: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        ZStack {
//            Color.white.edgesIgnoringSafeArea(.all) // Full-screen white background

            VStack(spacing: 20) {
                Text("Congratulations, Kunal")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundColor(.brown)

                Text("Your Book has been borrowed")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.brown)

                Image(systemName: "book.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.brown)

                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.brown)
                        Text("Jul 17, 2023")
                            .font(.body)
                            .foregroundColor(.brown)
                    }

                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.brown)
                        Text("Shelves Library")
                            .font(.body)
                            .foregroundColor(.brown)
                    }
                }

                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
                        .font(.body)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.brown)
                        .cornerRadius(10)
                }
                .padding(.top, 20)
            }
            .padding()
//            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding(.horizontal, 20)
        }.background(LinearGradient(gradient: Gradient(colors: [Color(red: 1.0, green: 0.87, blue: 0.7), Color.white]),
                                 startPoint: .top,
                                    endPoint: .bottom)).ignoresSafeArea()
    }
}

struct BorrowConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        BorrowConfirmationView()
    }
}

