//
//  BookList.swift
//  HajariAlmustafaProject
//
//  Created by Samano on 4/13/22.
//

import SwiftUI

struct BookList: View {
    @State private var searchText = ""
    @ObservedObject var datas = ModelData()
    let appearance = UINavigationBarAppearance()
    @State private var selectedItemId: UUID?
    
    
    
    init() {
        
        // this overrides everything you have set up earlier.
        appearance.configureWithTransparentBackground()
        
        // this only applies to big titles
        appearance.largeTitleTextAttributes = [
            .font :UIFont(name: "Tajawal-Regular", size: 30)!,
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        // this only applies to small titles
        appearance.titleTextAttributes = [
            
            .font : UIFont(name: "Tajawal-Regular", size: 20)!,
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color("Primary2"))
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor(Color("Background"))
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor(Color("Background"))
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        
        
        // for test font name
        //        for family: String in UIFont.familyNames
        //               {
        //                   print(family)
        //                   for names: String in UIFont.fontNames(forFamilyName: family)
        //                   {
        //                       print("== \(names)")
        //                   }
        //               }
        
    }
    
    var body: some View {
        
        NavigationView {
            VStack {
                List {
                    ForEach(searchResults, id: \.self) { bookItem in
                        
                        NavigationLink(
                            
                            tag: bookItem.id ,
                            selection: self.$selectedItemId) {
                                BookDetail(book: bookItem)
                            } label: {
                                BookRow(book: bookItem)
                            }
                            .listRowBackground(
                                bookItem.id == self.selectedItemId ? Color(UIColor(Color("Primary2"))) : Color(UIColor(Color("Background")))
                            )
                        
                    }
                    
                    .listRowBackground(Color("Background"))
                    .navigationBarTitle(Text("قائمة المخطوطات").font(.subheadline), displayMode: .large)
                      
                }
                
                .onAppear {
                    // Set the default to clear
                    UITableView.appearance().backgroundColor = UIColor(Color("Background"))
                    
                }
                
            }
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("Background")/*@END_MENU_TOKEN@*/)
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),prompt: "ابحث عن عنوان المخطوطة أو مؤلفها أو مصدرها") {
            
        }
        .accentColor(.white)
        .font(Font.custom("Tajawal-Regular", size: 16))
        .environment(\.layoutDirection, .rightToLeft)
        
    }
    
    
    var searchResults: [Book] {
        if searchText.isEmpty {
            return datas.books
        } else {
            return datas.books.filter ({ "\($0)".contains(searchText) })
        }
    }
    
}



struct BookList_Previews: PreviewProvider {
    static var previews: some View {
        ForEach(["iPhone SE (2nd generation)", "iPhone XS Max"], id: \.self) { deviceName in
            BookList()
                .previewDevice(PreviewDevice(rawValue: deviceName))
                .previewDisplayName(deviceName)
        }
    }
}

extension UINavigationController {
    // Remove back button text
    open override func viewWillLayoutSubviews() {
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
}
