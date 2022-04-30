//
//  BookDetail.swift
//  HajariAlmustafaProject
//
//  Created by Samano on 4/13/22.
//
import SwiftUI
import UIKit

struct BookDetail: View {
    var book: Book
    @State private var isActive : Bool = false
    
    
    var body: some View {
        
        ScrollView {
            
            Text("صور المخطوطة")
                .font(.footnote)
                .padding(/*@START_MENU_TOKEN@*/.all, 6.0/*@END_MENU_TOKEN@*/)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color("text"))
                .opacity(/*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
            
            
            HStack{
                
                NavigationLink(destination: SelecteImage(imageURL: book.images[0].image_url, book: book)){
                    SquareImage(imageURL: book.images[0].thumbnail_url)
                    
                }
                //                .buttonStyle(PlainButtonStyle())
                
                NavigationLink(destination: SelecteImage(imageURL: book.images[1].image_url, book: book)){
                    SquareImage(imageURL: book.images[1].thumbnail_url)
                    
                }
                //                .buttonStyle(PlainButtonStyle())
            }
            
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding([.top, .leading, .bottom], 4.0)
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
            .cornerRadius(18.0)
            
            
            
            
            Text("المعلومات العامة")
                .font(.footnote)
                .padding(/*@START_MENU_TOKEN@*/.all, 6.0/*@END_MENU_TOKEN@*/)
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundColor(Color("text"))
                .opacity(/*@START_MENU_TOKEN@*/0.5/*@END_MENU_TOKEN@*/)
            
            VStack {
                
                HStack(alignment: .bottom, spacing: 4){
                    Text("المؤلف")
                        .font(.subheadline)
                        .foregroundColor(Color(red: 0.4117647058823529, green: 0.40784313725490196, blue: 0.40784313725490196))
                        .frame(maxWidth: 100, alignment: .leading)
                        .padding(.horizontal, 4.0)
                    Spacer()
                    
                    Text(book.details.author_name)
                        .foregroundColor(Color("text"))
                        .font(.subheadline)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: 900, alignment: .leading)

                    
                }
                .padding(.all, 16.0)
                Group {
                    VStack {
                        Divider()
                        HStack(alignment: .bottom, spacing: 4){
                            
                            Text("الناسخ")
                                .font(.subheadline)
                                .foregroundColor(Color(red: 0.4117647058823529, green: 0.40784313725490196, blue: 0.40784313725490196))
                                .padding(.horizontal, 4.0)
                                .frame(maxWidth: 100, alignment: .leading)
                            
                            Spacer()
                            Text(book.details.writer_name)
                                .foregroundColor(Color("text"))
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: 900, alignment: .leading)

                            
                        }
                        .padding(.all, 16.0)
                    }
                    
                    VStack {
                        Divider()
                        HStack(alignment: .bottom, spacing: 4){
                            
                            Text("عدد الصفحات")
                                .font(.subheadline)
                                .foregroundColor(Color(red: 0.4117647058823529, green: 0.40784313725490196, blue: 0.40784313725490196))
                                .multilineTextAlignment(.trailing)
                                .padding(.horizontal, 4.0)
                                .frame(maxWidth: 100, alignment: .leading)
                            
                            Spacer()
                            Text(book.details.page_count)
                                .foregroundColor(Color("text"))
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: 900, alignment: .leading)

                            
                        }
                        .padding(.all, 16.0)
                    }
                    
                    VStack {
                        Divider()
                        HStack(alignment: .bottom, spacing: 4){
                            
                            Text("المصدر")
                                .font(.subheadline)
                                .foregroundColor(Color(red: 0.4117647058823529, green: 0.40784313725490196, blue: 0.40784313725490196))
                                .multilineTextAlignment(.trailing)
                                .padding(.horizontal, 4.0)
                                .frame(maxWidth: 100, alignment: .leading)
                            
                            Spacer()
                            Text(book.details.source)
                                .foregroundColor(Color("text"))
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: 900, alignment: .leading)

                            
                        }
                        .padding(.all, 16.0)
                    }
                    VStack {
                        Divider()
                        HStack(alignment: .bottom, spacing: 4){
                            
                            Text("نوع الخط")
                                .font(.subheadline)
                                .foregroundColor(Color(red: 0.4117647058823529, green: 0.40784313725490196, blue: 0.40784313725490196))
                                .multilineTextAlignment(.trailing)
                                .padding(.horizontal, 4.0)
                                .frame(maxWidth: 100, alignment: .leading)
                            
                            Spacer()
                            Text(book.details.font_type)
                                .foregroundColor(Color("text"))
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: 900, alignment: .leading)

                            
                        }
                        .padding(.all, 16.0)
                    }
                    
                    VStack {
                        Divider()
                        HStack(alignment: .bottom, spacing: 4){
                            
                            Text("الموضوع")
                                .font(.subheadline)
                                .foregroundColor(Color(red: 0.4117647058823529, green: 0.40784313725490196, blue: 0.40784313725490196))
                                .multilineTextAlignment(.trailing)
                                .padding(.horizontal, 4.0)
                                .frame(maxWidth: 100, alignment: .leading)
                            
                            Spacer()
                            Text(book.details.category)
                                .foregroundColor(Color("text"))
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: 900, alignment: .leading)

                            
                        }
                        .padding(.all, 16.0)
                    }
                    VStack {
                        Divider()
                        HStack(alignment: .bottom, spacing: 4){
                            
                            Text("تاريخ النسخ")
                                .font(.subheadline)
                                .foregroundColor(Color(red: 0.4117647058823529, green: 0.40784313725490196, blue: 0.40784313725490196))
                                .multilineTextAlignment(.trailing)
                                .padding(.horizontal, 4.0)
                                .frame(maxWidth: 100, alignment: .leading)
                            
                            Spacer()
                            Text(book.details.writing_date)
                                .foregroundColor(Color("text"))
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: 900, alignment: .leading)

                            
                        }
                        .padding(.all, 16.0)
                    }
                    VStack {
                        Divider()
                        HStack(alignment: .bottom, spacing: 4){
                            
                            Text("أوله")
                                .font(.subheadline)
                                .foregroundColor(Color(red: 0.4117647058823529, green: 0.40784313725490196, blue: 0.40784313725490196))
                                .multilineTextAlignment(.trailing)
                                .padding(.horizontal, 4.0)
                                .frame(maxWidth: 100, alignment: .leading)
                            
                            Spacer()
                            Text(book.details.note1)
                                .foregroundColor(Color("text"))
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: 900, alignment: .leading)

                        }
                        .padding(.all, 16.0)
                    }
                    
                    VStack {
                        Divider()
                        HStack(alignment: .bottom, spacing: 4){
                            
                            Text("آخره")
                                .font(.subheadline)
                                .foregroundColor(Color(red: 0.4117647058823529, green: 0.40784313725490196, blue: 0.40784313725490196))
                                .multilineTextAlignment(.trailing)
                                .padding(.horizontal, 4.0)
                                .frame(maxWidth: 100, alignment: .leading)
                            
                            Spacer()
                            Text(book.details.note2)
                                .foregroundColor(Color("text"))
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: 900, alignment: .leading)

                        }
                        .padding(.all, 16.0)
                    }
                    
                    VStack {
                        Divider()
                        HStack(alignment: .bottom, spacing: 4){
                            
                            Text("الملاحظات")
                                .font(.subheadline)
                                .foregroundColor(Color(red: 0.4117647058823529, green: 0.40784313725490196, blue: 0.40784313725490196))
                                .multilineTextAlignment(.trailing)
                                .padding(.horizontal, 4.0)
                                .frame(maxWidth: 100, alignment: .leading)
                            Spacer()
                            VStack{
                                
                                Text(book.details.note3)
                                    .foregroundColor(Color("text"))
                                    .font(.subheadline)
                                    .multilineTextAlignment(.leading)
                                    .allowsTightening(true)
                                    .minimumScaleFactor(0.75)
                                    .frame(maxWidth: 900, alignment: .leading)

                                
                                Text(book.details.note4)
                                    .foregroundColor(Color("text"))
                                    .font(.subheadline)
                                    .multilineTextAlignment(.leading)
                                    .allowsTightening(true)
                                    .minimumScaleFactor(0.75)
                                    .frame(maxWidth: 900, alignment: .leading)

                                Text(book.details.note5)
                                    .foregroundColor(Color("text"))
                                    .font(.subheadline)
                                    .multilineTextAlignment(.leading)
                                    .allowsTightening(true)
                                    .minimumScaleFactor(0.75)
                                    .frame(maxWidth: 900, alignment: .leading)

                                
                            }
                        }
                        .padding(.all, 16.0)
                    }
                    VStack {
                        Divider()
                        HStack(alignment: .bottom, spacing: 4){
                            
                            Text("عدد الأسطر")
                                .font(.subheadline)
                                .foregroundColor(Color(red: 0.4117647058823529, green: 0.40784313725490196, blue: 0.40784313725490196))
                                .multilineTextAlignment(.trailing)
                                .padding(.horizontal, 4.0)
                                .frame(maxWidth: 100, alignment: .leading)
                            
                            Spacer()
                            Text(book.details.note6)
                                .foregroundColor(Color("text"))
                                .font(.subheadline)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: 900, alignment: .leading)

                            
                        }
                        .padding(.all, 16.0)
                    }
                    
                }
            }
            .padding([.top, .leading, .bottom], 4.0)
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
            .cornerRadius(18.0)
            
        }
        .padding(.horizontal, 20.0)
        .navigationTitle(book.post_name)
        .navigationBarTitleDisplayMode(.inline)
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("Background")/*@END_MENU_TOKEN@*/)
        .environment(\.layoutDirection, .rightToLeft)
        
    }
    
}




//struct BookDetail_Previews: PreviewProvider {
//    static var previews: some View {
//        BookDetail(book: BookList)
//    }
//}

