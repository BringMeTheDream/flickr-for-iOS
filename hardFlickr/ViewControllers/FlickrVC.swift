//
//  ViewController.swift
//  hardFlickr
//
//  Created by Андрей Коноплев on 22.09.17.
//  Copyright © 2017 Андрей Коноплев. All rights reserved.
//

import UIKit


class FlickrVC: UIViewController {

    //MARK: - vars
    var refreshControl:UIRefreshControl!
    var photosArray = [PhotoModel]()
    var loadingMoreStatus =  false
    
    //MARK: - outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var mainLoadIdentifier: UIActivityIndicatorView!
    @IBOutlet weak var loadIdentifier: UIActivityIndicatorView!
    @IBOutlet weak var loadLabel: UILabel!
    
    //MARK: - load
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 20
        tableView.register(UINib(nibName: "FlickrCellVC", bundle: nil), forCellReuseIdentifier: "photoCell")
        mainLoadingTape()
        tableView.tableFooterView?.isHidden = true
        
        sendRequest()
    }
}


//MARK: -  create tableView cells
extension FlickrVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as! FlickrCellVC
        cell.configure(object: photosArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == photosArray.count - 1 {

            loadingMoreData(indexPath: indexPath.row)
            print("\(photosArray.count) indePath.row == \(indexPath.row)")
        }

        if indexPath.row >= constant.Api_const.photoCount - 1 {
            endLoading()
        }
//
        // если раскоментишь код сверху то он выведет первые 30 фоток вместо 10, то есть сработает функция сформировать первые 10, потом не доходя до 10 ячейки сработает функция в willDisplay удовлетворяя условию что indexPath.row == 9, и потом на 20 тоже, удовлетворяя условию что indexPath.row == 19, как выведет 30 фоток начинает работать корректно. Проверка в самой функции какой сейчас indexPath.row
       
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 9 {
            print("fuck")
        }
    }
}

//MARK: - functions for show data in cell
extension FlickrVC {
//MARK: - load first 10 posts
    fileprivate func sendRequest() {
        DataTapeStorage.dataTapeStorage.setObjectForTape(num: 0, objectsArray: DataStorage.dataStorage.objectsArray)
        PhotoCreateManager.getSizePhoto(PhotoModelArray: DataTapeStorage.dataTapeStorage.objectsArrayForTape) { [weak self] in
            DispatchQueue.main.async { [weak self] in
                self?.photosArray.append(contentsOf: DataTapeStorage.dataTapeStorage.objectsArrayForTape)
                self?.tableView.reloadData()
                self?.mainLoadingTape()
            }
        }

    }
}


extension FlickrVC {
//MARK: - load new posts when scroll
    fileprivate func loadingMoreData(indexPath: Int) {
        if !loadingMoreStatus {
            self.loadIdentifier.startAnimating()
            self.tableView.tableFooterView?.isHidden = false
            loadMore(indexPath: indexPath)
        }
    }
    
    func loadMore(indexPath: Int) {
            DataTapeStorage.dataTapeStorage.objectsArrayForTape.removeAll()
            DataTapeStorage.dataTapeStorage.setObjectForTape(num: photosArray.count, objectsArray: DataStorage.dataStorage.objectsArray)
            PhotoCreateManager.getSizePhoto(PhotoModelArray: DataTapeStorage.dataTapeStorage.objectsArrayForTape) { [weak self] in
                DispatchQueue.main.async { [weak self] in
                    self?.photosArray.append(contentsOf: DataTapeStorage.dataTapeStorage.objectsArrayForTape)
                    self?.tableView.reloadData()
                }
            }
    }
}

extension FlickrVC {
//MARK: - loading view
    func mainLoadingTape() {
        if photosArray.count == 0 {
            mainLoadIdentifier.startAnimating()
        } else {
            mainLoadIdentifier.isHidden = true
        }
    }
    
    func endLoading() {
        loadLabel.text = "Всего \(photosArray.count) фото"
        loadIdentifier.isHidden = true
    }
}
