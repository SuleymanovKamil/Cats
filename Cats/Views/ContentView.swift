//
//  ContentView.swift
//  Cats
//
//  Created by Камиль Сулейманов on 22.08.2021.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = Networking()
    @State private var imageScale = false
    var body: some View {
        
        Group {
            if viewModel.data != nil {
                VStack {
                    Spacer()
                    ScrollView (imageScale ? .horizontal : [], showsIndicators: false){
                        Image(uiImage: UIImage(data: viewModel.data!)!)
                            .resizable()
                            .aspectRatio(contentMode: imageScale ? .fill : .fit)
                            .cornerRadius(25)
                            .onTapGesture{
                                withAnimation {
                                    imageScale.toggle()
                                }
                            }
                    }
                    
                    if !imageScale {
                        
                        Spacer()
                        
                        Image(systemName: "arrowshape.zigzag.forward.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color(#colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1)))
                            .contentShape(Rectangle())
                            .onTapGesture{
                                viewModel.data = nil
                                viewModel.loadRandomCat()
                            }
                            .padding()
                            .background(Color.white.cornerRadius(15))
                            .padding(.bottom)
                        
                    }
                    
                    Spacer()
                }
                .background(
                    VStack { Image(uiImage: UIImage(data: viewModel.data!)!)
                        .resizable()
                        .scaledToFill()
                        .blur(radius: 10)})
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
