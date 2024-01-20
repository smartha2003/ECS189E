//
//  LaunchScreenView.swift
//  PayVault
//
//  Created by Shubhada Martha on 1/17/24.
//

import SwiftUI

struct LaunchScreenView: View {
    @State private var isActive = false

        var body: some View {
            NavigationView {
                VStack {
                    VStack {
                        Image("frogVault")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 400, height: 400)
                            
                        Text("FroggyVault")
                            .bold()
                            .font(.largeTitle)
                            .padding()
                            .foregroundColor(Color("DarkBrown"))
                        
                        Spacer(minLength: 200)
                        
                        //Bottom Footer of My information
                        Text("HW 1 - Shubhada Martha ECS 189E")
                            .font(.caption)
                            .padding()
                            .foregroundColor(Color("DarkBrown"))
        
                        Spacer()
                    }
                    .containerRelativeFrame([.horizontal, .vertical])
                    .background(Gradient(colors: [.teal, .cyan, .green]).opacity(0.6))
                    .padding()
                    
                    NavigationLink(destination: LogInScreenView(),
                                   isActive: $isActive,
                                   label: { EmptyView() })
                }
                .onAppear(perform: {
                    self.gotoLoginScreen(time: 2.5)
                })
            }
        }

        func gotoLoginScreen(time: Double) {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(time)) {
                self.isActive = true
            }
        }
}

#Preview {
    LaunchScreenView()
}
