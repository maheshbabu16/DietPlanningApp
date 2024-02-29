//
//  OnlineImage.swift
//  PracticeProject
//
//  Created by Mahesh on 28/02/24.
//

import Foundation
import SwiftUI

class OnlineImageModel: Decodable, Identifiable {
    let imageData: Data // Use Data instead of UIImage
    
    init(imageData: Data) {
        self.imageData = imageData
    }
    
    // Add a computed property to convert Data to UIImage
    var image: UIImage? {
        return UIImage(data: imageData)
    }
}
