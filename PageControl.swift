//
//  PageControl.swift
//  Shelves-User
//
//  Created by Suraj Singh on 04/07/24.
//

import SwiftUI

struct PageControl: View {
    var numberOfPages: Int
    @Binding var currentPage: Int
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<numberOfPages, id: \.self) { index in
                Circle()
                    .fill(index == currentPage ? Color(red: 0.4, green: 0.2, blue: 0.1) : Color.white)
                    .frame(width: 10, height: 10)
                    .overlay(
                        Circle()
                            .stroke(Color(red: 0.4, green: 0.2, blue: 0.1), lineWidth: 1)
                    )
                    .onTapGesture {
                        currentPage = index
                    }
            }
        }
    }
}

struct PageControl_Previews: PreviewProvider {
    static var previews: some View {
        PageControl(numberOfPages: 3, currentPage: .constant(0))
    }
}

