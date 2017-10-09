//
//  CollectionVC.swift
//  hardFlickr
//
//  Created by Андрей Коноплев on 27.09.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit

class CollectionVC: UIViewController {
    
    //MARK: - vars
    let insetBetweenItems = 2
    let refreshControl = UIRefreshControl()
    var selectedPhoto: PhotoModel?
    
    //MARK: - outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - load
    override func viewDidLoad() {
        super.viewDidLoad()
        sendRequst()
        refreshController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    
}

//MARK: - pull to refresh
extension CollectionVC {
    func refreshController() {
        refreshControl.attributedTitle = NSAttributedString(string: "Обновляеться")
        refreshControl.addTarget(self, action: #selector(sendRequst) , for: UIControlEvents.valueChanged)
        collectionView.addSubview(refreshControl)
    }
    
}

//MARK: - create CollectionView
extension CollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return DataStorage.dataStorage.objectsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! CollectionViewCell
            cell.configure(object: DataStorage.dataStorage.objectsArray[indexPath.row])
            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedPhoto = DataStorage.dataStorage.objectsArray[indexPath.row]
        performSegue(withIdentifier: "moreAboutPhoto", sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        print("fuck")
    }
}

//MARK: - show all images
extension CollectionVC {
    @objc fileprivate func sendRequst() {
        PhotoListManager.getPhotoListObject(success: { [weak self] (photoArray) in
            DispatchQueue.main.async { [weak self] in
                DataStorage.dataStorage.setObjects(array: photoArray)
                self?.collectionView.reloadData()
                self?.refreshControl.endRefreshing()
            }
        }) { (errorDescription) in
            let alertController = UIAlertController(title: "Ошибка", message:  errorDescription, preferredStyle: .alert)
            let action = UIAlertAction(title: "Ок", style: .default)
            alertController.addAction(action)
            self.present(alertController, animated: true, completion: nil)
            
        }
    }
    
}

//MARK: - touch collectionView Cell
//extension CollectionVC {
//    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
//        let cell = collectionView.cellForItem(at: indexPath)! as UICollectionViewCell
//    
//    }
//}

//MARK:- custom CollectionViewCell
extension CollectionVC: UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = getSizeItem(numbers: constant.Collection_option.numbersItemInLine)
        return size
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 2, left: 0, bottom: 0, right: 0)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(insets(size: getSizeItem(numbers: constant.Collection_option.numbersItemInLine)))
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(0)
    }
}

//MARK: - custom functions for size cell in Collection
extension CollectionVC {
    
    func getSizeItem(numbers: Int) -> CGSize {
        var width: Double
        let screenWidth = UIScreen.main.bounds.width
        width = (Double(screenWidth) - Double(insetBetweenItems)) / Double((numbers))
        let size = CGSize(width: width, height: width)
        return size
    }
    
    func insets(size: CGSize) -> Double {
        let screenWidth = UIScreen.main.bounds.width
        return (Double(screenWidth) - Double(size.width) * Double(constant.Collection_option.numbersItemInLine))
        
    }
}

//MARK: - prepare for segue function
extension CollectionVC {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard segue.identifier == "moreAboutPhoto", let dest = segue.destination as? ApartFromCollectionVC else {
            return
        }
        dest.object = selectedPhoto
    }
}
