//
//  Purchase.swift
//  G02_Tourism
//
//  Created by Golnaz Chehrazi - Zahra Shahin on 2023-06-11.
//

import SwiftUI

struct Purchase: View {
    @EnvironmentObject var user: User
    let activity: Activity
    @State private var quantityFromUI : Int = 1
    @State private var showAlert = false
    @State private var selectedDate = Date()
    //to dismiss the current view/screen
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Form{
                Section{
                    let minDate = Date()
                    Text("\(self.activity.name)")
                    DatePicker("Select a Date", selection: self.$selectedDate, in: minDate..., displayedComponents: .date)
                        .datePickerStyle(.automatic)
                }
                Section{
                    HStack{
                        Text("Price:")
                        Spacer()
                        Text("$\(String(format: "%.2f", self.activity.pricePerPerson))/person")
                    }
                    Stepper("Quantity: \(self.quantityFromUI)", value:self.$quantityFromUI, in:1...10)
                    let subtotal = Double(self.quantityFromUI) * self.activity.pricePerPerson
                    let tax = 0.13 * subtotal
                    let final = subtotal + tax
                    HStack{
                        Text("Subtotal:")
                        Spacer()
                        Text("$\(String(format: "%.2f", subtotal))")
                    }
                    HStack{
                        Text("Tax:")
                        Spacer()
                        Text("$\(String(format: "%.2f", tax))")
                    }
                    HStack{
                        Text("Total:")
                        Spacer()
                        Text("$\(String(format: "%.2f", final))")
                    }
                }
                
                Button(action:{
                    // MARK: purchase new ticket
                    var newTicket = Ticket(userEmail: self.user.email, activityId: self.activity.id, activityName: self.activity.name, quantity: self.quantityFromUI, pricePerPerson: self.activity.pricePerPerson, date: formatedDate(date: self.selectedDate))
                    self.user.purchaseNewTicket(newTicket: newTicket)
                    showAlert = true
                })
                {
                    Text("Verify Purchase")
                }.padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .frame(width: 300, alignment: .center)
                    // MARK: alert code for the successful message
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("Successful Purchase"),
                            message: Text("Thanks for your purchase!"),
                            dismissButton: .default(Text("OK")){
                                dismiss()
                            }
                        )
                    }
            }
            Spacer()
        }//vstack
    }//body
    
    // MARK: format the date for show to user
    func formatedDate(date: Date)-> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
}

struct Purchase_Previews: PreviewProvider {
    static var previews: some View {
        Purchase(activity: Activity(id: "city_01", name: "Sample Activity", description: "Sample Description", starRating: 4, hostName: "Sample Host", photo: ["samplePhoto"], pricePerPerson: 10.0, contactNo: "123456789"))
    }
}
