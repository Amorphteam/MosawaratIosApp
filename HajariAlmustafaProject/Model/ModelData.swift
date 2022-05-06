//
//  ModelData.swift
//  HajariAlmustafaProject
//
//  Created by Samano on 4/12/22.
//

import Foundation
import Network


@MainActor class ModelData: ObservableObject  {
    var updateDate: Data? = nil
    @Published var books = [Book]()
    let urlString = "http://al-mostafa.co/makhtot/wp-json/fr-api/v1/posts"
    var urlUpdate = "http://al-mostafa.co/makhtot/wp-json/fr-api/v1/last-update"


    init(){

        // For get online data
        if InternetConnectionManager.isConnectedToNetwork(){

            // update date
            self.getOnlineUpdateDate(fromURLString: urlUpdate) { (result) in
                switch result {
                case .success(let data):
                    print("yes it is succeeded")
                    self.parseUpdateDate(jsonData: data)
                case .failure(let error):
                    print("nooo it is failed \(error)")
                    self.getLocalJson()
                }
            }


        }else{
            // If no internet available
//            getLocalJson()
            getAnything(fileName: "bookData")
        }

    }


// jadid
    func getAnything(fileName:String){
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                             in: .userDomainMask).first {
            let pathWithFileName = documentDirectory.appendingPathComponent(fileName)
            do {
                let data = try? Data(contentsOf: pathWithFileName)
                let posts = try? JSONDecoder().decode(Posts.self, from: data!)
                DispatchQueue.main.asyncAfter(deadline: .now()) {
                    self.books = posts!.posts
               }

                print("yes i get it")
            } catch {
                print("oh nooo222o \(error)")
                // handle error
            }
        }

    }

    
    func getLocalJsonUpdateDate() -> String  {
        
         let url = Bundle.main.url(forResource: "lastUpdate", withExtension: "json")
        print("my Local url is: ", url)
        let data = try? Data(contentsOf: url!)
        let date = try? JSONDecoder().decode(Update.self, from: data!)
        
        return date!.date

    }

    
    
    func getLocalJson()  {
        
        guard let url = Bundle.main.url(forResource: "bookData", withExtension: "json")
        else {
            print("Json file not found")
            return
        }

        print("my Local url is: ", url)
        let data = try? Data(contentsOf: url)
        let posts = try? JSONDecoder().decode(Posts.self, from: data!)
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.books = posts!.posts
       }


    }


   
   

    
    
    

    // jadid tagir dadde
    func parse(jsonData: Data) {
        do {

            try saveAnything(jsonData: updateDate!, fileName: "lastUpdate")
            try saveAnything(jsonData: jsonData, fileName: "bookData")
            getAnything(fileName: "bookData")

        } catch {
            print("Error in save to local json file \(error)")
            getLocalJson()
        }
    }
    
    
        func saveAnything(jsonData:Data, fileName:String){
            if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                                 in: .userDomainMask).first {
                let pathWithFileName = documentDirectory.appendingPathComponent(fileName)
                do {
                    try jsonData.write(to: pathWithFileName)
                    print("yes i write it")
                } catch {
                    print("oh noooo \(error)")
                    // handle error
                }
            }

        }


    
    func getOnlineJson(fromURLString urlString: String,
                       completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }

                if let data = data {
                    completion(.success(data))
                }
            }

            urlSession.resume()
        }
    }
    
    
    
    func getOnlineUpdateDate(fromURLString urlString: String,
                             completion: @escaping (Result<Data, Error>) -> Void) {
        if let url = URL(string: urlString) {
            let urlSession = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                }

                if let data = data {
                    completion(.success(data))
                }
            }

            urlSession.resume()
        }
    }

    
 
    
    

    func parseUpdateDate(jsonData: Data) {
        updateDate = jsonData
        do {

            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [.mutableContainers, .mutableLeaves])
            let date = try? JSONDecoder().decode(Update.self, from: jsonData)
            print("update1",getLocalJsonUpdateDate())
            print("update2",date!.date )

            if (checkVersionUpdateJson(update_offline: getLocalJsonUpdateDate(), update_online: date!.date) == true) {

                // should handle online json
                self.getOnlineJson(fromURLString: urlString) { (result) in
                    switch result {
                    case .success(let data):
                        print("yes i will handle json online")
                        self.parse(jsonData: data)
                    case .failure(let error):
                        print("i can not and i will handle offline \(error)")
                        self.getLocalJson()
                    }
                }

                print("it true")

            } else {
                print("it false")
                // should read local json
                getLocalJson()

            }

        } catch {
            print("Error in save to local json file")
        }
    }


    
    
    
    func checkVersionUpdateJson(update_offline: String, update_online: String) -> Bool{
        if (update_offline == update_online ){
            print("it false")

            return false

        }
        print("it true")
        return true

    }
}

