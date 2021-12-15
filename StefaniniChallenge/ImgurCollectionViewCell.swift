//
//  ImgurCollectionViewCell.swift
//  StefaniniChallenge
//
//  Created by Gael on 15/12/21.
//

import UIKit

class ImgurCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ImgurPhoto: UIImageView!
    
    func cellSetup(with image: Image){
        ImgurPhoto.downloadImage(from: image.link)
    }
}
