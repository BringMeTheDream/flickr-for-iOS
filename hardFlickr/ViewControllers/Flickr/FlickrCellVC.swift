//
//  FlickrCellVC.swift
//  hardFlickr
//
//  Created by Андрей Коноплев on 22.09.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit
import Kingfisher

class FlickrCellVC: UITableViewCell {
    
    //MARK: - outlets
    @IBOutlet weak var flickrImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timePostedLabel: UILabel!
    @IBOutlet weak var heightConstraints: NSLayoutConstraint!
    
    
    //MARK:- configure cell
    func configure(object: PhotoModel) {
        let screenWidth = UIScreen.main.bounds.width
        flickrImage.kf.setImage(with: URL(string: object.url ?? ""), placeholder: nil, options: nil, progressBlock: nil) { (image, _, _, _) in
        }
        self.heightConstraints.constant = self.getRightHeight(model: object,frame: screenWidth)
        titleLabel.text = object.title
        userName.text = object.ownerName
        timePostedLabel.text = getRightTime(TimeInterval: object.dateUpload)
        prepareForReuse()
    }
    
}

extension FlickrCellVC {
    
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
