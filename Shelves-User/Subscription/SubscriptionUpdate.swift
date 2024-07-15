// SubscriptionUpdate.swift
//  Shelves-User
//
//  Created by Suraj Singh on 11/07/24.
//


// SubscriptionUpdate.swift
// Shelves-User
//
// Created by Suraj Singh on 11/07/24.

import SwiftUI

struct UpdateSubscriptionView: View {
    @StateObject private var dataController = SubscriptionUpdateDataController()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Spacer().frame(height: 100) // For top padding
                
                Text("Your Current Plan")
                    .font(.system(size: 14))
                    .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    .padding(.top, 10)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30) // Left aligned
                
                Text("\(dataController.currentTier) - \(dataController.currentPlan)")
                    .font(.system(size: 34))
                    .fontWeight(.bold)
                    .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30) // Left aligned
                
                Text("Update Your Plan")
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
                            dataController.selectedPlan = "Monthly"
                            dataController.selectedTier = nil // Reset selected tier when plan changes
                        }) {
                            Text("Monthly")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(dataController.selectedPlan == "Monthly" ? Color(red: 81/255, green: 58/255, blue: 16/255) : Color.clear)
                                .foregroundColor(dataController.selectedPlan == "Monthly" ? .white : Color(red: 81/255, green: 58/255, blue: 16/255)).bold()
                                .cornerRadius(50)
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            dataController.selectedPlan = "Yearly"
                            dataController.selectedTier = nil // Reset selected tier when plan changes
                        }) {
                            Text("Yearly")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(dataController.selectedPlan == "Yearly" ? Color(red: 81/255, green: 58/255, blue: 16/255) : Color.clear)
                                .foregroundColor(dataController.selectedPlan == "Yearly" ? .white : Color(red: 81/255, green: 58/255, blue: 16/255)).bold()
                                .cornerRadius(50)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .padding(.horizontal, 30)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 20)
                
               
                        ForEach(dataController.tiers) { tier in
                            SubscriptionTierView(
                                tierName: tier.name,
                                price: tier.price,
                                description: tier.description,
                                isSelected: dataController.selectedTier == tier.name,
                                details: tier.details
                            ) {
                                dataController.selectedTier = dataController.selectedTier == tier.name ? nil : tier.name
                            }
                        }
                    
                
                Spacer()
                
                Button(action: {
                    dataController.updateSubscription()
                }) {
                    Text("Save Changes")
                        .foregroundColor(.white).bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(red: 81/255, green: 58/255, blue: 16/255))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 20)
                .disabled(dataController.selectedTier == nil) // Disable the button if no tier is selected
                
                Text("You can cancel the subscription at any time from the app store at no additional cost and it will end at the end of the current period. By going further, you accept our terms of service, which lay down the details of your right of withdrawal.")
                    .font(.system(size: 12))
                    .foregroundColor(Color(red: 81/255, green: 58/255, blue: 16/255))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 20)
            }
            .background(LinearGradient(gradient: Gradient(colors: [Color(red: 1, green: 0.87, blue: 0.74), Color.white]), startPoint: .top, endPoint: .bottom))
            .edgesIgnoringSafeArea(.all)
            .alert(isPresented: $dataController.showConfirmation) {
                Alert(
                    title: Text("Confirmation"),
                    message: Text("Your subscription has been updated successfully."),
                    dismissButton: .default(Text("OK"))
                )
                
            }
        }
    }
}

struct UpdateSubscriptionView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateSubscriptionView()
    }
}
