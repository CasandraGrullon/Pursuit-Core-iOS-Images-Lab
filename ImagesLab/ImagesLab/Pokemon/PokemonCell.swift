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
    
    var pokemon: Pokemon?
    
    func configureCell(for poke: Pokemon){
        guard let cellPokemon = pokemon?.cards else {
            return
        }
        NetworkHelper.shared.performDataTask(with: cellPokemon.first?.imageURL ?? "") { (result) in
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let data):
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.pokemonThumbImage.image = image
                }
            }
        }
    }
}
