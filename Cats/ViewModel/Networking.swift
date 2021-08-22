//
//  Networking.swift
//  Cats
//
//  Created by Камиль Сулейманов on 22.08.2021.
//

import SwiftUI
import Combine

class Networking: ObservableObject {
    
 
    @Published var data: Data?
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        loadRandomCat() 
    }
    
    func loadRandomCat() {
           guard let url = URL(string: "https://api.thecatapi.com/v1/images/search") else { return }
      
           URLSession.shared.dataTaskPublisher(for: url)
               .map(\.data)
               .decode(type: [Random].self, decoder: JSONDecoder())
               .receive(on: DispatchQueue.main)
               .sink { print($0)}
                   receiveValue: { [unowned self] value in
                       
                       if let loadData =  try? Data(contentsOf: URL(string: value.first!.url)!) {
                           data = loadData
                       }
               }
               .store(in: &cancellable)
    }
    
}


