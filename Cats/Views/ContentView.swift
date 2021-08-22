//
//  ContentView.swift
//  Cats
//
//  Created by Камиль Сулейманов on 22.08.2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = Networking()
    var body: some View {
       
        Group{
            if viewModel.data != nil {
                VStack {
                    Spacer()
                    Image(uiImage: UIImage(data: viewModel.data!)!)
                        .resizable()
                        .scaledToFit()
                      
                    Spacer()
                }
                .background(
                    Image(uiImage: UIImage(data: viewModel.data!)!)
                        .resizable()
                        .scaledToFill()
                        .blur(radius: 10)
                )
                .onTapGesture {
                    viewModel.data = nil
                    viewModel.loadRandomCat()
            }
                
            } else {
                ZStack {
                    Color(#colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1))
                    VStack (spacing: 15){
                        ProgressView()
                        Text("Loading")
                    }
                    .padding(50)
                    .background(Color.white.cornerRadius(15))
                }
            }
        }
        .ignoresSafeArea()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
