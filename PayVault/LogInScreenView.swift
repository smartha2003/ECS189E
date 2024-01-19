//
//  ContentView.swift
//  PayVault
//
//  Created by Shubhada Martha on 1/16/24.
//

import SwiftUI
import PhoneNumberKit

struct LogInScreenView: View {
    let phoneNumberKit = PhoneNumberKit()
    @State private var text = ""
    @State private var phoneNumber = "" //store in E64 format
    @FocusState private var isPhoneNumberFocused: Bool // managed by swift ui
    @State private var showingErrorMsg = false
    
    //Login Screen
    var body: some View {
        GeometryReader { _ in
            ZStack {
                VStack {
                    VStack(spacing: -100) {
                        //App Logo
                        Image("frogVault")
                            .resizable()
                            .scaledToFit()
                            .padding()
                        
                        //App Name
                        Text("FroggyVault")
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(Color("DarkBrown"))
                            .padding()
                    }
                    
                    //Instruction to tell users what to do
                    Text("Enter your US mobile number")
                        .font(.title3)
                        .foregroundColor(Color("DarkBrown"))
                        
                    //Formats the user input textfield with error checks, button to send OPT, and displays the +1 for country code
                    HStack {
                        Text("+ 1")
                            .padding()
                            .background(Color("DarkBrown"))
                            .foregroundColor(Color("LightPeach"))
                            .clipShape(RoundedRectangle(cornerRadius: 20.0))
                            
                        // User input
                        ZStack {
                            TextField("(669) 123 - 123", text: $phoneNumber)
                                .keyboardType(.numberPad)
                                .focused($isPhoneNumberFocused)
                                .onTapGesture {
                                    isPhoneNumberFocused = true
                                }
                                .onChange(of: phoneNumber) {
                                    let num = PartialFormatter().formatPartial(phoneNumber)
                                        phoneNumber = num
                                }
                                .padding()
                                .background(Color.clear)
                                .overlay(Rectangle().frame(height: 1).padding(.top, 35).foregroundColor(Color("DarkBrown"))).frame(width: 200) // Underline UI for field text
                        }
                        .ignoresSafeArea(.keyboard) //Ensures the Keyboard to not move the view
                        .padding()
                    }
                        
                    //input validation after clicking the send button
                    Button ("Send Code") {
                        do {
                            let parsed = try phoneNumberKit.parse(phoneNumber)
                            let formatted = phoneNumberKit.format(parsed, toType: .e164) // +61236618300
                            
                            //Checks for ensuring the correct formatting
                            print(parsed)
                            print(formatted)
                        } catch {
                            showingErrorMsg = true
                        }
                        // Dismisses the keyboard when the "Send Code" button is tapped
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                    .padding()
                    .background(Color("DarkBrown"))
                    .foregroundColor(Color("LightPeach"))
                    .clipShape(RoundedRectangle(cornerRadius: 20.0))
                    .alert(isPresented: $showingErrorMsg) {
                            Alert(title:
                                    Text("Invalid Phone Number"), dismissButton:
                                    .default(Text("I'll fix it!")))
                    } //Alerts the user of invalid phone number
                    
                    Spacer(minLength: 200)
                    
                    //Bottom Footer of My information
                    Text("HW 1 - Shubhada Martha ECS 189E")
                        .font(.caption)
                        .padding()
                        .foregroundColor(Color("DarkBrown"))
    
                    Spacer()
                }
            
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .ignoresSafeArea(.keyboard)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Gradient(colors: [.teal, .cyan, .green]).opacity(0.6))
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .onTapGesture {
            //Dismisses the keyboard if you click away
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

#Preview {
    LogInScreenView()
}
 
