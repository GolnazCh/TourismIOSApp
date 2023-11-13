//
//  Purchase.swift
//  G02_Tourism
//
//  Created by Golnaz Chehrazi - Zahra Shahin on 2023-06-11.
//

import Foundation
class Ticket : Identifiable,Decodable,Encodable{
    var id : UUID = UUID()
    var userEmail : String
    var activityId : String
    var activityName : String
    var quantity : Int
    var pricePerPerson : Double
    var date : String
    var subtotal : Double{
        return Double(quantity) * pricePerPerson
    }
    var tax: Double{
        return subtotal * 0.13
    }
    var totalCost:Double{
        return subtotal + tax
    }
    
    init(userEmail: String, activityId: String, activityName: String, quantity: Int, pricePerPerson: Double, date: String) {
        self.userEmail = userEmail
        self.activityId = activityId
        self.activityName = activityName
        self.quantity = quantity
        self.pricePerPerson = pricePerPerson
        self.date = date
    }
}
