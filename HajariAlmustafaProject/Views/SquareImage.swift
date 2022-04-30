//
//  CircleImage.swift
//  HajariAlmustafaProject
//
//  Created by Samano on 4/13/22.
//

import SwiftUI

struct SquareImage: View {
    var imageURL: String
    
    var body: some View {
        
        AsyncImage(url: URL(string: imageURL)){ phase in
            
            switch phase {
            case .empty:
                Color(UIColor(Color("Background")))
                    .cornerRadius(19.5)

            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(19.5)
                
            case .failure(_):
//                Image(systemName: "exclamationmark.icloud")
                Color(UIColor(Color("Background")))
                    .cornerRadius(19.5)

            @unknown default:
                Color(UIColor(Color("Background")))
                    .cornerRadius(19.5)
//                Image(systemName: "exclamationmark.icloud")
            }
        }
        
        .frame(width: 150.0, height: 150.0, alignment: .center)
        .padding(.all, 20.0)
        
    }
}

//struct SquareImage_Previews: PreviewProvider {
//    static var previews: some View {
//        SquareImage(image: Image(from: "book1" as! Decoder))
//    }
//}
//

