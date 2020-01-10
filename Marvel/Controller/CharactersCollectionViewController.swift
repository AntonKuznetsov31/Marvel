//
//  CharactersCollectionViewController.swift
//  Marvel
//
//  Created by Anton Kuznetsov on 8/27/19.
//  Copyright © 2019 AntonKuznetsov. All rights reserved.
//

import UIKit

class CharactersCollectionViewController: UICollectionViewController {
    
    // MARK: - Private Properties
    
    private var characters: [Character] = []
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.fetchCharacters { (characters) in
            self.characters = characters
            self.collectionView.reloadData()
        }
    }
}

// MARK: - Collection View Controller Data Source

extension CharactersCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as! CharacterCollectionViewCell
        
        cell.configure(with: characters[indexPath.row])
        
        return cell
    }
}

// MARK: - Collection View Controller Delegate

extension CharactersCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width: 160, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 30
    }
}
