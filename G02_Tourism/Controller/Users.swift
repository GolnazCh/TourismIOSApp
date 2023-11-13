//
//  Users.swift
//  G02_Tourism
//
//  Created by Golnaz Chehrazi - Zahra Shahin on 2023-06-10.
//

import Foundation

class Users{
    var users: [User] = [User(name: "Golnaz", email: "g.chehrazi@gmail.com", password: "Admin"), User(name: "Zahra", email: "z.shahin@gmail.com", password: "Admin")]
    
    func Login(userEmail: String, userPassword: String) -> (Bool, String?){
        var errorMsg : String? = nil
        for user in self.users{
            if(user.email.lowercased() == userEmail.lowercased())
            {
                if(user.password == userPassword)
                {
                    errorMsg = user.name
                    return (true , errorMsg)
                }//check password
                else{
                    errorMsg = "Invalid password"
                    return (false, errorMsg)
                }
            }//check email
        }//for
        errorMsg = "Invalid username or password"
        return (false, errorMsg)
    }
    
    func getNameOfUserbyEmail(email: String)-> String{
        for i in users{
            if(i.email == email){
                return i.name
            }
        }
        return "unknown"
    }
    
}
