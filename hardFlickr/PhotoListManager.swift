//
//  PhotoListManager.swift
//  hardFlickr
//
//  Created by Андрей Коноплев on 22.09.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import SwiftyJSON

class PhotoListManager {

//MARK: - get Photo List and push in model
    static func getPhotoListObject(success: @escaping (_ photos: [PhotoModel])->Void, failure: @escaping (_ errorDescription: String)->Void) {
        _ = API_WRAPPER.getPopularPhotoList(succes: { (response) in
            
            var photoArray = [PhotoModel]()
            let jsonResponse = JSON(response)
            
            let arrayOfPhotos = jsonResponse["photos"]["photo"].arrayValue
            
            for photo in arrayOfPhotos {
                let owner = photo["owner"].stringValue
                let secret = photo["secret"].stringValue
                let server = photo["server"].stringValue
                let photoId = photo["id"].stringValue
                let farm = photo["farm"].intValue
                let title = photo["title"].string
                let dateUpload = photo["dateupload"].intValue
                let ownerName = photo["ownername"].stringValue
                
                let newPhoto = PhotoModel(owner: owner, secret: secret, server: server, photoId: photoId, farm: farm, dateUpload: dateUpload, ownerName: ownerName, title: title)
                newPhoto.url = API_conf.createImgURL(object: newPhoto)
                photoArray.append(newPhoto)
            }
            
            success(photoArray)
            
        }, failure: { (errorDescription) in
            failure(errorDescription)
            
        })
    }
}

//MARK: - get Photo Hight for single photo
extension PhotoListManager {
    static func getPhotoSize(object: PhotoModel ,success: @escaping ()->Void) {
        _ = API_WRAPPER.getPhotoHeight(photoId: object.photoId, success: { (response) in
            let jsonSizes = JSON(response)
            let arrayOfSizes = jsonSizes["sizes"]["size"].arrayValue
            
            for size in arrayOfSizes {
                if size["label"] == "Medium" {
                    let width = size["width"].doubleValue
                    let height = size["height"].doubleValue
                    
                    object.size = CGSize(width: width, height: height)
                }
            }
            
            success()
            
            
        }) { (requestError) in
            print(requestError)
        }
        
    }
}

extension PhotoListManager {
    static func getLocation(object: PhotoModel, success: @escaping ()->Void) {
        _ = API_WRAPPER.getPhotoLocation(photoID: object.photoId, success: { (response) in
          
            let jsonLocation = JSON(response)
            let country = jsonLocation["photo"]["location"]["country"]["_content"].stringValue
            let city = jsonLocation["photo"]["location"]["region"]["_content"].stringValue
            let longitude = jsonLocation["photo"]["location"]["longitude"].doubleValue
            let latitude = jsonLocation["photo"]["location"]["latitude"].doubleValue
            object.latitude = latitude
            object.longitude = longitude
            object.city = city
            object.country = country
            
            success()
            
        }) { (requestError) in
            print(requestError)
        }
        
    }
}


