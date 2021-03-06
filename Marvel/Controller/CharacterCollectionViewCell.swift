//
//  CharacterCollectionViewCell.swift
//  Marvel
//
//  Created by Anton Kuznetsov on 8/27/19.
//  Copyright © 2019 AntonKuznetsov. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var characterImage: ImageView!
    @IBOutlet weak var characterName: UILabel!
    
    // MARK: - Public Methods
    
    func configure(with character: Character) {
        characterName.text = character.name
        characterImage.fetchImage(with: character.thumbnail)
    }
}
