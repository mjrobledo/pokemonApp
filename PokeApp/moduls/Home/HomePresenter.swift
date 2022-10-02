//
//
// HomePresenter.swift
// PokeApp
//
// Using Swift 5.0
//
// Created by Ing. Miguel de Jesús Robledo Vera on 28/09/22.
// Copyright (c) 2022 and Confidential to MIGUEL ROBLEDO All rights reserved.
//


import Foundation

protocol HomeProtocol : AnyObject {
    func hideLoader()
    func showLoader()
    func showError(_ message: String)
     
    func reloadData()
    func reloadTypesPokemonData()
}

protocol HomePresenterProtocol {
    var pokemons: [Pokemon] { get set }
   
    func removePokemons()
    func getPokemons()
    func getPokemonsByType( _ name: String)
    func searchPokemon(_ text: String )
}


class HomePresenter: HomePresenterProtocol {
    
    
    private weak var delegate: HomeProtocol?
    
    private var countPokemons = 0
    private var next: String?
    
    init(delegate: HomeProtocol) {
        self.delegate = delegate
    }
    
    
    let remoteManager = APIClient()
    var pokemons = [Pokemon]()
    
    func getPokemons() {
        
        guard let delegate = delegate else {
            debugPrint("Error de conexión")
            return
        }
        
        delegate.showLoader()
        remoteManager.dataRequest(with: .pokemonList, body: nil, getParams: next, objectType: PokemonList.self) { response in
            self.delegate?.hideLoader()
            switch response {
            case .success(let data):
                self.countPokemons = data.count ?? 0
                
                guard let next = data.next else {
                    debugPrint("No hay más pokemon")
                    return
                }
                
                self.next = next
                
                guard let results = data.results else {
                    delegate.showError(.msgNotFound)
                    return
                }
                
                self.pokemons.append(contentsOf: results)
                delegate.reloadData()
            case .failure(let error):
                self.delegate?.showError(error.localizedDescription)
            }
        }
    }
    
    func getPokemonsByType(_ name: String) {
        guard let delegate = delegate else {
            return
        }
        next = nil
        delegate.showLoader()
        remoteManager.dataRequest(with: .pokemonType, body: nil, getParams: name.lowercased(), objectType: PokemonTypeResponse.self) { response in
            self.delegate?.hideLoader()
            switch response {
            case .success(let data):
                
                guard let results = data.pokemons else {
                    delegate.showError(.msgNotFound)
                    return
                }
                
                self.countPokemons = results.count
                
                self.pokemons = results.map({ pokemon in
                    return pokemon.pokemon ?? Pokemon()
                })
                
                DispatchQueue.main.async {
                    delegate.reloadTypesPokemonData()
                }
            case .failure(let error):
                self.delegate?.showError(error.localizedDescription)
            }
        }
    }
    
    
    func searchPokemon(_ text: String ) {
        guard let delegate = delegate else {
            return
        }
        
        delegate.showLoader()
        remoteManager.dataRequest(with: .pokemon, getParams: text.lowercased(), objectType: PokemonDetail.self) { response in
            
            delegate.hideLoader()
            switch response {
            case .success(let pokemon):
                
                self.pokemons = [Pokemon(name: pokemon.name, url: pokemon.sprites?.front_default)]
                
                DispatchQueue.main.async {
                    delegate.reloadTypesPokemonData()
                }
                
            case .failure( _ ):
                self.delegate?.showError(.msgNotFound)
            }
        }
    }
    
    func removePokemons() {
        self.next = nil
        self.pokemons.removeAll()
    }
}
