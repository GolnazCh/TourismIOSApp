//
//  ActivityDetails.swift
//  G02_Tourism
//
//  Created by Golnaz Chehrazi - Zahra Shahin on 2023-06-02.
//

import SwiftUI

struct ActivityDetailsView: View {
    @EnvironmentObject var user: User
    let activity: Activity
    @State private var selectedImageIndex = 0
    @State private var isFav : Bool = false
    @State private var linkSelection : Int? = nil
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                TabView(selection: $selectedImageIndex) {
                    ForEach(0..<activity.photo.count, id: \.self) { index in
                        Image(activity.photo[index])
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .cornerRadius(8)
                            .tag(index)
                    }
                }//TabView
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 200)
                
                //Text(activity.name)
                //  .font(.title)
                
                Text(activity.description)
                    .font(.body)
                
                HStack{
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= activity.starRating ? "star.fill" : "star")
                            .foregroundColor(index <= activity.starRating ? .yellow : .gray).frame(alignment: .center)
                    }
                }//HStack for stars
                
                HStack{
                    Text("Hosted by: \(activity.hostName)")
                        .font(.subheadline)
                    Spacer()
                    Text("$\(activity.pricePerPerson, specifier: "%.2f") /person")
                        .font(.subheadline)
                    
                }
                
                HStack {
                    ForEach(activity.photo, id: \.self) { photo in
                        Image(photo)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 100)
                            .cornerRadius(8)
                    }
                }
                
                HStack{
                    VStack(alignment: .leading, spacing: 8){
                        // MARK: Favorite button
                        Button(action: {
                            toggleFavorite()
                        }) {
                            Label("Add to Favorites", systemImage: isFav ? "heart.fill" : "heart")
                                .font(.headline)
                                .foregroundColor(isFav ? .yellow : .primary)
                        }
                        // MARK: Share
                        Button(action: {
                            shareActivity()
                        }) {
                            Label("Share", systemImage: "square.and.arrow.up")
                                .font(.headline)
                        }
                        // MARK: Call Part
                        Button(action: {
                            if let firstPhone = activity.contactNo.first {
                                if let phoneURL = URL(string: "tel://\(firstPhone)") {
                                    UIApplication.shared.open(phoneURL)
                                }
                            }
                        }) {
                            Label("Call \(activity.contactNo)", systemImage: "phone")
                                .font(.headline)
                        }
                    }
                    Spacer()
                    NavigationLink(destination: Purchase(activity: activity).environmentObject(self.user), tag: 1, selection: self.$linkSelection){}
                    Button(action:{
                        self.linkSelection = 1
                    }){
                        Text("Purchase")
                    }.buttonStyle(.borderedProminent)
                }
            }
            .padding()
            
        }
        .onAppear(){
            // MARK: check if the selected activity is fav of user or not
            isFav = user.favorites.contains(where: {$0 == activity.id})
        }
        .navigationTitle(activity.name).font(.body)
       // .font(.custom("Comic Sans MS", size: 2))
    }
    
    // MARK: function for ToggleFavorite
    private func toggleFavorite() {
        isFav = user.favorites.contains(where: {$0 == activity.id})
        //activity.isFavorite.toggle()
        if !isFav{
            user.addFavorite(activity.id)
        } else {
            user.removeFavorite(activity.id)
        }
        isFav.toggle()
    }
    
    
    // MARK: func for share activity
    private func shareActivity() {
        let activityURL = URL(string: "your-activity-url")
        
        let activityItems: [Any] = [activity.name, activity.pricePerPerson, activityURL as Any]
        
        let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
    }
}

struct ActivityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        ActivityDetailsView(activity: Activity(id: "city_01", name: "Sample Activity", description: "Sample Description", starRating: 4, hostName: "Sample Host", photo: ["samplePhoto"], pricePerPerson: 10.0, contactNo: "123456789"))
    }
}

