//
//  WallpaperViewController.swift
//  WallpaperApp
//
//  Created by MAA on 25.09.2022.
//

import UIKit
import Firebase
import SDWebImage

class WallpaperViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    
    var userEmailArray = [String]()
    var postTagArray = [String]()
    var postNameArray = [String]()
    var likeArray = [Int]()
    var imageArray = [String]()
    var documentIdArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        
        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        
        getDataFromFirestore()
    }
    
    func getDataFromFirestore() {
        
        let firestoreDatabase = Firestore.firestore()
        
        firestoreDatabase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            if error != nil {
                print(error?.localizedDescription ?? "n/A")
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.postTagArray.removeAll(keepingCapacity: false)
                    self.postNameArray.removeAll(keepingCapacity: false)
                    self.likeArray.removeAll(keepingCapacity: false)
                    self.imageArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let documentID = document.documentID
                        self.documentIdArray.append(documentID)
                        
                        if let postedBy = document.get("postedBy") as? String {
                            self.userEmailArray.append(postedBy)
                        }
                        
                        if let postTag = document.get("postTag") as? String {
                            self.postTagArray.append(postTag)
                        }
                        
                        if let postName = document.get("postName") as? String {
                            self.postNameArray.append(postName)
                        }
                        
                        if let likes = document.get("likes") as? Int {
                            self.likeArray.append(likes)
                        }
                        
                        if let imageUrl = document.get("imageUrl") as? String {
                            self.imageArray.append(imageUrl)
                        }
                    }
                    self.collectionView.reloadData()
                }
            }
        }
        /*let setting = firestoreDatabase.settings
        setting.areTimestampsInSnapshotEnabled = true
        firestoreDatabase.settings = setting*/
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectedItem = sender as? String else { return }
        
        if segue.identifier == "detail" {
            guard let destVC = segue.destination as? WallpaperDetailViewController else { return }
            
            destVC.selectedWallpaper = selectedItem
        }
    }
}

extension WallpaperViewController: UICollectionViewDelegate, UICollectionViewDataSource, PinterestLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! WallpaperCollectionViewCell
        //cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.wallpaperImageView.sd_setImage(with: URL(string: self.imageArray[indexPath.row]))
        //cell.documentIdLabel.text = documentIdArray[indexPath.row]
        cell.clipsToBounds = true
        cell.layer.cornerRadius = 15
        cell.wallpaperImageView.contentMode = .scaleToFill
        //.scaleAspectFit
        cell.backgroundColor = .red
        cell.wallpaperImageView.isUserInteractionEnabled = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath) -> CGFloat {
        //var image: UIImageView!
        //image.sd_setImage(with: URL(string: self.imageArray[indexPath.row]))
        /*if let height = image1?.size.height {
            return height / 4.0
        }*/
        let height = UIScreen.main.bounds.height / 1.8
        
        return height
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedWallpaper = imageArray[indexPath.row]
        self.performSegue(withIdentifier: "detail", sender: selectedWallpaper)
    }
    
}
