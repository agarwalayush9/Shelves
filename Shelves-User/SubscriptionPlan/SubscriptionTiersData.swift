// SubscriptionTiersData.swift
// Shelves-User
//
// Created by Suraj Singh on 11/07/24.
//

import Foundation

struct SubscriptionTier: Identifiable {
    let id: String
    let name: String
    let price: String
    let description: String
    let details: [String]
    var isSelected: Bool // To track selection state
}

struct SubscriptionTiersData {
    static let monthlyTiers: [SubscriptionTier] = [
        SubscriptionTier(
            id: "bronze-monthly",
            name: "Bronze",
            price: "Free",
            description: "Rent 5 Books a Month",
            details: [
                "Access to limited collection",
                "Access to few events",
                "Standard support"
            ],
            isSelected: false
        ),
        SubscriptionTier(
            id: "silver-monthly",
            name: "Silver",
            price: "₹399/-",
            description: "Rent 10 Books a Month",
            details: [
                "Access to extended collection",
                "Normal passes for all events",
                "Priority support"
            ],
            isSelected: false
        ),
        SubscriptionTier(
            id: "gold-monthly",
            name: "Gold",
            price: "₹599/-",
            description: "Rent 25 Books a Month",
            details: [
                "Access to full collection",
                "5 free audiobooks per month",
                "Premium support"
            ],
            isSelected: false
        )
    ]
    
    static let yearlyTiers: [SubscriptionTier] = [
        SubscriptionTier(
            id: "bronze-yearly",
            name: "Bronze",
            price: "₹2999/-",
            description: "Rent 60 Books a Year",
            details: [
                "Access to limited collection",
                "Access to few events",
                "Standard support"
            ],
            isSelected: false
        ),
        SubscriptionTier(
            id: "silver-yearly",
            name: "Silver",
            price: "₹3999/-",
            description: "Rent 120 Books a Year",
            details: [
                "Access to extended collection",
                "Normal passes for all events",
                "Priority support"
            ],
            isSelected: false
        ),
        SubscriptionTier(
            id: "gold-yearly",
            name: "Gold",
            price: "₹5999/-",
            description: "Rent 300 Books a Year",
            details: [
                "Access to full collection",
                "VIP passes for all events",
                "Premium support"
            ],
            isSelected: false
        )
    ]
    
    static func filterTiers(by type: SubscriptionType, selectedTier: String?) -> [SubscriptionTier] {
        let allTiers = (type == .monthly) ? monthlyTiers : yearlyTiers
        return allTiers.map { tier in
            var updatedTier = tier
            updatedTier.isSelected = selectedTier == tier.name
            return updatedTier
        }
    }
}

enum SubscriptionType {
    case monthly
    case yearly
}
