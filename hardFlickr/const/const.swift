//
//  File.swift
//  hardFlickr
//
//  Created by Андрей Коноплев on 22.09.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import Foundation


struct constant {
    
    struct Api_const {
       static let api_key = "aa0d8bc526d857a0ec0f10bab4ab3c83"
       static let base_url = "https://api.flickr.com/services/rest/"
       static let photoCount = 50 // numbers request photos to flickr
        static let loadPhotoCount = 10 //  numbers of photos uploads when scrolling
    }
    
    struct Collection_option {
        static let numbersItemInLine = 3
    }
}
