//
//  DogAPI.swift
//  RandDog
//
//  Created by Mahmoud on 5/29/19.
//  Copyright © 2019 Mahmoud. All rights reserved.
//

import Foundation
import UIKit
class DogAPI{
    enum Endpoint {
        case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        case listAllBreeds
        var url:URL {
            return URL(string: self.stringValue)!
        }
        var stringValue: String{
            switch self {
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breeds/image/random"
                
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    
    class  func requestImageFile(url: URL, completionHandler:@escaping (UIImage?,Error?) -> Void) {
        
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, erorr) in
            guard let data = data else {
                completionHandler(nil,erorr)
                return
            }
            let downloadedImage = UIImage(data: data)
          completionHandler(downloadedImage,nil)
            
            
            
        })
        task.resume()
        
        
    }
    
    class func requestBreedsList(complitionHandler: @escaping ([String],Error?) ->Void){
        let task = URLSession.shared.dataTask(with: Endpoint.listAllBreeds.url) { (data, response, error) in
            guard let data = data else{
                complitionHandler([],error)
                
                return
                
            }
            let decoder = JSONDecoder()
            let breedsResponse = try! decoder.decode(BreedsListResponse.self, from: data)
            let breeds = breedsResponse.message.keys.map({$0})
            complitionHandler(breeds,nil)
        }
        task.resume()
    }
    
    
    
    class func requestRandomImage(breed: String,comletionHandler: @escaping (DogImage? , Error?) -> Void ){
        let randomImageEndPoint = DogAPI.Endpoint.randomImageForBreed(breed).url
        
        
        let task = URLSession.shared.dataTask(with: randomImageEndPoint) { (data, response, error) in
            
            guard let data = data else {
                comletionHandler(nil , error)
                return
            }
            print(data)
            
            let decoder = JSONDecoder()
            
            let imageData =  try! decoder.decode(DogImage.self, from: data)
            print(imageData)
            comletionHandler(imageData,nil)
    }
        task.resume()
    
    
}
}
