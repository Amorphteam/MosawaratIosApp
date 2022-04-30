//
//  SelecteImage.swift
//  HajariAlmustafaProject
//
//  Created by Samano on 4/15/22.
//

import SwiftUI

struct SelecteImage: View {
    var imageURL: String
    var book: Book

    var body: some View {
        
        ZStack {

            ZoomableScrollView {
                ZStack{
                    Color("Background")
                    
                    AsyncImage(url: URL(string: imageURL)){ phase in
                        
                        switch phase {
                        case .empty:
                            Color(UIColor(Color("Background")))

                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                            
                        case .failure(_):
            //                Image(systemName: "exclamationmark.icloud")
                            Color(UIColor(Color("Background")))

                        @unknown default:
                            Color(UIColor(Color("Background")))
            //                Image(systemName: "exclamationmark.icloud")
                        }
                    }

                }
            }

        }
        
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("Background")/*@END_MENU_TOKEN@*/)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(book.post_name)

        
    }
    
    
}

//struct SelecteImage_Previews: PreviewProvider {
//    static var previews: some View {
//        SelecteImage(image: "String")
//    }
//}
