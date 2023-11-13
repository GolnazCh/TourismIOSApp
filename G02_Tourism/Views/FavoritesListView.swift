//
//  FavoritesListView.swift
//  G02_Tourism
//
//  Created by Golnaz Chehrazi - Zahra Shahin on 2023-06-02.
//

import SwiftUI

struct FavoritesListView: View {
    @EnvironmentObject var user: User
    @EnvironmentObject var activityDS : ActivityDataSource
    //@State private var seachWord : String = ""
    var body: some View {
        VStack {
            if user.favorites.isEmpty {
                Text("No favorites yet")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            else{
                List{
                    // MARK: Remove all activities from favorite list of user
                    Button(action:{
                        user.removeAllFavorites()
                    }){
                        Text("Remove All")
                    }.buttonStyle(.borderedProminent)
                    // MARK: show favorites in a list
                    ForEach(user.favorites, id: \.self) { favorite in
                        if let activity = activityDS.getActivityById(activityId: favorite) {
                            NavigationLink(destination: ActivityDetailsView(activity: activity).environmentObject(self.user)) {
                                HStack(alignment: .top) {
                                    Image(activity.photo.first ?? "")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 80, height: 80)
                                        .cornerRadius(8)
                                        .clipped()
                                    
                                    VStack(alignment: .leading) {
                                        Text(activity.name)
                                            .font(.headline)
                                        Text("\(activity.pricePerPerson, specifier: "%.2f") / person")
                                            .font(.subheadline)
                                    }
                                }
                                .foregroundColor(.primary)
                            }
                        }
                    }
                    //foreach
                    .onDelete {
                        // boilerplate code from documentation
                        indexSet in
                        self.user.favorites.remove(atOffsets: indexSet)
                        self.user.setUserDefaultsFavorites()
                    }
                    
                }//List
            }//else
        }//VSTACK
        .padding()
        .navigationTitle("Favorites")
    }//Body
}


struct FavoritesListView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesListView()
            .environmentObject(User())
    }
}

