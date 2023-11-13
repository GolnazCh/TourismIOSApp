//
//  ContentView.swift
//  G02_Tourism
//
//  Created by Golnaz Chehrazi - Zahra Shahin on 2023-06-02.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user : User
    @State private var selectionLink : Int? = nil
    //to dismiss the current view/screen
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            VStack(spacing: 8) {
                Text("Dear \(user.name)")
                    .font(.custom("Comic Sans MS", size: 22))
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                
                HStack {
                    Text("Sydney")
                        .font(.custom("Comic Sans MS", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                    Text("has a lot to offer!")
                        .font(.custom("Comic Sans MS", size: 18))
                        .foregroundColor(.primary)
                }
                .padding(.vertical, 8)
            }

            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [5]))
                    .foregroundColor(Color.purple)
                    
            )
            
            TabView{
                ActivitiesView()
                    .tabItem{
                        Image(systemName: "person.fill")
                            .foregroundColor(.red)
                        Text("Activities")
                    }
                
                FavoritesListView()
                    .tabItem{
                        Image(systemName: "heart.fill")
                            .foregroundColor(.green)
                        Text("Favorites")
                    }
                PurchaseList()
                    .tabItem{
                        Image(systemName: "ticket.fill")
                            .foregroundColor(.green)
                        Text("Tickets")
                    }
            }
            Spacer()
        }
        .navigationTitle(" G & Z Tourism")
        .navigationBarBackButtonHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button(action: {
                    // MARK: logout
                    UserDefaults.standard.removeObject(forKey: "KEY_CURRENT_USER")
                    dismiss()
                }){
                    Text("Logout")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
