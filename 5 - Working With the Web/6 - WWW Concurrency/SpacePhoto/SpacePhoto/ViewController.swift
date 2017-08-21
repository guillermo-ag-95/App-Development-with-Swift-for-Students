//
//  ViewController.swift
//  SpacePhoto
//
//  Created by Guillermo Alcalá Gamero on 21/8/17.
//  Copyright © 2017 Guillermo Alcalá Gamero. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    
    let photoInfoController = PhotoInfoController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionLabel.text = ""
        copyrightLabel.text = ""
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
                self.updateUI(photoInfo: photoInfo)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func updateUI(photoInfo: PhotoInfo) {
        let task = URLSession.shared.dataTask(with: photoInfo.url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.title = photoInfo.title
                    self.descriptionLabel.text = photoInfo.description
                    self.photoImageView.image = image
                    if let copyright = photoInfo.copyright {
                        self.copyrightLabel.text = "Copyright: \(copyright)"
                    } else {
                        self.copyrightLabel.isHidden = true
                    }
                }
            }
        }
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        
        task.resume()
        
    }

}

