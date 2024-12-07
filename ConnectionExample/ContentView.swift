//
//  ContentView.swift
//  ConnectionExample
//
//  Created by Muhammet Emin Ayhan on 6.12.2024.
//

import SwiftUI
import Network

struct ContentView: View {
    let systemImages = ["house","star","heart","bell","gear","person","cloud","sun.max","cart","pencil"]
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        ZStack {
            NavigationView {
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())]) {
                        ForEach(systemImages, id: \.self) { imageName in
                            NavigationLink(destination: DetailView(imageName: imageName)) {
                                CardButton(imageName: imageName)
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Buttons")
            }
            if !networkManager.isConnected {
                UseInternetConnectionCheck()
            }
        }
    }
}

struct CardButton: View {
    let imageName: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 50,height: 50)
                .foregroundColor(.white)
            
            Text(imageName.capitalized)
                .font(.headline)
                .foregroundColor(.white)
        }
        .frame(maxWidth: .infinity, minHeight: 120)
        .background(Color(.pink))
        .cornerRadius(10)
        .shadow(color: .gray.opacity(0.4) ,radius: 5, x:0, y: 5)
        .padding()
    }
}

struct DetailView: View {
    let imageName: String
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        ZStack {
            VStack {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding()
                
                Text("This is the \(imageName.capitalized) view")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
            }
            .navigationTitle(imageName.capitalized)
            
            if !networkManager.isConnected {
                UseInternetConnectionCheck()
            }
        }
    }
}

struct UseInternetConnectionCheck: View {
    @ObservedObject var networkManager = NetworkManager()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 20) {
                Image(systemName: networkManager.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.blue)
                    .padding(.top, 20)
                Text(networkManager.connectionDescription)
                    .font(.system(size:18, weight: .semibold))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                if !networkManager.isConnected {
                    Button(action: {
                        print("Handle action..")
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Back")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .padding()
            .background(Color(.systemBackground))
            .cornerRadius(20)
            .shadow(radius: 10)
            .padding()
            
            Spacer()
        }
        .background {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.2), Color.blue.opacity(0.5)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        }
    }
}

