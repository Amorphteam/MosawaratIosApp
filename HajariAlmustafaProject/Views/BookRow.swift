//
//  BookRow.swift
//  HajariAlmustafaProject
//
//  Created by Samano on 4/13/22.
//

import SwiftUI

struct BookRow: View {
    var book: Book

    var body: some View {
        
        ZStack {
            VStack(alignment: .leading){
                
                Text("\(book.post_name)")
                    .foregroundColor(Color.black)
                    .lineLimit(2)
                    .padding(.all, 1.0)
                    .scaledToFit()

                
                Text("\(book.details.author_name)")
                    .font(.subheadline)
                    .foregroundColor(Color(red: 0.4392156862745098, green: 0.4392156862745098, blue: 0.4392156862745098))
                    .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .padding(.all, 1.0)
                    .scaledToFit()
            }
        }
    }
}

//struct BookRow_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            BookRow(book: books[0])
//            BookRow(book: books[1])
//        }
//        .previewLayout(.fixed(width: 300, height: 70))
//    }
//}
