//
//  Model.swift
//  hardFlickr
//
//  Created by Андрей Коноплев on 22.09.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class PhotoModel {
    
    let owner: String
    let secret: String
    let server: String
    let photoId: String
    let farm: Int
    let dateUpload: Int
    let ownerName: String
    let title: String?
    
    var url: String?
    var size: CGSize?
    var latitude: Double? = nil
    var longitude: Double? = nil
    var country: String?
    var city: String?
    
    init(owner: String, secret: String, server: String, photoId: String, farm: Int,dateUpload:Int, ownerName: String,title: String?) {
        
        self.owner = owner
        self.secret = secret
        self.server = server
        self.photoId = photoId
        self.farm = farm
        self.title = title
        self.dateUpload = dateUpload
        self.ownerName = ownerName
    }
    
    func getLocation()-> String {
        if city == nil || city == "" {
            return "Местоположение отсутствует"
        }
        return "\(String(describing: city ?? "")), \(country ?? "")"
    }
    
}

