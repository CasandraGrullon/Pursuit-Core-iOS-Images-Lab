//
//  PokemonAPI.swift
//  ImagesLab
//
//  Created by casandra grullon on 12/8/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import Foundation

struct PokemonAPI {
    static func getPokemon(completion: @escaping(Result<[Cards], AppError>) -> ()) {

        let endpointURLString = "https://api.pokemontcg.io/v1/cards"

        NetworkHelper.shared.performDataTask(with: endpointURLString) { (result) in
            switch result {
            case .failure(let appError):
                completion(.failure(.networkClientError(appError)))
            case .success(let data):

                do{
                    let pokemonData = try JSONDecoder().decode(Pokemon.self, from: data)
                    let pokemon = pokemonData.cards
                    completion(.success(pokemon))
                    
                }catch{
                    completion(.failure(.decodingError(error)))
                }
            }
        }

    }
}
