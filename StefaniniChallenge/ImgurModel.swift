//
//  ImgurModel.swift
//  StefaniniChallenge
//
//  Created by Gael on 15/12/21.
//

import Foundation

struct ImgurModel : Codable {
    let data:[Image]?
}

struct Image : Codable {
    
    let id:String?
    let link:String?
}
