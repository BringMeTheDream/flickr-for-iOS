//
//  MapVC.swift
//  hardFlickr
//
//  Created by Андрей Коноплев on 07.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit
import MapKit

class MapVC: UIViewController {
    
    //MARK: - vars
    var object: PhotoModel?
    
    //MARK:- outlets
    @IBOutlet weak var map: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sendLocation(photoModel: object)
        
    }

    //MARK:- create closer map
    let regionRadius : CLLocationDistance = 1000
    func  centerMapOnLocation (location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        map.setRegion(coordinateRegion, animated: true)
    }
    
    //MARK: - check model and perfom location or alert message
    func sendLocation(photoModel: PhotoModel?) {
        guard let object = photoModel else {
            return
        }
        guard let longitude = object.longitude else {
            return
        }
        guard let latitude = object.latitude else {
           return
        }
        
        if latitude == 0 || longitude == 0 {
            let alertController = UIAlertController(title: "Ошибк", message: "Данные о местоположении отстутсвуют", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ок", style: .default)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            return
        } else {
            let initialLocation = CLLocation(latitude: latitude, longitude: longitude)
            centerMapOnLocation (location: initialLocation)
        }

    }
}
