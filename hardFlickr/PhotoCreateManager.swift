//
//  PhotoCreateManager.swift
//  hardFlickr
//
//  Created by Андрей Коноплев on 26.09.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit


//MARK: - get hieght for array of photos 
class PhotoCreateManager {
    static func getSizePhoto(PhotoModelArray array: [PhotoModel], success: @escaping ()->Void) {
        let countOfPhoto = array.count
        var i = 0
        
        func getSize() {
            if i < array.count {
                PhotoListManager.getPhotoSize(object: array[i]) {
                    if i != countOfPhoto - 1 {
                        i = i + 1
                        print(i)
                        getSize()
                    } else {
                        success()
                    }
                }
                
            } else {
                return
            }
        }
        
        getSize()
    }
}
