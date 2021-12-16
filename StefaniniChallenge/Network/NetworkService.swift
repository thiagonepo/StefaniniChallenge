//
//  NetworkService.swift
//  StefaniniChallenge
//
//  Created by Gael on 15/12/21.
//

import Foundation
import Alamofire

protocol NetworkServiceProtocol: AnyObject {
    
    func success()
    func failed(error: Error)
}

class NetworkService {

    private weak var delegate: NetworkServiceProtocol?
    var searches: [Datum]?
    
    func setupDelegate(delegate: NetworkServiceProtocol?) {
        self.delegate = delegate
    }
    
    func loadImage(with searchItem: String) {
        let headers: HTTPHeaders = ["Authorization" : "Client-ID 1ceddedc03a5d71"]
        
        AF.request("https://api.imgur.com/3/gallery/search?q=\(searchItem)", headers: headers).responseJSON { response in
            
            if response.response?.statusCode == 200 {
                
                if let data = response.data {
                    
                    do {
                        let result: ImgurModel = try JSONDecoder().decode(ImgurModel.self, from: data)
                        self.searches = result.data
                        self.delegate?.success()
                    } catch {
                        self.delegate?.failed(error: error)
                        print(error)
                    }
                }
            } else {
                print("error")
            }
        }

    }
}
