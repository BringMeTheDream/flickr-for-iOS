//
//  File.swift
//  hardFlickr
//
//  Created by Андрей Коноплев on 22.09.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import Foundation

//MARK:- get Photo List
class API_WRAPPER {
    static func getPopularPhotoList(succes: @escaping (_ json: Any)->Void, failure: @escaping (_ errorDescription: String)->Void)-> URLSessionTask {
        let url = constant.Api_const.base_url
        let params: [String: Any] = [
            "method" : "flickr.interestingness.getList",
            "api_key" : constant.Api_const.api_key,
            "extras" : "date_upload%2Cowner_name%2Curl_m",
            "per_page" : constant.Api_const.photoCount,
            "format" : "json",
            "nojsoncallback" : 1]
        
        let request = API_conf.getRequest(url: url, params: params)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, requestError) in
            API_conf.meetDataFromServer(Data: data, RequestError: requestError, success: succes, failure: failure)
        }
        
        dataTask.resume()
        return dataTask
        
    }
}

//MARK: - get Height of Photo
extension API_WRAPPER {
    static func getPhotoHeight(photoId: String, success: @escaping (_ json: Any)-> Void, failure: @escaping (_ errorDescription: String)-> Void)-> URLSessionTask {
        let url = constant.Api_const.base_url
        let params: [String: Any] = [
            "method" : "flickr.photos.getSizes",
            "api_key" : constant.Api_const.api_key,
            "photo_id" : photoId,
            "format" : "json",
            "nojsoncallback" : 1]
        
        let request = API_conf.getRequest(url: url, params: params)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, requestError) in
            API_conf.meetDataFromServer(Data: data, RequestError: requestError, success: success, failure: failure)
        }
        
        dataTask.resume()
        return dataTask
    }
}

//MARK: - get Location of photo

extension API_WRAPPER {
    static func getPhotoLocation(photoID: String, success: @escaping (_ json: Any)-> Void, failure: @escaping (_ errorDescription: String)-> Void) -> URLSessionTask  {
        let url = constant.Api_const.base_url
        let params: [String: Any] = [
            "method" : "flickr.photos.geo.getLocation",
            "api_key" : constant.Api_const.api_key,
            "photo_id" : photoID,
            "format" : "json",
            "nojsoncallback" : 1]
        
        let request = API_conf.getRequest(url: url, params: params)
        
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, requestError) in
            API_conf.meetDataFromServer(Data: data, RequestError: requestError, success: success, failure: failure)
        }
        dataTask.resume()
        return dataTask
    }
}

