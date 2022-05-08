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
    var lastUpdate: String? = nil
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
                    self.getFirstLocalJson()
                }
            }
            
        }else{
            getLastLocalJson(fileName: "bookData")
        }
        
    }
    
    
    // jadid
    func getLastLocalJson(fileName:String){
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let pathWithFileName = documentDirectory.appendingPathComponent(fileName)
            do {
                let data = try? Data(contentsOf: pathWithFileName)
                if (data != nil){
                    let posts = try? JSONDecoder().decode(Posts.self, from: data!)
                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                        self.books = posts!.posts
                    }
                }else {
                    getFirstLocalJson()
                }
                
                print("yes i get it")
            } catch {
                print("oh nooo222o \(error)")
                // handle error
            }
        }
        
    }
    
    
    
    func getLastLocalJsonUpdateDate() -> String  {
        
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let pathWithFileName = documentDirectory.appendingPathComponent("lastUpdate")
            do {
                let data = try? Data(contentsOf: pathWithFileName)
                if (data != nil){
                    let update = try? JSONDecoder().decode(Update.self, from: data!)
                    lastUpdate = update!.date
                    
                }else {
                    
                    getFirstLocalJsonUpdateDate()
                }
                
                print("yes i get it")
            } catch {
                print("oh nooo222o \(error)")
                // handle error
            }
        }
        return  lastUpdate ??  "2022-04-26 20:23:37"
        
    }
    
    
    func getFirstLocalJsonUpdateDate() -> String  {
        
        let url = Bundle.main.url(forResource: "lastUpdate", withExtension: "json")
        print("my Local url is: ", url)
        let data = try? Data(contentsOf: url!)
        let date = try? JSONDecoder().decode(Update.self, from: data!)
        
        return date!.date
        
    }
    
    func getFirstLocalJson()  {
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
            getLastLocalJson(fileName: "bookData")
            
        } catch {
            print("Error in save to local json file \(error)")
            getFirstLocalJson()
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
            print("update1",getLastLocalJsonUpdateDate())
            print("update2",date!.date )
            
            if (checkVersionUpdateJson(update_offline: getLastLocalJsonUpdateDate(), update_online: date!.date) == true) {
                
                // should handle online json
                self.getOnlineJson(fromURLString: urlString) { (result) in
                    switch result {
                    case .success(let data):
                        print("yes i will handle json online")
                        self.parse(jsonData: data)
                    case .failure(let error):
                        print("i can not and i will handle offline \(error)")
                        self.getFirstLocalJson()
                    }
                }
                
                print("it true")
                
            } else {
                print("it false")
                // should read local json
                getFirstLocalJson()
                
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

