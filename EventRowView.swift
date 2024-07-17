//
//  EventRowView.swift
//  Shelves-User
//
//  Created by Jhanvi Jindal on 11/07/24.
//

import SwiftUI

struct EventRowView: View {
    var event: Event

    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
    
    private static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        HStack {
            Image(event.imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 8))
            
            VStack(alignment: .leading) {
                Text(event.name)
                    .font(.headline)
                
                Text("\(Self.dateFormatter.string(from: event.date)) at \(Self.timeFormatter.string(from: event.time))")
                    .font(.subheadline)
                
                Text(event.address)
                    .font(.subheadline)
                
                Text("Fees: ₹\(event.fees)") // Assuming fees is in Int type
                    .font(.subheadline)
            }
            .padding(.leading, 8)
        }
        .padding(.vertical, 8)
    }
}

struct EventRowView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleEvent = Event(
            name: "California Art Festival 2023",
            host: "Artistry Gallery",
            date: Date(),
            time: Date(),
            address: "Dana Point 29-30",
            duration: "2 days",
            description: "A celebration of art and creativity.",
            registeredMembers: [],
            tickets: 100,
            imageName: "eventImage",
            fees: 299,
            revenue: 0,
            status: "Upcoming"
        )
        
        return EventRowView(event: sampleEvent)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
