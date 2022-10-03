//
//  WallpaperDetailViewController.swift
//  WallpaperApp
//
//  Created by MAA on 3.10.2022.
//

import UIKit

class WallpaperDetailViewController: UIViewController {

    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var wallpaperImage: UIImageView!
    
    var selectedWallpaper: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        backgroundImage.sd_setImage(with: URL(string: selectedWallpaper!))
        wallpaperImage.sd_setImage(with: URL(string: selectedWallpaper!))
        wallpaperImage.layer.cornerRadius = 20
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        UIImageWriteToSavedPhotosAlbum(wallpaperImage.image!, nil, nil, nil)
        
        let alert = UIAlertController(title: "Saved", message: "Your image has been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
