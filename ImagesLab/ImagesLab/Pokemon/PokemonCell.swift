//
//  PokemonCell.swift
//  ImagesLab
//
//  Created by casandra grullon on 12/8/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {

    @IBOutlet weak var pokemonThumbImage: UIImageView!
    
    var pokemon: Cards?
    
    func configureCell(for poke: Cards){
        pokemonThumbImage.getImage(with: poke.imageUrl) { [weak self] (result) in
            switch result{
            case .failure:
                DispatchQueue.main.async {
                    self?.pokemonThumbImage.image = UIImage(systemName: "exclamationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.pokemonThumbImage.image = image
                }
            }
        }
    }
}
