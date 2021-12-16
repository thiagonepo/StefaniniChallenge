//
//  ImgurCollectionViewCell.swift
//  StefaniniChallenge
//
//  Created by Gael on 15/12/21.
//

import UIKit

class ImgurCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var ImgurPhoto: UIImageView!
    
    func cellSetup(with image: Datum){
        guard let cover = image.cover else { return }
        let imageUrl: String = "https://i.imgur.com/\(cover).jpeg"
        ImgurPhoto.downloadImage(from: imageUrl)
    }
}
