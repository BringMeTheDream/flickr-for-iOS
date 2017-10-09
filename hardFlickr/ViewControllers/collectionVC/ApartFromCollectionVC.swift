//
//  ApartFromCollectionVC.swift
//  hardFlickr
//
//  Created by Андрей Коноплев on 07.10.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit
import Kingfisher
import MapKit

class ApartFromCollectionVC: UIViewController {
    
    //MARK: - vars
    var object : PhotoModel?
    let frame = UIScreen.main.bounds.width
    
    //MARK: - outlets
   
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    //MARK:- load
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let object = object else { return }
        sendRequst(object: object)
        
    }
    
    //MARK: - load info about selected photo
    func loadInfo(object: PhotoModel) {
        navigationItem.title = object.title
        usernameLabel.text = object.ownerName
        photoImage.kf.setImage(with: URL(string: object.url ?? ""))
        timeLabel.text = getRightTime(TimeInterval: object.dateUpload)
        self.locationLabel.text = object.getLocation()
    }
    
    //MARK: get height and location of Photo
    func sendRequst(object: PhotoModel) {
        PhotoListManager.getPhotoSize(object: object) {
            PhotoListManager.getLocation(object: object) {
                DispatchQueue.main.async {
                    self.heightConstraint.constant = self.getRightHeight(model: object, frame: self.frame)
                    self.loadInfo(object: object)
                }
            }
        }
    }
    
    @IBAction func mapButton(_ sender: Any) {
        performSegue(withIdentifier: "mapSegue", sender: self)
    }
    
}
    



extension ApartFromCollectionVC {
    
    //MARK: - get time publish
    func getRightTime(TimeInterval date: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(date))
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy HH:ss"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    
    //MARK: - get Size for constraight
    func getRightHeight(model: PhotoModel,frame: CGFloat)-> CGFloat {
        return frame / ((model.size?.width ?? 140 )! / (model.size?.height ?? 140)!)
    }
}

//MARK: - prepare for segue
extension ApartFromCollectionVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "mapSegue", let dest = segue.destination as? MapVC else {
            return
        }
        dest.object = object
    }
}
