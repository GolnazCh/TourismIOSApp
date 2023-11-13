//
//  Activity.swift
//  G02_Tourism
//
//  Created by Golnaz Chehrazi - Zahra Shahin on 2023-06-02.
//

import Foundation

class Activity: Identifiable{
    var id: String
    var name : String
    var description :String
    var starRating : Int
    var hostName : String
    var photo : [String]
    var pricePerPerson : Double
    var contactNo : String
    
    init(id: String, name: String, description: String, starRating: Int, hostName: String, photo: [String], pricePerPerson: Double, contactNo:String) {
        self.id = id
        self.name = name
        self.description = description
        self.starRating = starRating
        self.hostName = hostName
        self.photo = photo
        self.pricePerPerson = pricePerPerson
        self.contactNo = contactNo
    }
}
