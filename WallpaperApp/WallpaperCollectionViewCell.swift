//
//  WallpaperCollectionViewCell.swift
//  WallpaperApp
//
//  Created by MAA on 26.09.2022.
//

import UIKit
import Firebase

class WallpaperCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var wallpaperImageView: UIImageView!
    //@IBOutlet var likeLabel: UILabel!
    //@IBOutlet var documentIdLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    
        
    }
    
    /*@IBAction func likeButtonClicked(_ sender: Any) {
        let fireStoreDatabase = Firestore.firestore()
        
        if let likeCount = Int(likeLabel.text!) {
            let likeStore = ["likes": likeCount + 1] as [String : Any]
            fireStoreDatabase.collection("Posts").document(documentIdLabel.text!).setData(likeStore, merge: true)
        }
    }*/
}
