//
//  CustomTabbar.swift
//  Shelves-User
//
//  Created by Sahil Raj on 06/07/24.
//

import SwiftUI

struct CustomTabbar: View {
    @State private var activeTab: Tab = .forYou
    @Namespace private var animation
    @State private var tabShapePosition: CGPoint = .zero
    
    init()
    {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        VStack(spacing: 0) {
            TabView(selection: $activeTab) {
                Text("For You")
                    .tag(Tab.forYou)
                
                Text("Explore")
                    .tag(Tab.explore)
                
                Text("My Library")
                    .tag(Tab.myLibrary)
                
                Text("Profile")
                    .tag(Tab.profile)
            }
            customTabBar()
        }
    }
    
    @ViewBuilder
    func customTabBar(_ tint: Color = Color(.blue), inactiveTint: Color = .blue) -> some View {
        HStack(alignment: .bottom, spacing: 0) {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                TabItem(
                    tint: tint,
                    inactiveTint: inactiveTint,
                    tab: tab,
                    animation: animation,
                    activeTab: $activeTab,
                    position: $tabShapePosition
                )
            }
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .background {
                    ZStack {
                        Rectangle().fill(Color.clear)
                        TabShape(midpoint: tabShapePosition.x)
                            .fill(Color.white)
                            .shadow(color: tint.opacity(0.2), radius: 5, x: 0, y: -5)
                            .blur(radius: 2)
                            .padding(.top, 25)
                    }
                }
                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7), value: activeTab)
            }
        }
struct TabItem: View {
    var tint: Color
    var inactiveTint: Color
    var tab: Tab
    var animation: Namespace.ID
    @Binding var activeTab: Tab
    @Binding var position: CGPoint
    
    
    @State private var tabPosition: CGPoint = .zero
    var body: some View {
        VStack(spacing: 5) {
            Image(systemName: tab.systemImage)
                .font(.title2)
                .foregroundColor(activeTab == tab ? .white : inactiveTint)
                /// Increasing Size for the Active Tab
                .frame(width: activeTab == tab ? 58 : 35, height: activeTab == tab ? 58 : 35)
                .background {
                    if activeTab == tab {
                        Circle()
                            .fill(tint.gradient)
                            .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                    }
                }
            Text(tab.rawValue)
                .font(.caption)
                .foregroundColor(activeTab == tab ? tint : .gray)
        }
        .frame(maxWidth: .infinity)
        .contentShape(Rectangle())
        .viewPosition(completion: { rect in
            tabPosition.x = rect.midX
            
            if activeTab == tab{
                position.x = rect.midX
            }
            
        })
        .onTapGesture {
            activeTab = tab
            
            withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.7)) {
                position.x = tabPosition.x
            }
        }
    }
}


struct CustomTabbar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabbar()
    }
}
