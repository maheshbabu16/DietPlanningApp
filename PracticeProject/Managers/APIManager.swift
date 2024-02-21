//
//  APIManager.swift
//  PracticeProject
//
//  Created by Mahesh on 21/02/24.
//

import Foundation
import SwiftUI

final class APIManager: ObservableObject {
    @Published var imageArray :  [OnlineImage] = []
    
    func loadImagesFromAPIUrl() async{
        guard let url = URL(string: "https://picsum.photos/200/200") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response as? HTTPURLResponse, let data = data {
                print("Status Code: \(response.statusCode)")
                
                if response.statusCode == 200 {
                    let onlineImage = OnlineImage(imageData: data)
                    
                    DispatchQueue.main.async {
                        self.imageArray.append(onlineImage)
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

