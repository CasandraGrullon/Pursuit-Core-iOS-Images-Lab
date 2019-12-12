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
    
    var pokemon = [Cards](){
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
        searchBar.delegate = self
        loadData()
    }
    func loadData(){
        PokemonAPI.getPokemon { (result) in
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let cards):
                self.pokemon = cards
            }
        }
    }
    func filterSearch(for searchText: String){
        pokemon = pokemon.filter{($0.types?.first?.lowercased() ?? "").contains(searchText.lowercased())}
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailVC = segue.destination as? PokemonDetailVC, let indexPath = tableView.indexPathForSelectedRow else {
            fatalError("segue issue")
        }
        detailVC.pokemon = pokemon[indexPath.row]
    }
}
extension PokemonVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemon.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonCell else {
            fatalError("cell issue")
        }
        
        let poke = pokemon[indexPath.row]
        
        cell.configureCell(for: poke)
        
        return cell
    }
}

extension PokemonVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 600
        
    }
}

extension PokemonVC: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            loadData()
            return
        }
        filterSearch(for: searchText)
    }
    }

