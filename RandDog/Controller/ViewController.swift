//
//  ViewController.swift
//  RandDog
//
//  Created by Mahmoud on 5/29/19.
//  Copyright © 2019 Mahmoud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    
    var breeds: [String] = ["greyhound","poodle"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self
        pickerView.delegate = self
        
        
        DogAPI.requestBreedsList(complitionHandler: handelBreedsListResponse(breeds:error:))
        
       
            
            
            
            
            
//            do{
//                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
//                let url = json["message"] as! String
//                print(url)
//
//
//
//            }catch{
//                print(error)
//            }
        }
    
    func handelBreedsListResponse(breeds:[String],error:Error?){
        self.breeds = breeds
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
    }
    
    func handelRandomImageResponse(imageData:DogImage?,error:Error?){
        guard let imageURL = URL(string: imageData?.message ?? "") else {return}
        
        DogAPI.requestImageFile(url: imageURL, completionHandler: self.handelImageFileResponse(image:error:))
    }
    
    
    func handelImageFileResponse(image:UIImage?,error:Error?){
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }
    

    }

extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1	
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return breeds.count
    }
    
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return breeds[row]
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogAPI.requestRandomImage(breed: breeds[row], comletionHandler: handelRandomImageResponse(imageData:error:))
    }
    
}
