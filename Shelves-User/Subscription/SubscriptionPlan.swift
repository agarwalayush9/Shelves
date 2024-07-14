//
//  SubscriptionPlan.swift
//  Shelves-User
//
//  Created by Suraj Singh on 08/07/24.
//
// SubscriptionView.swift

import SwiftUI

struct SubscriptionView: View {
    @State private var selectedPlan: String = "Monthly"
    @State private var selectedTier: String? = nil
    @State private var showCustomTabbar: Bool = false

    var body: some View {
        NavigationStack {
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

                let tiers = selectedPlan == "Monthly" ? SubscriptionTiersData.monthlyTiers : SubscriptionTiersData.yearlyTiers
                
                ForEach(tiers) { tier in
                    SubscriptionTierView(tierName: tier.name, price: tier.price, description: tier.description, isSelected: selectedTier == tier.name, details: tier.details) {
                        selectedTier = selectedTier == tier.name ? nil : tier.name
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
                    // Handle continue and pay action
                    self.showCustomTabbar = true
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
                .disabled(selectedTier == nil) // Disable the button if no tier is selected
                .navigationDestination(isPresented: $showCustomTabbar) {
                    CustomTabbar()
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
        .navigationBarBackButtonHidden(true)
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

struct SubscriptionView_Previews: PreviewProvider{
    static var previews: some View {
        SubscriptionView()
    }
}
