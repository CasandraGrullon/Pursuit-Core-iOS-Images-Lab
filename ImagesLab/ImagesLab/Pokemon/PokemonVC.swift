//
//  PokemonVC.swift
//  ImagesLab
//
//  Created by casandra grullon on 12/8/19.
//  Copyright © 2019 casandra grullon. All rights reserved.
//

import UIKit

class PokemonVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
}
extension PokemonVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonCell else {
            fatalError("cell issue")
        }
        let poke = pokemon[indexPath.row]
        
        cell?.configureCell(for: poke)
        
        return cell
    }
}

extension PokemonVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
        
    }
}
