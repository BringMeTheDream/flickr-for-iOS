//
//  CollectionViewCell.swift
//  hardFlickr
//
//  Created by Андрей Коноплев on 27.09.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionImage: UIImageView!
    
    
    func configure(object: PhotoModel) {
        collectionImage.kf.setImage(with: URL(string: object.url ?? ""))
    }
    
    
    
}
