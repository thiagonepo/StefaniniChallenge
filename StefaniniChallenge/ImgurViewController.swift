//
//  ImgurViewController.swift
//  StefaniniChallenge
//
//  Created by Gael on 14/12/21.
//

import UIKit



class ImgurViewController: UICollectionViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    private let reuseIdentifier = "ImgurCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    private let itemsPerRow: CGFloat = 4
    private let network = NetworkService()

    override func viewDidLoad() {
        super.viewDidLoad()
        network.setupDelegate(delegate: self)
        searchTextField.delegate = self
        network.loadImage(with: "cats")
        collectionView.register(UINib(nibName: "ImgurPhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ImgurPhotoCollectionViewCell")

    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return network.searches?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? ImgurCollectionViewCell else { return UICollectionViewCell() }
        
        let photo = network.searches?[indexPath.row] ?? Image(id: "", link: "")
        cell.cellSetup(with: photo)
        return cell
    }

}

// MARK: - Collection View Flow Layout Delegate

extension ImgurViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        sectionInsets.left
    }
    
}

//MARK: - NetworkServiceProtocol

extension ImgurViewController: NetworkServiceProtocol {
    func success() {
        collectionView.reloadData()
    }
    
    func failed(error: Error) {
        print(error)
    }
}

extension ImgurViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let image = searchTextField.text {
            network.loadImage(with: image)
        }
        searchTextField.text = ""
    }
}

