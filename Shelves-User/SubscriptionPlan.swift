//
//  SubscriptionPlan.swift
//  Shelves-User
//
//  Created by Suraj Singh on 08/07/24.
//

import SwiftUI

struct SubscriptionView: View {
    @State private var selectedPlan: String = "Monthly"
    @State private var selectedTier: String? = nil
    @State private var showUserHomePage: Bool = false
    
    // Data controller instance
    let dataController = DataController()
    
    // Subscription prices state
    @State private var bronzeSubscription: BronzeSubscription?
    @State private var silverSubscription: SilverSubscription?
    @State private var goldSubscription: GoldSubscription?
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Spacer().frame(height: 100) // For top padding
                
                Text("We offer Premium Access to our Users")
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30) // Left aligned
                
                Text("Choose a Plan")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30) // Left aligned
                
                Text("Select the offer that suits you the best")
                    .font(.system(size: 16))
                    .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    .padding(.bottom, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30) // Left aligned
                
                ZStack {
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color(red: 81/255, green: 58/255, blue: 16/255), lineWidth: 1)
                        .background(Color(red: 0.97, green: 0.91, blue: 0.82).cornerRadius(50))
                        .frame(height: 50).frame(width: 270)
                    
                    HStack {
                        Button(action: {
                            selectedPlan = "Monthly"
                            selectedTier = nil // Reset selected tier when plan changes
                        }) {
                            Text("Monthly")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(selectedPlan == "Monthly" ? Color(red: 81/255, green: 58/255, blue: 16/255) : Color.clear)
                                .foregroundColor(selectedPlan == "Monthly" ? .white : Color(red: 81/255, green: 58/255, blue: 16/255)).bold()
                                .cornerRadius(50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            selectedPlan = "Yearly"
                            selectedTier = nil // Reset selected tier when plan changes
                        }) {
                            Text("Yearly")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(selectedPlan == "Yearly" ? Color(red: 81/255, green: 58/255, blue: 16/255) : Color.clear)
                                .foregroundColor(selectedPlan == "Yearly" ? .white : Color(red: 81/255, green: 58/255, blue: 16/255)).bold()
                                .cornerRadius(50)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 30)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
                
                if let bronze = bronzeSubscription, let silver = silverSubscription, let gold = goldSubscription {
                    if selectedPlan == "Monthly" {
                        SubscriptionTierView(tierName: "Bronze", price: "₹\(bronze.monthly)/-", description: "Rent \(bronze.monthly) Books a Month", isSelected: selectedTier == "Bronze", details: [
                            "Access to limited collection",
                            "Access to few events",
                            "Standard support"
                        ]) {
                            selectedTier = selectedTier == "Bronze" ? nil : "Bronze"
                        }
                        
                        SubscriptionTierView(tierName: "Silver", price: "₹\(silver.monthly)/-", description: "Rent \(silver.monthly) Books a Month", isSelected: selectedTier == "Silver", details: [
                            "Access to extended collection",
                            "Normal passes for all events",
                            "Priority support"
                        ]) {
                            selectedTier = selectedTier == "Silver" ? nil : "Silver"
                        }
                        
                        SubscriptionTierView(tierName: "Gold", price: "₹\(gold.monthly)/-", description: "Rent \(gold.monthly) Books a Month", isSelected: selectedTier == "Gold", details: [
                            "Access to full collection",
                            "5 free audiobooks per month",
                            "Premium support"
                        ]) {
                            selectedTier = selectedTier == "Gold" ? nil : "Gold"
                        }
                    } else if selectedPlan == "Yearly" {
                        SubscriptionTierView(tierName: "Bronze", price: "₹\(bronze.yearly)/-", description: "Rent \(bronze.yearly) Books a Year", isSelected: selectedTier == "Bronze", details: [
                            "Access to limited collection",
                            "Access to few events",
                            "Standard support"
                        ]) {
                            selectedTier = selectedTier == "Bronze" ? nil : "Bronze"
                        }
                        
                        SubscriptionTierView(tierName: "Silver", price: "₹\(silver.yearly)/-", description: "Rent \(silver.yearly) Books a Year", isSelected: selectedTier == "Silver", details: [
                            "Access to extended collection",
                            "Normal passes for all events",
                            "Priority support"
                        ]) {
                            selectedTier = selectedTier == "Silver" ? nil : "Silver"
                        }
                        
                        SubscriptionTierView(tierName: "Gold", price: "₹\(gold.yearly)/-", description: "Rent \(gold.yearly) Books a Year", isSelected: selectedTier == "Gold", details: [
                            "Access to full collection",
                            "VIP passes for all events",
                            "Premium support"
                        ]) {
                            selectedTier = selectedTier == "Gold" ? nil : "Gold"
                        }
                    }
                } else {
                    // Placeholder while fetching data
                    Text("Loading...")
                        .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                        .font(.title2)
                        .padding()
                        .onAppear {
                            fetchSubscriptionPrices()
                        }
                }
                
                Spacer()
                
                Button(action: {
                    // Handle skip action
                }) {
                    Text("I don't want a subscription! Skip")
                        .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                        .padding().multilineTextAlignment(.center)
                    
                }
                .padding(.horizontal, 50)
                
                Button(action: {
                    if let tier = selectedTier {
                            // Determine the selected plan name
                            let selectedPlanName = selectedPlan == "Monthly" ? "\(tier) Monthly" : "\(tier) Yearly"
                            
                            // Retrieve user email from UserDefaults
                            if let userEmail = UserDefaults.standard.string(forKey: "email") {
                                DataController.shared.updateSubscriptionPlan(email: userEmail, newSubscriptionPlan: selectedPlanName) { result in
                                    switch result {
                                    case .success:
                                        print("Subscription plan updated successfully.")
                                        
                                        // Update subscription details
                                        switch tier {
                                        case "Bronze":
                                            if let bronze = bronzeSubscription {
                                                updateSubscription(tier: tier, monthly: bronze.monthly, yearly: bronze.yearly, activeUsers: bronze.activeUsers + 1)
                                            }
                                        case "Silver":
                                            if let silver = silverSubscription {
                                                updateSubscription(tier: tier, monthly: silver.monthly, yearly: silver.yearly, activeUsers: silver.activeUser + 1)
                                            }
                                        case "Gold":
                                            if let gold = goldSubscription {
                                                updateSubscription(tier: tier, monthly: gold.monthly, yearly: gold.yearly, activeUsers: gold.activeUsers + 1)
                                            }
                                        default:
                                            break
                                        }
                                        
                                        // Navigate to the user home page
                                        self.showUserHomePage = true
                                    case .failure(let error):
                                        print("Failed to update subscription plan: \(error.localizedDescription)")
                                        // Handle error scenario, show alert or retry logic
                                    }
                                }
                            } else {
                                // Handle case where email is not found in UserDefaults
                                print("User email not found.")
                                // Optionally, show an alert or UI indication for missing email
                            }
                        } else {
                            // Handle case where no tier is selected
                            print("Please select a subscription tier.")
                            // Optionally, show an alert or UI indication to select a tier
                        }
                    }) {
                    Text("Continue & Pay")
                        .foregroundColor(.white).bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 81/255, green: 58/255, blue: 16/255))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
                .navigationDestination(isPresented: $showUserHomePage) {
                    UserHomePage()
                        .navigationBarBackButtonHidden(true)
                }
                
                Text("You can cancel the subscription at any time from the app store at no additional cost and it will end at the end of the current period. By going further, you accept our terms of service, which lay down the details of your right of withdrawal.")
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 0.87, blue: 0.74), Color.white]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    private func fetchSubscriptionPrices() {
        // Fetch subscription prices asynchronously
        dataController.fetchBronzeSubscription { result in
            switch result {
            case .success(let subscription):
                DispatchQueue.main.async {
                    self.bronzeSubscription = subscription
                }
            case .failure(let error):
                print("Failed to fetch Bronze subscription: \(error.localizedDescription)")
            }
        }
        
        dataController.fetchSilverSubscription { result in
            switch result {
            case .success(let subscription):
                DispatchQueue.main.async {
                    self.silverSubscription = subscription
                }
            case .failure(let error):
                print("Failed to fetch Silver subscription: \(error.localizedDescription)")
            }
        }
        
        dataController.fetchGoldSubscription { result in
            switch result {
            case .success(let subscription):
                DispatchQueue.main.async {
                    self.goldSubscription = subscription
                }
            case .failure(let error):
                print("Failed to fetch Gold subscription: \(error.localizedDescription)")
            }
        }
    }
    
    private func updateSubscription(tier: String, monthly: Int, yearly: Int, activeUsers: Int) {
        switch tier {
        case "Bronze":
            dataController.updateBronzeSubscription(monthly: monthly, yearly: yearly, activeUsers: activeUsers) { result in
                switch result {
                case .success:
                    print("Bronze subscription updated successfully.")
                case .failure(let error):
                    print("Failed to update Bronze subscription: \(error.localizedDescription)")
                }
            }
        case "Silver":
            dataController.updateSilverSubscription(monthly: monthly, yearly: yearly, activeUser: activeUsers) { result in
                switch result {
                case .success:
                    print("Silver subscription updated successfully.")
                case .failure(let error):
                    print("Failed to update Silver subscription: \(error.localizedDescription)")
                }
            }
        case "Gold":
            dataController.updateGoldSubscription(monthly: monthly, yearly: yearly, activeUsers: activeUsers) { result in
                switch result {
                case .success:
                    print("Gold subscription updated successfully.")
                case .failure(let error):
                    print("Failed to update Gold subscription: \(error.localizedDescription)")
                }
            }
        default:
            break
        }
    }
}

struct SubscriptionTierView: View {
    let tierName: String
    let price: String
    let description: String
    let isSelected: Bool
    let details: [String]
    let action: () -> Void

    var body: some View {
        VStack {
            Button(action: action) {
                VStack {
                    HStack {
                        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(isSelected ? Color(red: 81/255, green: 58/255, blue: 16/255) : Color(red: 81/255, green: 58/255, blue: 16/255))

                        VStack(alignment: .leading) {
                            Text(tierName)
                                .font(.headline)
                                .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                            Text(description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }

                        Spacer()

                        Text(price)
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))

                        Image(systemName: isSelected ? "chevron.up" : "chevron.down")
                            .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    }
                    .padding()

                    if isSelected {
                        VStack(alignment: .leading, spacing: 5) {
                            ForEach(details, id: \.self) { detail in
                                Text("• \(detail)")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                    .frame(maxWidth: .infinity, alignment: .leading) // Left align details
                            }
                        }
                        .padding(.top, 0.1)
                        .padding(.bottom, 20).padding(.horizontal,40)
                    }
                }
                .background(RoundedRectangle(cornerRadius: 10).stroke(isSelected ? Color(red: 81/255, green: 58/255, blue: 16/255) : Color(red: 81/255, green: 58/255, blue: 16/255), lineWidth: 1))
                .padding(.horizontal, 20)
                .padding(.vertical, 5)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct SubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionView()
    }
}
