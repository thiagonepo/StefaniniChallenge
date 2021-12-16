//
//  ImgurModel.swift
//  StefaniniChallenge
//
//  Created by Gael on 15/12/21.
//

import Foundation

struct ImgurModel: Codable {
    let data: [Datum]?
}

struct Datum: Codable {
    let id: String?
    let title: String?
    let cover: String?
}


