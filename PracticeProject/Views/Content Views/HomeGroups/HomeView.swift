//
//  HomeView.swift
//  PracticeProject
//
//  Created by Mahesh babu on 08/09/24.
//

import SwiftUI

struct HomeView: View {

    @Binding var selectedTab : Int
    @Binding var profileImageExpanded : Bool
    
    var profileAnimationID: Namespace.ID
    
    var body: some View {
        NavigationStack{
            UserHomeScreen(tabItemTag: $selectedTab)
                .navigationTitle("Home")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            withAnimation(.spring(.bouncy)) { profileImageExpanded.toggle() }
                        } label: {
                            ZStack{
                                Image("flower")
                                    .resizable()
                                    .scaledToFill()
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "profileImageNew", in: profileAnimationID)
                            }.matchedGeometryEffect(id: "profileImageBackground", in: profileAnimationID)
                                .frame(maxWidth: 50, maxHeight: 50)
                        }
                    }
                }
        }
    }
}

//#Preview {
//   HomeView(profileAnimationID: Namespace.ID, selectedTab: .constant(0), profileImageExpanded: .constant(true))
//}

struct ExpandedProfileViewScreen : View {
    
    var profileAnimationID: Namespace.ID
    @Binding var profileImageExpanded : Bool
    
    var body: some View {
        ZStack{
            Image("flower")
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .matchedGeometryEffect(id: "profileImageNew", in: profileAnimationID)
                .frame(maxWidth: 200, maxHeight: 200)
        }.matchedGeometryEffect(id: "profileImageBackground", in: profileAnimationID)
            .frame(maxWidth: .infinity,maxHeight: .infinity)
            .background(.thinMaterial)
            .onTapGesture {
                withAnimation(.spring(.bouncy)) {
                    profileImageExpanded.toggle()
                }
            }
    }
}
