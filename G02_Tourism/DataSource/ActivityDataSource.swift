//
//  ActivityData.swift
//  G02_Tourism
//
//  Created by Golnaz Chehrazi - Zahra Shahin on 2023-06-10.
//


import Foundation

class ActivityDataSource : ObservableObject{
    let activityList: [Activity] = [
        Activity(id: "sydny_1", name: "Harbour Kayak Adventure", description: "Come enjoy a morning sea kayak adventure on Sydney's beautiful harbour. No engine noise or fumes, just the sound of your paddle in the water and the sea birds squawking above!", starRating: 1, hostName: "Matt", photo: ["kayak1", "kayak2", "kayak3"], pricePerPerson: 113.0, contactNo: "123456789"),
        Activity(id: "sydny_2", name: "Discover Sydney Harbour by e-Bike", description: "Join a small group of riders to explore Sydney's pristine coves, parklands and harbour bays.", starRating: 5, hostName: "Linda", photo: ["e-bike1", "e-bike2", "e-bike3"], pricePerPerson: 89.0, contactNo: "123456789"),
        Activity(id: "sydny_3", name: "Sunset & Sparkle Sydney Harbour Cruise", description: "Explore Sydney Harbour by dusk and enjoy the stunning Sydney landmarks as the sun sets and the city lights come to life.", starRating: 3, hostName: "Frank", photo: ["cruise1", "cruise2", "cruise3"], pricePerPerson: 45.0, contactNo: "6543210983"),Activity(id: "sydny_4", name: "Vivid Lights Secret Bar Crawl", description: "Visit 3 of Sydney’s best secret & small bars while exploring the Vivid Lights artworks!Your expert host will curate a route that showcases some of the best light installations.", starRating: 4, hostName: "Frank", photo: ["crawl1", "crawl2", "crawl3", "crawl4"], pricePerPerson: 45.0, contactNo: "0978456123")
    ]
    
    //singleton instance
    private static var shared : ActivityDataSource?
    
    static func getInstance() -> ActivityDataSource{
        if (shared == nil){
            shared = ActivityDataSource()
        }
        
        return shared!
    }
    
    func getActivityById(activityId: String)-> Activity?{
        for item in self.activityList{
            if(item.id == activityId){
                return item
            }
        }
        return nil
    }
    
}
