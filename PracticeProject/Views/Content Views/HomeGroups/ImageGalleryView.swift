//
//  ImageGalleryView.swift
//  PracticeProject
//
//  Created by Mahesh on 21/02/24.
//

import SwiftUI

struct ImageGalleryView: View {
    
    @StateObject var apiManager = APIManager()
    @State var isImageExpanded : Bool = false
    @Namespace var nameSpace
    @State var imageSelected : UIImage?
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    var body: some View {
        ZStack{
            Color.black.ignoresSafeArea()
            if apiManager.imageArray.count > 0{
                    ScrollView(.vertical){
                        LazyVGrid(columns: columns, alignment: .center, spacing: 0, content: {
                            withAnimation {
                                ForEach(apiManager.imageArray) { images in
                                    if let newImage = images.image{
                                        ZStack{
                                            Image(uiImage: newImage)
                                                .resizable()
                                                .scaledToFit()
                                                .cornerRadius(10)
                                                .padding(.horizontal, 5)
                                        }.onTapGesture {
                                            imageSelected = newImage
                                            withAnimation(.spring){
                                                self.isImageExpanded.toggle()
                                            }
                                        }.frame(height: 200)
                                            .cornerRadius(10)
                                    }
                                }
                            }
                        }) .matchedGeometryEffect(id: "newImage", in: nameSpace)
                        
                    }.padding(.horizontal)
            }
        }.frame(maxWidth: .infinity)
            .frame(maxHeight: .infinity)
            .task {
            await withThrowingTaskGroup(of: Void.self) { group in
                group.addTask {
                    for _ in 1...200 {
                        await apiManager.loadImagesFromAPIUrl()
                        await print(apiManager.imageArray.count)
                    }
                }
            }
        }
    }
}

#Preview {
    ImageGalleryView()
}
