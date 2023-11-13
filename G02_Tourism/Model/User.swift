//
//  User.swift
//  G02_Tourism
//
//  Created by Golnaz Chehrazi - Zahra Shahin on 2023-06-02.
//

import Foundation

class User: ObservableObject {
    @Published var email: String
    var password: String
    @Published var favorites: [String] = [String]()
    @Published var name : String
    @Published var ticketsList : [Ticket] = [Ticket]()
    
    init(name: String, email: String, password: String) {
        self.email = email
        self.password = password
        self.name = name
    }
    
    init() {
        self.email = "unknown"
        self.password = "unknown"
        self.name = "unknown"
    }
    
    func addFavorite(_ favoriteId: String) {
        favorites.append(favoriteId)
        print("Successfully added to user's favorite activities")
        setUserDefaultsFavorites()
    }
    
    func removeFavorite(_ activityId: String) {
        if let index = favorites.firstIndex(where: { $0 == activityId }) {
            favorites.remove(at: index)
            print("Successfully removed from user's favorite activities")
        }
        setUserDefaultsFavorites()
    }
    
    func removeAllFavorites() {
        favorites.removeAll()
        setUserDefaultsFavorites()
        print("Successfully removed all favorites from user's favorite activities")
    }
    
    func purchaseNewTicket(newTicket: Ticket){
        self.ticketsList.append(newTicket)
        setUserDefaultsTickets()
        print("Sucessfully added to tickets list")
    }
    
    func removePurchaseTicket(_ activityId: String) {
        if let index = self.ticketsList.firstIndex(where: { $0.activityId == activityId }) {
            self.ticketsList.remove(at: index)
            print("Successfully removed from tickets list")
        }
        setUserDefaultsTickets()
    }

    func removeAllTickets() {
        ticketsList.removeAll()
        print("Successfully removed all purchased tickets from user's Tickets")
        // MARK: set purchased user tickets in UserDefaults
        setUserDefaultsTickets()
    }
    
    func setUserDefaultsFavorites(){
        UserDefaults.standard.set(self.favorites, forKey: "KEY_FAVORITES_\(self.email)")
        print("set setUserDefaultsFavorites")
    }
    
    func setUserDefaultsTickets(){
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(self.ticketsList) {
            UserDefaults.standard.set(encodedData, forKey: "KEY_TICKETS_\(self.email)")
            print("set setUserDefaultsTickets")
        }
    }
}
