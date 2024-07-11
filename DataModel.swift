//
//  DataModel.swift
//  Shelves-User
//
//  Created by Jhanvi Jindal on 11/07/24.
//

import Foundation
struct Event: Identifiable {
    let id = UUID()
    let title: String
    let date: String
    let time: String
    let location: String
    let price: String
    let imageName: String
}
