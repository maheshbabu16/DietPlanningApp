//
//  APIManaer.swift
//  PracticeProject
//
//  Created by Mahesh on 28/02/24.
//

import SwiftUI

final class APIManager: ObservableObject {
    @Published var imageArray :  [UIImage] = []
    
    func loadImagesFromAPIUrl() async{
        guard let url = URL(string: "https://picsum.photos/200/200") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response as? HTTPURLResponse, let data = data {
                print("Status Code: \(response.statusCode)")
                
                if response.statusCode == 200 {
                    if let onlineImage = UIImage(data: data) {
                        
                        DispatchQueue.main.async {
                            self.imageArray.append(onlineImage)
                        }
                    }
                }
                
            }else{
                if let error = error {
                    print("Error: \(error)")
                }
            }
        }.resume()
    }
}
