//
//  PurchaseList.swift
//  G02_Tourism
//
//  Created by Golnaz Chehrazi - Zahra Shahin on 2023-06-11.
//

import SwiftUI

struct PurchaseList: View {
    @EnvironmentObject var user: User
    var body: some View {
        VStack {
            if user.ticketsList.isEmpty {
                Text("No tickets yet")
                    .font(.headline)
                    .foregroundColor(.gray)
            }
            else{
                List{
                    
                    Button(action:{
                        // MARK: remove all tickets
                        user.removeAllTickets()
                    }){
                        Text("Remove All")
                    }.buttonStyle(.borderedProminent)
                    
                    // MARK: show user's tickets in a list
                    ForEach(user.ticketsList) { ticket in
                        VStack(spacing: 8){
                            Text("\(ticket.activityName)").foregroundColor(Color.blue)
                            HStack{
                                Text("Date: \(ticket.date)")
                                Spacer()
                                Text("Quantity: \(ticket.quantity)")
                            }
                            HStack{
                                Text("Final Cost:")
                                Spacer()
                                Text("$\(String(format: "%.2f", ticket.totalCost))").foregroundColor(Color.green)
                            }
                        }//VStack
                        //   }//Navigation
                    }//foreach
                    .onDelete { indexSet in
                        // MARK: Delete by swiping left from the list
                        user.ticketsList.remove(atOffsets: indexSet)
                        user.setUserDefaultsTickets()
                    }
                    
                }//List
            }//else
            Spacer()
        }//VSTACK
        .padding()
        .navigationTitle("Tickets")
    }
}

struct PurchaseList_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseList()
    }
}
