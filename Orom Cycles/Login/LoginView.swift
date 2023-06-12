//
//  LoginView.swift
//  Orom Cycles
//
//  Created by Sanjeev RM on 13/06/23.
//

import SwiftUI

struct LoginView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(spacing: 0) {
                    TextField("Vit Email Address", text: $email)
                        .padding(16)
                        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
                        .background(
                            Rectangle()
                                .stroke()
                                .foregroundColor(.gray.opacity(0.3))
                        )
                        .textInputAutocapitalization(.never)
                    
                    SecureField("Password", text: $password)
                        .padding(16)
                        .frame(width: UIScreen.main.bounds.width - 64, height: 50)
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(lineWidth: 2)
                        .foregroundColor(Color.gray.opacity(0.3))
                )
                
                NavigationLink {
                    Text("Dashboard")
                        .navigationTitle("Dashboard")
                } label: {
                    HStack {
                        Text("Login")
                            .font(.system(size: 24, weight: .semibold))
                        Spacer()
                        Image(systemName: "arrow.forward.circle")
                            .font(.system(size: 36))
                            .foregroundColor(.accentColor)
                    }
                    .padding([.leading, .trailing], 32)
                    .padding([.top, .bottom], 16)
                }

                
                Rectangle()
                    .frame(height: 1)
                    .padding([.leading, .trailing], 32)
                    .foregroundColor(Color.gray.opacity(0.5))
                
                VStack(spacing: 16) {
                    NavigationLink {
                        Text("Forgot Password")
                    } label: {
                        Text("Forgot Password ?")
                            .foregroundColor(.accentColor)
                            .underline()
                    }
                    
                    NavigationLink {
                        Text("Sign Up")
                    } label: {
                        HStack {
                            Text("First time? ")
                                .foregroundColor(.primary)
                            Text("Sign Up")
                                .foregroundColor(.accentColor)
                                .underline()
                        }
                    }
                }
                .font(.system(size: 12))
                .padding(.top, 16)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    VStack(alignment: .leading) {
                        Text("Hello Again!")
                            .font(.system(size: 40, weight: .bold, design: .default))
                            .foregroundColor(.accentColor)
                        Text("Welcome Back")
                            .font(.system(size: 24, weight: .bold, design: .default))
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 120)
                }
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
