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
                    .padding(.all, 2.0)
                    .scaledToFit()
                    .font(Font.custom("Tajawal-Regular", size: 18))


                
                Text("\(book.details.author_name)")
                    .foregroundColor(Color(red: 0.4392156862745098, green: 0.4392156862745098, blue: 0.4392156862745098))
                    .lineLimit(/*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .padding(.all, 2.0)
                    .scaledToFit()
                    .font(Font.custom("Tajawal-Regular", size: 14))

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
