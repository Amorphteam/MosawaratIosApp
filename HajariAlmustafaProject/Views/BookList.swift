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
    let coloredNavAppearance = UINavigationBarAppearance()
    @State private var selectedItemId: UUID?
    
    
    
    init() {
        
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor(Color("Primary2"))
        coloredNavAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredNavAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor(Color("Background"))
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = UIColor(Color("Background"))
        
    
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
                    .navigationTitle("قائمة المخطوطات")
                    
                }
                
                .onAppear {
                    // Set the default to clear
                    UITableView.appearance().backgroundColor = UIColor(Color("Background"))
                    
                    
                }
                
            }
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color("Background")/*@END_MENU_TOKEN@*/)
            
        }
//        .navigationViewStyle(StackNavigationViewStyle())

        
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always),prompt: "ابحث عن عنوان المخطوطة أو مؤلفها أو مصدرها") {
            
        }
        .accentColor(.white)
        
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
