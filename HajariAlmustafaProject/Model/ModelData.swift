//
//  ModelData.swift
//  HajariAlmustafaProject
//
//  Created by Samano on 4/12/22.
//

import Foundation
import Network


class ModelData: ObservableObject  {
    var updateDateObject: Any? = nil
    @Published var books = [Book]()
    @Published var last_date_update_offline = String()
    @Published var last_date_update_online = String()
    
    let urlString = "http://al-mostafa.co/makhtot/wp-json/fr-api/v1/posts"
    var urlUpdate = "http://al-mostafa.co/makhtot/wp-json/fr-api/v1/last-update"
    
    
    init(){
        
        // For get online data
        if InternetConnectionManager.isConnectedToNetwork(){
            
            // update date
            self.getOnlineUpdateDate(fromURLString: urlUpdate) { (result) in
                switch result {
                case .success(let data):
                    self.parseUpdateDate(jsonData: data)
                case .failure(let error):
                    print(error)
                    self.getLocalJson()
                }
            }
            
            
        }else{
            // If no internet available
            getLocalJson()
        }
        
    }
    
    
    func checkLastDate(){
        
        
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
        self.books = posts!.posts
        
    }
    
    func save(jsonObject: Any, toFilename filename: String) throws -> Bool{
        
        if let localUrl = Bundle.main.url(forResource: filename, withExtension: "json"){
            
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            try data.write(to: localUrl, options: [.atomicWrite])
            
            return true
            
        }
        return false
        
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
    
    
    func parse(jsonData: Data) {
        do {
            
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [.mutableContainers, .mutableLeaves])
            
            let saved = try save(jsonObject: jsonObject, toFilename: "bookData")
            let savedNewDate = try save(jsonObject: updateDateObject, toFilename: "lastUpdate")

            getLocalJson()
            
        } catch {
            print("Error in save to local json file")
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
    
    func getLocalJsonUpdateDate() -> String  {
        let url = Bundle.main.url(forResource: "lastUpdate", withExtension: "json")
        print("my Local url is: ", url)
        let data = try? Data(contentsOf: url!)
        let date = try? JSONDecoder().decode(Update.self, from: data!)
        return date!.date
        
    }
    
    
    func parseUpdateDate(jsonData: Data) {
        do {
            
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData, options: [.mutableContainers, .mutableLeaves])
            updateDateObject = jsonObject
            let date = try? JSONDecoder().decode(Update.self, from: jsonData)
            print("update1",getLocalJsonUpdateDate())
            print("update2",date!.date )
            
            if (checkVersionUpdateJson(update_offline: getLocalJsonUpdateDate(), update_online: date!.date) == true) {
                
                // should handle online json
                self.getOnlineJson(fromURLString: urlString) { (result) in
                    switch result {
                    case .success(let data):
                        self.parse(jsonData: data)
                    case .failure(let error):
                        print(error)
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
        return true
        print("it true")
        
    }
}

