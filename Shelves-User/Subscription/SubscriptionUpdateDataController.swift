// SubscriptionDataController.swift
// Shelves-User
//
// Created by Suraj Singh on 11/07/24.


// SubscriptionDataController.swift
// Shelves-User
//
// Created by Suraj Singh on 11/07/24.

import Foundation

class SubscriptionUpdateDataController: ObservableObject {
    @Published var currentPlan: String = "Monthly"
    @Published var currentTier: String = "Gold"
    @Published var selectedPlan: String = "Monthly"
    @Published var selectedTier: String? = nil
    @Published var showConfirmation: Bool = false
    
    var tiers: [SubscriptionTier] {
        if selectedPlan == "Yearly" {
            if currentPlan == "Yearly" /*&& currentTier == currentTier*/ {
                return SubscriptionTiersData.yearlyTiers.filter { $0.name != currentTier }
            } else {
                return SubscriptionTiersData.yearlyTiers
            }
        } else { // Monthly selected
            if currentPlan == "Monthly" /*&& currentTier == currentTier*/ {
                return SubscriptionTiersData.monthlyTiers.filter { $0.name != currentTier }
            } else {
                return SubscriptionTiersData.monthlyTiers
            }
        }
    }
    
    func updateSubscription() {
        // Logic to update the subscription
        showConfirmation = true
    }
}
