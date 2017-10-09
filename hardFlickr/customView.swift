//
//  customView.swift
//  hardFlickr
//
//  Created by Андрей Коноплев on 25.09.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class avatarImage: UIImageView {
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: superview)
        
        setStyle()
    }
    
    private func setStyle() {
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 15
        layer.masksToBounds = true
    }
}
