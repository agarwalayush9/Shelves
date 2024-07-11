//
//  EventRowView.swift
//  Shelves-User
//
//  Created by Jhanvi Jindal on 11/07/24.
//

import SwiftUI

import SwiftUI

struct EventRowView: View {
    var event: Event

    var body: some View {
        HStack {
            Image(event.imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                Text(event.title)
                    .font(.headline)
                Text("\(event.date) at \(event.time)")
                    .font(.subheadline)
                Text(event.location)
                    .font(.subheadline)
                Text(event.price)
                    .font(.subheadline)
            }
            .padding(.leading, 8)
        }
        .padding(.vertical, 8)
    }
}

struct EventRowView_Previews: PreviewProvider {
    static var previews: some View {
        EventRowView(event: Event(title: "California Art Festival 2023", date: "July 31", time: "07:30 PM", location: "Dana Point 29-30", price: "₹299", imageName: "eventImage"))
            .previewLayout(.sizeThatFits)
    }
}



