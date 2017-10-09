//
//  SaveObjects.swift
//  hardFlickr
//
//  Created by Андрей Коноплев on 28.09.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit


// singleton for all photos which flickr return
class DataStorage {

    static let dataStorage = DataStorage()
    
    var objectsArray = [PhotoModel]()
    
    func setObjects(array: [PhotoModel]) {
        objectsArray.append(contentsOf: array)
    }
    
    func removeObjects() {
        objectsArray.removeAll()
    }
}

// singleton for photos which load in tape
class DataTapeStorage {
    
    static let dataTapeStorage = DataTapeStorage()
    
    var objectsArrayForTape = [PhotoModel]()

    func setObjectForTape(num: Int, objectsArray: [PhotoModel]) {
        
        var i = num
        let i2 = i + 10
        while i < i2 {
            if i < objectsArray.count  {
                objectsArrayForTape.append(objectsArray[i])
                i = i + 1
            } else {
                print("Photo is nil")
                break
            }
        }
    }
}

