//
//  Login.swift
//  G02_Tourism
//
//  Created by Golnaz Chehrazi - Zahra Shahin on 2023-06-02.
//

import SwiftUI

struct Login: View {
    
    // MARK: refer to the singleton instance of ActivityDataSource class
    var activityDataSource : ActivityDataSource = ActivityDataSource.getInstance()
    
    @State private var emailFromUI : String = ""
    @State private var passwordFromUI : String = ""
    @State private var rememberMeFromUI : Bool = false
    @State private var errorMsg : String? = nil
    @State private var linkSelection : Int? = nil
    var currentUser: User = User()
    let usersList = Users()
    
    var body: some View {
        NavigationView{
            VStack(spacing:20){
                NavigationLink(destination: ContentView().environmentObject(currentUser).environmentObject(activityDataSource), tag: 1, selection: self.$linkSelection){}
                Image("Tourism-Travel")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 350).border(.gray)
                TextField("Enter an email", text: self.$emailFromUI ).textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled(true)
                    .autocapitalization(.none)
                SecureField("Enter your password", text: self.$passwordFromUI ).textFieldStyle(.roundedBorder)
                    .textContentType(.password)
                
                //MARK: Remember Me Section
                Toggle("Remember me", isOn: self.$rememberMeFromUI)
                Button(action:{
                    if(emailFromUI.isEmpty || passwordFromUI.isEmpty)
                    {
                        errorMsg = "Enter your email and password"
                        return
                    }
                    if(!isEmailValid()){
                        errorMsg = "The entered email is not in a correct fromat"
                        return
                    }
                    errorMsg = nil
                    
                    let loginResult = usersList.Login(userEmail: emailFromUI, userPassword: passwordFromUI)
                    
                    if(loginResult.0){
                        currentUser.email = emailFromUI.lowercased()
                        currentUser.password = passwordFromUI
                        currentUser.name = loginResult.1!
                        errorMsg = nil
                        
                        // MARK: remember me option is set or not
                        if(self.rememberMeFromUI){
                            UserDefaults.standard.set(currentUser.email ,forKey: "KEY_CURRENT_USER")
                        }
                        else{
                            UserDefaults.standard.removeObject(forKey: "KEY_CURRENT_USER" )
                        }
                        
                        // MARK: Retrive FAV List
                        if(!retriveFavList()){
                            currentUser.favorites = [String]()
                        }
                        
                        // MARK: Retrive Tickets
                        if(!retriveTickets()){
                            currentUser.ticketsList = [Ticket]()
                        }
                        
                        // MARK: set linkSelction for navigating to ContentView in app
                        self.linkSelection = 1
                    }
                    else{
                        // MARK: show login errors to user
                        self.linkSelection = nil
                        errorMsg = loginResult.1
                    }
                }){Text("Login")}
                    .frame(width: 200, height: 50)
                    .buttonStyle(.borderedProminent).padding(20)
                
                
                // MARK: show login error message to user
                if let error = errorMsg
                {
                    Text(error).bold().foregroundColor(Color.red)
                }
                Spacer()
            }//VStack
            .padding()
            .navigationBarBackButtonHidden(true)
            .font(.system(size:20))
            .onAppear(){
                if let userEmail = UserDefaults.standard.string(forKey: "KEY_CURRENT_USER")  {
                    currentUser.email = userEmail
                    currentUser.name = usersList.getNameOfUserbyEmail(email: userEmail)
                    
                    // MARK: retrive fav List
                    if(!retriveFavList())
                    {
                        currentUser.favorites = [String]()
                    }
                    
                    // MARK: retrive tickets
                    if(!retriveTickets()){
                        currentUser.ticketsList = [Ticket]()
                    }
                    self.linkSelection = 1
                }//if
                else{
                    resetScreen()
                }//else
            
            }//onAppear
            .navigationTitle(Text("G & Z Tourism"))
        }//NavigationView
        
    }
    
    // MARK: func for check if the form is valid
    func isEmailValid()-> Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
            return emailPredicate.evaluate(with: emailFromUI)
        }
    
    // MARK: function for reset the Screen
    func resetScreen(){
        self.emailFromUI = ""
        self.passwordFromUI = ""
        self.errorMsg = nil
        self.linkSelection = nil
        self.rememberMeFromUI = false
        self.currentUser.favorites = [String]()
        self.currentUser.ticketsList = [Ticket]()
        self.currentUser.name = "unknown"
        self.currentUser.password = "unknown"
        self.currentUser.email = "unknown"
    }
    
    // MARK: func for retrive logined user tickets
    func retriveTickets()->Bool{
        let decoder = JSONDecoder()
        if let tickets = UserDefaults.standard.data(forKey: "KEY_TICKETS_\(currentUser.email)"),
           let decodedTickets = try? decoder.decode([Ticket].self, from: tickets) {
            currentUser.ticketsList = decodedTickets
            return true
        }
        return false
    }
    
    // MARK: func for retrive ligined user FAVORITES
    func retriveFavList()->Bool{
        if let favList = UserDefaults.standard.array(forKey: "KEY_FAVORITES_\(currentUser.email)") as? [String]{
            currentUser.favorites = favList
            return true
        }//if
        return false
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login()
    }
}
