//
//  Activities.swift
//  G02_Tourism
//
//  Created by Golnaz Chehrazi - Zahra Shahin on 2023-06-02.
//

import SwiftUI

struct ActivitiesView: View {
    @EnvironmentObject var user: User
    @EnvironmentObject var actvityDS: ActivityDataSource
    
    var body: some View {
        VStack {
            List(actvityDS.activityList) { activity in
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
                            Text("$\(activity.pricePerPerson, specifier: "%.2f") /person")
                                .font(.subheadline)
                            HStack{
                                    // MARK: rating stars
                                    HStack(spacing: 2) {
                                        ForEach(1...5, id: \.self) { index in
                                            Image(systemName: index <= activity.starRating ? "star.fill" : "star")
                                                .foregroundColor(.yellow)
                                        }
                                    }
                                Spacer()
                                // MARK: faviorate heart
                                if self.user.favorites.contains(activity.id) {
                                    Image(systemName: "heart.fill")
                                        .foregroundColor(.red)
                                }
                                
                            }
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
        }
        .navigationTitle("Activities")
        .padding()
        .navigationBarBackButtonHidden(true)

    }
}

struct ActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView()
    }
}
