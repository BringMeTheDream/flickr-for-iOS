//
//  API_conf.swift
//  hardFlickr
//
//  Created by Андрей Коноплев on 22.09.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import Foundation

//MARK: - function where we create request to server with our input params and url

class API_conf {
    static func getRequest(url: String, params: [String: Any] ) -> URLRequest {
        
        var url = url + "?"
        
        for (key, value) in params {
            url = url + "\(key)" + "=" + "\(value)" + "&"
        }
        
        url = String(url.characters.dropLast())
        
        var request = URLRequest(url: URL(string: url )!)
        request.httpMethod = "GET"
        
        return request
    }
}

//MARK: - work with server response

extension API_conf {
    static func meetDataFromServer(Data: Data?, RequestError: Error? , success: (_ json: Any)->Void, failure: (_ errorDescription: String)->Void) {
        
        if let error = RequestError {
            switch error._code {
            case NSURLErrorTimedOut:
                failure("Time is over")
            case NSURLErrorBadURL:
                failure("Bad URL")
            case NSURLErrorFileDoesNotExist:
                failure("file doesn`t exist")
            case  NSURLErrorNotConnectedToInternet:
                failure("Нет подключения к интернету")
            default:
                failure("писос")
            }
        }
        
        guard let data = Data else {
            failure("Data is nil")
            return
        }

        do {
           let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            success(json)
        } catch {
            failure("Serialize fail lol")
            return
        }
    }
}

//MARK:- create photo URL
extension API_conf {
    static func createImgURL(object: PhotoModel)-> String {
        let url = "https://farm\(object.farm).staticflickr.com/\(object.server)/\(object.photoId)_\(object.secret)_m.jpg"
        return url
    }
}
